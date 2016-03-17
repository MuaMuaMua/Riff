//
//  RiffNetworkManager.m
//  Riff
//
//  Created by wuhaibin on 16/3/10.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "RiffNetworkManager.h"

#import <AFNetworking.h>

@implementation RiffNetworkManager

+ (RiffNetworkManager *)sharedInstance {
    static RiffNetworkManager * _instance;
    @synchronized(self) {
        if (!_instance) {
            _instance = [[RiffNetworkManager alloc]init];
            //初始化 http 请求 manager
            _instance.networkManager = [[AFHTTPRequestOperationManager alloc]init];
            _instance.networkManager.requestSerializer = [[AFHTTPRequestSerializer alloc]init];
            _instance.networkManager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
            //设置超时 为60s
            _instance.networkManager.requestSerializer.timeoutInterval = 60;
            return _instance;
        }
    }
    return _instance;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

//用户注册
- (void)userSignupWithMobile:(NSString *)mobileNumber Pwd:(NSString *)password VerCode:(NSString *)verCode DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/register";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:mobileNumber forKey:@"mobile"];
    [params setObject:password forKey:@"password"];
    [params setObject:verCode forKey:@"code"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",responseData);
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
}

//用户登录
- (void)userSignInWithMobile:(NSString *)mobileNumber Pwd:(NSString *)password DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/login";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:mobileNumber forKey:@"mobile"];
    [params setObject:password forKey:@"password"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
}

//发送验证码
- (void)sendVerificationCodeWithMobile:(NSString *)mobileNumber DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/sendVerificationCode";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:mobileNumber forKey:@"mobile"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber * code = [responseData objectForKey:@"code"];
        if (code.intValue == 200) {
            dtzSuccessBlock(responseData);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
}

//判断验证码
- (void)checkVerificationCodeWithPN:(NSString *)phoneNumber VerificationCode:(NSString *)verificationCode DTZSuccessBlock:(DTZSuccessBlock)dtzsuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/checkVerificationCode";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:phoneNumber forKey:@"mobile"];
    [params setObject:verificationCode forKey:@"code"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSNumber * code = [responseData objectForKey:@"code"];
        if (code.intValue == 200) {
            // 验证成功
            dtzsuccessBlock(responseData);
        }else {
            //验证失败的策略
            dtzsuccessBlock(responseData);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
        NSLog(@"验证失败");
        //重写失败的block
    }];
}

//获取七牛token
- (void)getQNTokenWithDTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/qiniu/uptoken";
    url = [baseURL stringByAppendingString:url];
    [self.networkManager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
}

//获取链接URL
- (void)getClickUrlWithUserID:(NSString *)userId DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/ClickRel/getClickUrl";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:userId forKey:@"userId"];
    [params setObject:@"1" forKey:@"advertisementId"];
    [self.networkManager GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
}

//判断手机 是否存在  是否已经注册
- (void)isMobileExitWithMobileNumber:(NSString *)mobileNumber DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/isMobileExist";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:mobileNumber forKey:@"mobile"];
    [self.networkManager GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
}

//用户登出
- (void)userLogoutWithToken:(NSString *)token DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/logout";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:token forKey:@"token"];
    
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
    
    
}

//用户重置密码
- (void)userResetPwdWithMobile:(NSString *)mobileNumber NewPwd:(NSString *)newPwd VerCode:(NSString *)verCode DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/resetPassword";
    url = [baseURL stringByAppendingString:url];
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:mobileNumber forKey:@"mobile"];
    [params setObject:newPwd forKey:@"newPwd"];
    [params setObject:verCode forKey:@"code"];
    
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
}

//用户修改密码
- (void)userChangePwdWithOldPwd:(NSString *)oldPassword NewPwd:(NSString *)newPwd Token:(NSString *)token DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/passwd";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:oldPassword forKey:@"oldPass"];
    [params setObject:token forKey:@"token"];
    [params setObject:newPwd forKey:@"newPass"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSDictionary * errorDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器错误",@"msg", nil];
        dtzFailBlock(errorDictionary);
    }];
}

@end
