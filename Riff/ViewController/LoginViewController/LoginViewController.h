//
//  LoginViewController.h
//  Riff
//
//  Created by wuhaibin on 16/3/14.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextfield;

@property (strong, nonatomic) IBOutlet UITextField *pwdTextfield;

@property (strong, nonatomic) IBOutlet UIButton *signinBtn;

@property (strong, nonatomic) IBOutlet UIButton *signupBtn;

@property (strong, nonatomic) IBOutlet UIButton *forgetPwdBtn;

@end
