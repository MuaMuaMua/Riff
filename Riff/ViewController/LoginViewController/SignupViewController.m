//
//  SignupViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/14.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "SignupViewController.h"
#import "SetPwdViewController.h"
#import "RiffNetworkManager.h"
#import <MBProgressHUD.h>

@interface SignupViewController ()<UITextFieldDelegate> {
    
    IBOutlet UITextField *_pnTextfield;
    
    IBOutlet UITextField *_vcTextfield;
    
    IBOutlet UIButton *_sendVCodeBtn;
    
    IBOutlet UIButton *_nextBtn;
    
    IBOutlet UIImageView *_bgImageView;
    
    RiffNetworkManager * _riffNetworkManager;
    
    MBProgressHUD * _mbpHUD;
    
    NSTimer * _timer;
    
    int _secondCount;
    
    UIButton * _secondLabel;
}

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect winSize = [[UIScreen mainScreen]bounds];
//    _secondLabel = [[UIButton alloc]initWithFrame:CGRectMake(winSize.size.width - 120, winSize.size.height / 2 - 40, 73, 28)];
//	_secondLabel.layer.cornerRadius = 3;
//	_secondLabel.titleLabel.font = [UIFont systemFontOfSize:13];
//    _secondLabel.titleLabel.textAlignment = UITextAlignmentCenter;
//	[_secondLabel setTitle:@"获取验证码" forState:UIControlStateNormal];
//	_secondLabel.backgroundColor = [UIColor colorWithRed:75.0/255 green:60.0/255 blue:102.0/255 alpha:1];
//    _secondLabel.titleLabel.textColor = [UIColor whiteColor];
//    [_secondLabel addTarget:self action:@selector(clickVerCode) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_secondLabel];
    [self setupTapGesture];
    [self setupNetworkManager];
    [_nextBtn setBackgroundColor:[UIColor colorWithRed:97.0f/255 green:82.0f/255 blue:121.0f/255 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated {
	[_timer invalidate];
	_timer = nil;
}

#pragma mark - setupNetworkManager
- (void)setupNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
}

#pragma mark - textfield resignFirstResponser
- (void)setupTapGesture {
    _pnTextfield.delegate = self;
    _vcTextfield.delegate = self;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    _bgImageView.userInteractionEnabled = YES;
    tapGesture.numberOfTapsRequired = 1;
    [_bgImageView addGestureRecognizer:tapGesture];
}

- (void)tapAction {
    if (_pnTextfield.isFirstResponder) {
        [_pnTextfield resignFirstResponder];
    }else if (_vcTextfield.isFirstResponder) {
        [_vcTextfield resignFirstResponder];
    }
}

- (IBAction)clickNext:(id)sender {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    if (_vcTextfield.text.length != 6 && _pnTextfield.text.length != 11) {
        _mbpHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHUD.labelText = @"输入有误";
        _mbpHUD.mode = MBProgressHUDModeText;
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }else {
        _mbpHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHUD.labelText = @"正在验证";
        _mbpHUD.mode = MBProgressHUDModeIndeterminate;
        [_riffNetworkManager checkVerificationCodeWithPN:_pnTextfield.text VerificationCode:_vcTextfield.text DTZSuccessBlock:^(NSDictionary *successBlock) {
            NSLog(@"%@",successBlock);
            NSNumber * code = [successBlock objectForKey:@"code"];
            if (code.intValue == 200) {
                //验证成功
                _mbpHUD.labelText = @"验证成功";
                _mbpHUD.mode = MBProgressHUDModeText;
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [[NSUserDefaults standardUserDefaults]setObject:_pnTextfield.text forKey:@"mobile"];
                    [[NSUserDefaults standardUserDefaults]setObject:_vcTextfield.text forKey:@"verCode"];
                    if (_pnTextfield.isFirstResponder) {
                        [_pnTextfield resignFirstResponder];
                    }else if(_vcTextfield.isFirstResponder) {
                        [_vcTextfield resignFirstResponder];
                    }
                    SetPwdViewController * setPwdVC = [[SetPwdViewController alloc]init];
                    if (self.isSignupVC) {
                        setPwdVC.isSignup = YES;
                    }else {
                        setPwdVC.isSignup = NO;
                    }
                    [self.navigationController pushViewController:setPwdVC animated:YES];
                });
            }else if(code.intValue == 414) {
                _mbpHUD.labelText = @"验证码过期或无效";
                _mbpHUD.mode = MBProgressHUDModeText;
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            }
        } DTZFailBlock:^(NSDictionary *failBlock) {
            
        }];
    }
}


#pragma mark - setup Timer
- (void)setupTimer {
    // 计时器 是实现每秒读一次 累加
    if (_timer) {
        
    }else {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadVerCodeBtnTitle) userInfo:nil repeats:YES];
    }
}

- (void)reloadVerCodeBtnTitle {
    //计算timer
    NSLog(@"正在读秒");
    if (_secondCount <= 0) {
        //已经超时了 所以。。。
//        _secondLabel.enabled = YES;
//		_secondLabel.titleLabel.text = @"获取验证码";
		[_sendVCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
		_sendVCodeBtn.enabled = YES;
		
    }else {
        _secondCount --;
        NSString * secondStr = [NSString stringWithFormat:@"%d s",_secondCount];
		[_sendVCodeBtn setTitle:secondStr forState:UIControlStateNormal];
		_sendVCodeBtn .enabled = NO;
    }
}

- (IBAction)clickVerCode:(id)sender {
    if (_pnTextfield.text.length != 11) {
        _mbpHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHUD.labelText = @"手机号码长度不正确";
        _mbpHUD.mode = MBProgressHUDModeText;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }else {
        [_riffNetworkManager sendVerificationCodeWithMobile:_pnTextfield.text DTZSuccessBlock:^(NSDictionary *successBlock) {
            NSLog(@"%@",successBlock);
			_secondCount = 60;
			[self setupTimer];
        } DTZFailBlock:^(NSDictionary *failBlock) {
            NSLog(@"sisdfisnfi");
        }];
    }
}

@end
