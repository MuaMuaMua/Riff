//
//  ChangePwdVC.m
//  Riff
//
//  Created by wuhaibin on 16/3/23.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "ChangePwdVC.h"
#import "RiffNetworkManager.h"
#import <MBProgressHUD.h>

@interface ChangePwdVC () {
    
    IBOutlet UITextField *_oldPwdfield;
    
    IBOutlet UITextField *_newPwdfield;
    
    IBOutlet UITextField *_newPwdAgainfield;
    
    IBOutlet UIImageView *_bgImageView;
    
    IBOutlet UIButton *_doneBtn;
    
    RiffNetworkManager * _riffNetworkManager;
    
    MBProgressHUD * _mbpHud;
}

@end

@implementation ChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全";
    [self setupTapGesture];
    [self setupRiffNetworkManager];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupTapGesture 
- (void)setupTapGesture {
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tapGesture.numberOfTapsRequired = 1;
    _bgImageView.userInteractionEnabled = YES;
    [_bgImageView addGestureRecognizer:tapGesture];
}

- (void)tapAction {
    if (_oldPwdfield.isFirstResponder) {
        [_oldPwdfield resignFirstResponder];
    }else if (_newPwdAgainfield.isFirstResponder) {
        [_newPwdAgainfield resignFirstResponder];
    }else if (_newPwdfield.isFirstResponder) {
        [_newPwdfield resignFirstResponder];
    }
}

#pragma mark - riffNetworkManager setting 
- (void)setupRiffNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
}

#pragma mark - IBOutlet Action
- (IBAction)clickDone:(id)sender {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);

    if ((_oldPwdfield.text.length < 6)||(_newPwdAgainfield.text.length < 6)||(_newPwdfield.text.length < 6)) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"密码长度不低于6位";
        _mbpHud.mode = MBProgressHUDModeText;
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }else {
        if (![_newPwdfield.text isEqualToString:_newPwdAgainfield.text]) {
            _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _mbpHud.labelText = @"两次输入的新密码不一致";
            _mbpHud.mode = MBProgressHUDModeText;
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }else {
            [_riffNetworkManager userChangePwdWithOldPwd:_oldPwdfield.text NewPwd:_newPwdfield.text DTZSuccessBlock:^(NSDictionary *successBlock) {
                //设置新的信息
                NSLog(@"%@",successBlock);
                NSNumber * code = [successBlock objectForKey:@"code"];
                if (code.intValue == 200) {
                    _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    _mbpHud.labelText = @"修改成功";
                    _mbpHud.mode = MBProgressHUDModeText;
                    dispatch_after(popTime, dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                    _oldPwdfield.text = @"";
                    _newPwdfield.text = @"";
                    _newPwdAgainfield.text = @"";
                }else if (code.intValue == 501) {
                    _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    _mbpHud.labelText = @"原密码不正确";
                    _mbpHud.mode = MBProgressHUDModeText;
                    dispatch_after(popTime, dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    });
                }
            } DTZFailBlock:^(NSDictionary *failBlock) {
                _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _mbpHud.labelText = @"服务器故障，请稍后再试";
                _mbpHud.mode = MBProgressHUDModeText;
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            }];
        }
    }
}

@end
