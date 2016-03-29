//
//  SocialDataSource.m
//  Riff
//
//  Created by wuhaibin on 16/3/22.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "SocialDataSource.h"
#import "BasicInfoCell.h"

@implementation SocialDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * certif = @"BasicInfoCell";
    UINib * nib = [UINib nibWithNibName:certif bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:certif];
    
    BasicInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
    if (cell == nil) {
        cell = [[BasicInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"手机号码";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhoneNumber"]) {
            cell.contentLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhoneNumber"];
        }
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"郵箱";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"email"]) {
            cell.contentLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
        }else {
            cell.contentLabel.text = @"";
        }
    }else if (indexPath.row == 2) {
        cell.titleLabel.text = @"微信";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"weChat"]) {
            cell.contentLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"weChat"];
        }else {
            cell.contentLabel.text = @"";
        }
    }else if (indexPath.row == 3) {
        cell.titleLabel.text = @"微博";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"weibo"]) {
            cell.contentLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"weibo"];
        }else {
            cell.contentLabel.text = @"";
        }
    }else if (indexPath.row == 4) {
        cell.titleLabel.text = @"QQ";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"qq"]) {
            cell.contentLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"qq"];
        }else {
            cell.contentLabel.text = @"";
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}



@end
