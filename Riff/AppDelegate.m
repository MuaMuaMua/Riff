//
//  AppDelegate.m
//  Riff
//
//  Created by wuhaibin on 16/3/9.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "AppDelegate.h"
#import "RiffNavigationController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "WXApi.h"
#import <WeiboSDK.h>
#import "RiffNetworkManager.h"

@interface AppDelegate () <WXApiDelegate,WeiboSDKDelegate> {
    RiffNetworkManager * _riffNetworkManager;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册wechat
    [WXApi registerApp:@"wx3b77a200c4391e82"];
    //注册weibo
    [WeiboSDK registerApp:@"3802460133"];
    // 默认已经是8.0 以上的版本
    //判断是否由远程消息通知触发应用程序启动
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        long badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
    }
    //消息推送注册
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//     判断是否登陆过了，如果登陆过了，直接跳转到主界面。不需要登陆。
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginPhoneNumber"]) {
//        已经登录过了
        [self setupNavigationController];
    }else {
        [self setupLoginVC];
    }
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    return YES;
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    //收到weibo的请求
    NSLog(@"receive weibo request");

}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    //收到weibo的回调
    NSLog(@"receive weibo response");
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // 判断是来自 WeChat 还是Weibo 的请求。
    NSString *string =[url absoluteString];
    NSLog(@"%@",string);
    return [WeiboSDK handleOpenURL:url
                          delegate:self];
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"%@",url);
    return [WeiboSDK handleOpenURL:url delegate:self];
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onResp:(BaseResp *)resp {
    NSLog(@"收到回调");
}

- (void)onReq:(BaseReq *)req {
    NSLog(@"发出请求");
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"%@",deviceToken);
    NSLog(@"My token is:%@", token);
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    if(token != nil) {
        [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"deviceToken"];
    }
    //这里应将device token发送到服务器端
    NSLog(@"推送到服务器");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString * error_str = [NSString stringWithFormat:@"%@",error];
    NSLog(@"%@",error_str);
}

- (void)setupNavigationController {
    MainViewController * mainViewController = [[MainViewController alloc]init];
    RiffNavigationController * riffNavigationController = [[RiffNavigationController alloc]initWithRootViewController:mainViewController];
    self.window.rootViewController = riffNavigationController;
}

#pragma mark - setupLoginVC Navigation
- (void)setupLoginVC {
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    UINavigationController * navigator = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = navigator;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    for (id key in userInfo) {
//        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
//    }
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"remote notification" message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//    [alert show];
    // 更新新的webview 重新加载
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"ReloadKey"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadNewPassage" object:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
