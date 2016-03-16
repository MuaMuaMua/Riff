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
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    
    // 从缓存中获取到手机号码
    NSString * mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
    NSString * verCode = [[NSUserDefaults standardUserDefaults]objectForKey:@"verCode"];

    if (_pwdAgainTextfield.text.length < 6) {
        _mbpHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHUD.labelText = @"密码长度不能低于6位";
        _mbpHUD.mode = MBProgressHUDModeText;
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }else {
        if (![_pwdAgainTextfield.text isEqualToString:_pwdTextfield.text]) {
            
        }
    }
    [_riffNetworkManager userSignupWithMobile:mobile Pwd:_pwdAgainTextfield.text VerCode:verCode DTZSuccessBlock:^(NSDictionary *successBlock) {
        
    } DTZFailBlock:^(NSDictionary *failBlock) {
        
    }];
    
    _appDelegate = [UIApplication sharedApplication].delegate;
    [_appDelegate setupNavigationController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
