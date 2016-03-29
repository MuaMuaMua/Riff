//
//  SetPwdViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/14.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "SetPwdViewController.h"
#import "AppDelegate.h"
#import "RiffNetworkManager.h"
#import <MBProgressHUD.h>

@interface SetPwdViewController ()<UITextFieldDelegate> {
    
    IBOutlet UITextField *_pwdTextfield;
    
    IBOutlet UITextField *_pwdAgainTextfield;
    
    IBOutlet UIButton *_doneBtn;
    
    IBOutlet UIImageView *_bgImageView;
    
    AppDelegate * _appDelegate;
    
    RiffNetworkManager * _riffNetworkManager;
    
    MBProgressHUD * _mbpHUD;
}

@end

@implementation SetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_doneBtn setBackgroundColor:[UIColor colorWithRed:97.0f/255 green:82.0f/255 blue:121.0f/255 alpha:1]];
    [self setupTapGesture];
    [self setupNetworkManager];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(leaveEditMode)];
    self.navigationItem.rightBarButtonItem = done;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)leaveEditMode {
    [_pwdAgainTextfield resignFirstResponder];
    [_pwdTextfield resignFirstResponder];
}


#pragma mark - textfield resignFirstResponser
- (void)setupTapGesture {
    _pwdTextfield.delegate = self;
    _pwdAgainTextfield.delegate = self;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    _bgImageView.userInteractionEnabled = YES;
    tapGesture.numberOfTapsRequired = 1;
    [_bgImageView addGestureRecognizer:tapGesture];
}

- (void)tapAction {
    if (_pwdTextfield.isFirstResponder) {
        [_pwdTextfield resignFirstResponder];
    }else if (_pwdAgainTextfield.isFirstResponder) {
        [_pwdAgainTextfield resignFirstResponder];
    }
}

#pragma mark - setupNetworkManager 
- (void)setupNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
}

#pragma mark - IBAction

- (IBAction)clickDone:(id)sender {
    
    // 从缓存中获取到手机号码
    NSString * mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
    NSString * verCode = [[NSUserDefaults standardUserDefaults]objectForKey:@"verCode"];

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    if (_pwdAgainTextfield.text.length < 6) {
        _mbpHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHUD.labelText = @"密码长度不能低于6位";
        _mbpHUD.mode = MBProgressHUDModeText;
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }else if (![_pwdAgainTextfield.text isEqualToString:_pwdTextfield.text]) {
        _mbpHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHUD.labelText = @"两次输入的密码不一致";
        _mbpHUD.mode = MBProgressHUDModeText;
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }
    if (self.isSignup) {
        [_riffNetworkManager userSignupWithMobile:mobile Pwd:_pwdAgainTextfield.text VerCode:verCode DTZSuccessBlock:^(NSDictionary *successBlock) {
            //注册成功.
            NSNumber * code = [successBlock objectForKey:@"code"];
            if (code.intValue == 200) {
                _mbpHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _mbpHUD.labelText = @"注册成功";
                _mbpHUD.mode = MBProgressHUDModeText;
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            }
            //缓存保存user 信息
            [self saveUserInfo:[successBlock objectForKey:@"user"]];
            _appDelegate = [UIApplication sharedApplication].delegate;
            [_appDelegate setupNavigationController];
        } DTZFailBlock:^(NSDictionary *failBlock) {
            // 注册 失败.
        }];
    }else {
        // 修改密码
        //获取用户手机号码
        [_riffNetworkManager userResetPwdWithMobile:mobile NewPwd:_pwdTextfield.text VerCode:verCode DTZSuccessBlock:^(NSDictionary *successBlock) {
            NSNumber * code = [successBlock objectForKey:@"code"];
            if (code.intValue == 200) {
                //重置密码成功.直接跳转到登陆后的主界面
                //清空缓存，保存用户登陆后的信息.
                [self saveUserInfo:[successBlock objectForKey:@"user"]];
                
                _appDelegate = [UIApplication sharedApplication].delegate;
                [_appDelegate setupNavigationController];
                
            }
        } DTZFailBlock:^(NSDictionary *failBlock) {
            _mbpHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _mbpHUD.labelText = @"服务器故障";
            _mbpHUD.mode = MBProgressHUDModeText;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }];
    }
}

// 注册成功 .保存 用户信息
- (void)saveUserInfo:(NSDictionary *)userInfo {
    NSString * mobile = [userInfo objectForKey:@"mobile"];
    NSNumber * sex = [userInfo objectForKey:@"sex"];
    NSString * token = [userInfo objectForKey:@"token"];
    NSNumber * userId = [userInfo objectForKey:@"id"];
    NSString * username = [userInfo objectForKey:@"username"];
    NSString * weChat = [userInfo objectForKey:@"weChat"];
    NSString * weibo = [userInfo objectForKey:@"weibo"];
    NSString * qq = [userInfo objectForKey:@"qq"];
    NSString * email = [userInfo objectForKey:@"email"];
    NSString * district = [userInfo objectForKey:@"city"];
    [[NSUserDefaults standardUserDefaults]setObject:mobile forKey:@"loginPhoneNumber"];
    [[NSUserDefaults standardUserDefaults]setObject:mobile forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults]setObject:userId forKey:@"userId"];
    if (username) {
        [[NSUserDefaults standardUserDefaults]setObject:username forKey:@"username"];
    }
    if (weChat) {
        [[NSUserDefaults standardUserDefaults]setObject:weChat forKey:@"weChat"];
    }
    if (weibo) {
        [[NSUserDefaults standardUserDefaults]setObject:weibo forKey:@"weibo"];
    }
    if (email) {
        [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
    }
    if (district) {
        [[NSUserDefaults standardUserDefaults]setObject:district forKey:@"district"];
    }
    if (qq) {
        [[NSUserDefaults standardUserDefaults]setObject:qq forKey:@"qq"];
    }
    if (sex.intValue == 0) {
        //如果是0的话是没有设置过
    }else if (sex.intValue == 1) {
        [[NSUserDefaults standardUserDefaults]setObject:@"male" forKey:@"gender"];
    }else if (sex.intValue == 2) {
        [[NSUserDefaults standardUserDefaults]setObject:@"female" forKey:@"gender"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
