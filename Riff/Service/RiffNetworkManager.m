//
//  RiffNetworkManager.m
//  Riff
//
//  Created by wuhaibin on 16/3/10.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "RiffNetworkManager.h"
#import <AFNetworking.h>
#import <QiniuSDK.h>

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
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forKey:@"token"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]) {
        [params setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"] forKey:@"userId"];
    }
    
    [self.networkManager GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
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
- (void)userLogoutWithTokenwithDTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/logout";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"token"] forKey:@"token"];
    [params setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"] forKey:@"userId"];
    
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
- (void)userChangePwdWithOldPwd:(NSString *)oldPassword NewPwd:(NSString *)newPwd DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/passwd";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:oldPassword forKey:@"oldPass"];
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSNumber * userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    [params setObject:token forKey:@"token"];
    [params setObject:userId forKey:@"userId"];
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

//获取新的 链接.
- (void)getNewAdvWithDTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/advertisement/getNewAdvertisementByUserId";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSNumber * userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    [params setObject:token forKey:@"token"];
    [params setObject:userId forKey:@"userId"];
    
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * responseError = [NSDictionary dictionaryWithObject:@"服务器错误" forKey:@"response"];
        dtzFailBlock(responseError);
    }];
}

//修改用户一般的属性
- (void)userChangeUserInfoWithProperty:(NSString *)propertyName PropertyValue:(NSString *)propertyValue DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock{
    NSString * url = @"/user/editUserCommonInfo";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:propertyName forKey:@"propertyName"];
    [params setObject:propertyValue forKey:@"propertyValue"];
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSNumber * userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    [params setObject:token forKey:@"token"];
    [params setObject:userId forKey:@"userId"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * responseData = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器故障",@"response", nil];
        dtzFailBlock(responseData);
    }];
}

//用户修改性别.
- (void)userChangeUserSexInfoWithGender:(NSString *)gender DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/editSex";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:gender,@"sexInfo", nil];
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSNumber * userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    [params setObject:token forKey:@"token"];
    [params setObject:userId forKey:@"userId"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * responseData = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器故障",@"response", nil];
        dtzFailBlock(responseData);
    }];
}

//上传用户头像到服务器
- (void)uploadUserAvatarUrlWithUrl:(NSString *)urlStr DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/uploadUserAvatar";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"userId"];
    [params setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"token"] forKey:@"token"];
    [params setObject:urlStr forKey:@"avatarUrl"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * responseData = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器故障",@"response",nil];
        dtzFailBlock(responseData);
    }];
}

- (void)saveDeviceTokenWithDeviceToken:(NSString *)deviceToken DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/user/saveDeviceToken";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forKey:@"token"];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]) {
        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"userId"];
    }
    [params setObject:deviceToken forKey:@"deviceToken"];
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * response = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器出错",@"response", nil];
        dtzFailBlock(response);
    }];
}

- (void)userWithdrawWithDTZSuccess:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/Withdraw/withdrawCash";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"]) {
        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]forKey:@"token"];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]) {
        [params setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"] forKey:@"userId"];
    }
    [self.networkManager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * responseData = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器故障",@"response", nil];
        dtzFailBlock(responseData);
    }];
}

//头像data 上传至 七牛
- (void)uploadAvatarToQNServerWithImageData:(NSData *)imageData Key:(NSString *)key UploadToken:(NSString *)uploadToken DTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    QNUploadManager * upManager = [[QNUploadManager alloc]init];
    [upManager putData:imageData key:key token:uploadToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (info.statusCode == 200) {
            NSString * avatarUrl = [QNDomain stringByAppendingString:[NSString stringWithFormat:@"//%@",key]];
            [[NSUserDefaults standardUserDefaults]setObject:avatarUrl forKey:@"avatar"];
            dtzSuccessBlock(nil);
        }else {
            dtzFailBlock(nil);
        }
    } option:nil];
}

- (void)countNotWithdrawWithDTZSuccessBlock:(DTZSuccessBlock)dtzSuccessBlock DTZFailBlock:(DTZFailBlock)dtzFailBlock {
    NSString * url = @"/ClickRel/findNotWithdrawClickRel";
    url = [baseURL stringByAppendingString:url];
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
        [params setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"token"] forKey:@"token"];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userId"]) {
        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"userId"];
    }
    [self.networkManager GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary * responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dtzSuccessBlock(responseData);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary * response = [[NSDictionary alloc]initWithObjectsAndKeys:@"服务器故障",@"response", nil];
        dtzFailBlock(response);
    }];
}

@end