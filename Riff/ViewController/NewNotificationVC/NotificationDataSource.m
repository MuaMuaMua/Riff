//
//  NotificationDataSource.m
//  Riff
//
//  Created by wuhaibin on 16/3/24.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "NotificationDataSource.h"
#import "ReceiveCell.h"
#import "SAndShakeCell.h"
#import <UIKit/UIKit.h>

@implementation NotificationDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //判断是第一个section
        NSString * certif = @"ReceiveCell";
        UINib * nib =  [UINib nibWithNibName:certif bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:certif];
        ReceiveCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
        if (cell == nil) {
            cell = [[ReceiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //判断设置 是否开启了新通知消息
        
        
        
        cell.contentLabel.text = @"已关闭";
        return cell;
    }else if (indexPath.section == 1) {
        NSString * certif = @"SAndShakeCell";
        UINib * nib = [UINib nibWithNibName:certif bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:certif];
        SAndShakeCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
        if (cell == nil) {
            cell = [[SAndShakeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else {
        return 2;
    }
    
    return 2;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    if ( section == 0 ) {
//        return @"如果关闭或开启Riff的新讯息通知，请在IPhone的“设定”-“通知”功能中，找到应用程序“Riff”进行变更";
//    }else {
//        return @"当Riff在执行时，你可以设定是否需要声音或者震动";
//    }
//}

@end
