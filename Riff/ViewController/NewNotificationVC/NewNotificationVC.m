//
//  NewNotificationVC.m
//  Riff
//
//  Created by wuhaibin on 16/3/24.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "NewNotificationVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NotificationDataSource.h"
#import "ReceiveCell.h"
#import "SAndShakeCell.h"
#import <UIKit/UIKit.h>

@interface NewNotificationVC () {
    NotificationDataSource * _dataSource;
    NSString * _notificationType;
}

@end

@implementation NewNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新通知";
    UIUserNotificationSettings * settings = [[UIApplication sharedApplication]currentUserNotificationSettings];
    if (UIUserNotificationTypeNone == settings.types) {
        _notificationType = @"已关闭";
    }else {
        _notificationType = @"已开启";
    }
    [_tableView reloadData];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {

}

#pragma mark - setupTableView delegate
- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect winSize = [[UIScreen mainScreen]bounds];
    if (section == 0) {
        UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, winSize.size.width, 80)];
        footView.backgroundColor = [UIColor clearColor];
        UILabel * contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, winSize.size.width - 40, 60)];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.text = @"如果关闭或开启Riff的新讯息通知，请在IPhone的“设定”-“通知”功能中，找到应用程序“Riff”进行变更";
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.numberOfLines = 0;
        [footView addSubview:contentLabel];
        return footView;
    }else {
        UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, winSize.size.width, 80)];
        footView.backgroundColor = [UIColor clearColor];
        UILabel * contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, winSize.size.width - 40, 60)];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.text = @"当Riff在执行时，你可以设定是否需要声音或者震动";
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.numberOfLines = 0;
        [footView addSubview:contentLabel];
        return footView;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80;
}

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
        cell.contentLabel.text = _notificationType;
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

@end
