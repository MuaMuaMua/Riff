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
}

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTapGesture];
    [self setupNetworkManager];
    [_nextBtn setBackgroundColor:[UIColor colorWithRed:97.0f/255 green:82.0f/255 blue:121.0f/255 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        } DTZFailBlock:^(NSDictionary *failBlock) {
            NSLog(@"sisdfisnfi");
        }];
    }
}

@end
