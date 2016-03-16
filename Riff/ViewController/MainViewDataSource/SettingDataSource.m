//
//  SettingDataSource.m
//  Riff
//
//  Created by wuhaibin on 16/3/9.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "SettingDataSource.h"
#import "BasicInfoCell.h"
#import "ExitCell.h"

#define winSize [[UIScreen mainScreen]bounds]

@implementation SettingDataSource




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString * certif = @"BasicInfoCell";
        UINib * nib = [UINib nibWithNibName:certif bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:certif];
        BasicInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];    
        if ( cell == nil ) {
            cell = [[BasicInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"通知";
                break;
            case 1:
                cell.titleLabel.text = @"隐私";
                break;
            case 2:
                cell.titleLabel.text = @"評價";
                break;
            case 3:
                cell.titleLabel.text = @"關於";
                break;
            case 4:
                cell.titleLabel.text = @"安全";
                break;
            default:
                break;
        }
        cell.titleLabel.textColor = [UIColor colorWithRed:94.0/255 green:80.0/255 blue:120.0/255 alpha:1];
        cell.separatorView.backgroundColor = [UIColor colorWithRed:94.0/255 green:80.0/255 blue:120.0/255 alpha:1];
        return cell;
    }else {
        static NSString * certif2 = @"ExitCell";
        UINib * nib = [UINib nibWithNibName:@"ExitCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:certif2];
        ExitCell * cell = [tableView dequeueReusableCellWithIdentifier:certif2];
        if (cell == nil) {
            cell = [[ExitCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif2];
        }
        if (winSize.size.width == 320) {
            [cell.exitBtn setBackgroundImage:[UIImage imageNamed:@"5EXITBTN"] forState:UIControlStateNormal];
        }else if (winSize.size.width == 375) {
            [cell.exitBtn setBackgroundImage:[UIImage imageNamed:@"6EXITBTN"] forState:UIControlStateNormal];
        }else if (winSize.size.width == 414) {
            [cell.exitBtn setBackgroundImage:[UIImage imageNamed:@"6PEXITBTN"] forState:UIControlStateNormal];
        }
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 5;
    }else {
        return 1;
    }
    
//    return 5;
}

@end
