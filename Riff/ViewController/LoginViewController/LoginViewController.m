//
//  LoginViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/14.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SignupViewController.h"
#import "RiffNetworkManager.h"
#import <MBProgressHUD.h>

@interface LoginViewController ()<UITextFieldDelegate> {
    AppDelegate * _appDelegate;
    
    IBOutlet UIImageView *_bgImageView;
    
    RiffNetworkManager * _riffNetworkManager;
    
    MBProgressHUD * _mbpHud;
}

@end

@implementation LoginViewController

#pragma mark - viewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNetworkManager];
    self.navigationController.navigationBar.hidden = YES;
    [self setupTapGesture];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupNetworkManager 
- (void)setupNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
}

#pragma mark - setupTapGesture
- (void)setupTapGesture {
    _pwdTextfield.delegate = self;
    _phoneNumberTextfield.delegate = self;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tapGesture.numberOfTapsRequired = 1;
    _bgImageView.userInteractionEnabled = YES;
    [_bgImageView addGestureRecognizer:tapGesture];
}

- (void)tapAction {
    [_phoneNumberTextfield resignFirstResponder];
    [_pwdTextfield resignFirstResponder];
}

#pragma mark - IBAction connection

- (IBAction)clickSignIn:(id)sender {
//    _appDelegate = [UIApplication sharedApplication].delegate;
//    
//    [_appDelegate setupNavigationController];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);

    if (_phoneNumberTextfield.text.length != 11) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"手机号码长度不正确";
        _mbpHud.mode = MBProgressHUDModeText;
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }else if (_pwdTextfield.text.length < 6) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.mode = MBProgressHUDModeText;
        _mbpHud.labelText = @"密码长度不少于6位";
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }else {
        // 判断输入格式没有问题 调用登陆接口
        [_riffNetworkManager userSignInWithMobile:_phoneNumberTextfield.text Pwd:_pwdTextfield.text DTZSuccessBlock:^(NSDictionary *successBlock) {
            NSLog(@"%@",successBlock);
            //保存用户的信息入 nsuserDefault中 未实现
            NSNumber * code = [successBlock objectForKey:@"code"];
            if (code.intValue == 201) {
                // 登陆成功 保存 用户信息 直接切换到登陆过后的navigationController
                [self saveUserInfo:[successBlock objectForKey:@"user"]];
                //跳转
                _appDelegate = [UIApplication sharedApplication].delegate;
                [_appDelegate setupNavigationController];
            }else if (code.intValue == 405) {
                _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _mbpHud.labelText = @"账号或密码错误";
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
    NSString * avatarUrl = [userInfo objectForKey:@"avatar"];
    [[NSUserDefaults standardUserDefaults]setObject:mobile forKey:@"loginPhoneNumber"];
    [[NSUserDefaults standardUserDefaults]setObject:mobile forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults]setObject:userId forKey:@"userId"];
    if (avatarUrl) {
        [[NSUserDefaults standardUserDefaults]setObject:avatarUrl forKey:@"avatarUrl"];
    }
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

- (IBAction)clickSignup:(id)sender {
    SignupViewController * signupViewController = [[SignupViewController alloc]init];
    signupViewController.isSignupVC = YES;
    [self.navigationController pushViewController:signupViewController animated:YES];
}

- (IBAction)clickForgetPwd:(id)sender {
    SignupViewController * signupViewController = [[SignupViewController alloc]init];
    signupViewController.isSignupVC = NO;
    [self.navigationController pushViewController:signupViewController animated:YES];
}

#pragma mark - textfield delegate 


#pragma mark - network block

@end
