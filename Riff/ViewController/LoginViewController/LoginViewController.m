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

@interface LoginViewController ()<UITextFieldDelegate> {
    AppDelegate * _appDelegate;
    
    
    IBOutlet UIImageView *_bgImageView;
    
}

@end

@implementation LoginViewController

#pragma mark - viewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setupTapGesture];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _appDelegate = [UIApplication sharedApplication].delegate;
    
    [_appDelegate setupNavigationController];
}

- (IBAction)clickSignup:(id)sender {
    SignupViewController * signupViewController = [[SignupViewController alloc]init];
    [self.navigationController pushViewController:signupViewController animated:YES];
    
}

- (IBAction)clickForgetPwd:(id)sender {
    
    
}

#pragma mark - textfield delegate 


#pragma mark - network block




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
