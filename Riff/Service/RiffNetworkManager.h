//
//  RiffNetworkManager.h
//  Riff
//
//  Created by wuhaibin on 16/3/10.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define baseURL @"http://120.24.93.146:8088"

typedef void (^ DTZSuccessBlock)(NSDictionary * successBlock);
typedef void (^ DTZFailBlock)(NSDictionary * failBlock);

@interface RiffNetworkManager : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager * networkManager;

+ (RiffNetworkManager *)sharedInstance;

- (id)init;

- (void)userSignupWithMobile:(NSString *)mobileNumber Pwd:(NSString *)password VerCode:(NSString *)verCode DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)userSignInWithMobile:(NSString *)mobileNumber Pwd:(NSString *)password DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)getQNTokenWithDTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)sendVerificationCodeWithMobile:(NSString *)mobileNumber DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)checkVerificationCodeWithPN:(NSString *)phoneNumber VerificationCode:(NSString *)verificationCode DTZSuccessBlock:(DTZSuccessBlock)dtzsuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)userLogoutWithToken:(NSString *)token DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)userResetPwdWithMobile:(NSString *)mobileNumber NewPwd:(NSString *)newPwd VerCode:(NSString *)verCode DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)userChangePwdWithOldPwd:(NSString *)oldPassword NewPwd:(NSString *)newPwd Token:(NSString *)token DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)getClickUrlWithUserID:(NSString *)userId DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;

- (void)isMobileExitWithMobileNumber:(NSString *)mobileNumber DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock;


@end
