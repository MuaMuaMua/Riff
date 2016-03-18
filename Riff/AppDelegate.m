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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self setupNavigationController];
    
    //注册APNS
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    
//#ifdef __IPHONE_8_0 //这里主要是针对iOS 8.0,相应的8.1,8.2等版本各程序员可自行发挥，如果苹果以后推出更高版本还不会使用这个注册方式就不得而知了……
    
//    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {

//    }

//    UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
//    
//    UIUserNotificationSettings *settings =[UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
//    
//    [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
    
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
//    [self setupLoginVC];
    [self setupNavigationController];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"%@",deviceToken);
    NSLog(@"My token is:%@", token);
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
    //
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    /* eg.
     key: aps, value: {
     alert = "\U8fd9\U662f\U4e00\U6761\U6d4b\U8bd5\U4fe1\U606f";
     badge = 1;
     sound = default;
     }
     */
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"remote notification" message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [alert show];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
