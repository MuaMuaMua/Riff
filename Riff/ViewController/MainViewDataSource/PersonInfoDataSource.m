//
//  PersonInfoDataSource.m
//  Riff
//
//  Created by wuhaibin on 16/3/9.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "PersonInfoDataSource.h"
#import "PersonalFirstCell.h"
#import "PersonalSecondCell.h"


@implementation PersonInfoDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * certif1 = @"PersonalFirstCell";
    static NSString * certif2 = @"PersonalSecondCell";
    
    UINib * nib1 = [UINib nibWithNibName:certif1 bundle:nil];
    UINib * nib2 = [UINib nibWithNibName:certif2 bundle:nil];
    
    [tableView registerNib:nib1 forCellReuseIdentifier:certif1];
    [tableView registerNib:nib2 forCellReuseIdentifier:certif2];
    
    if (indexPath.row == 0) {
        PersonalFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:certif1];
        if ( cell == nil) {
            cell = [[PersonalFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif1];
        }
//        cell.avatarImageView.layer.masksToBounds = YES;
//        cell.avatarImageView.layer.cornerRadius = 25.0;
//        cell.avatarImageView.layer.borderWidth = 3.0f;
//        cell.avatarImageView.layer.borderColor = [[UIColor whiteColor]CGColor];
        cell.avatarImageView.image = [UIImage imageNamed:@"CHUANG"];
        cell.separatorLine.backgroundColor = [UIColor colorWithRed:94.0/255 green:80.0/255 blue:120.0/255 alpha:1];
        return cell;
    }else {
        PersonalSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:certif2];
        if ( cell == nil ) {
            cell = [[PersonalSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.withdrawalBtn setTitleColor:[UIColor colorWithRed:94.0/255 green:80.0/255 blue:120.0/255 alpha:1] forState:UIControlStateNormal];
        return cell;
    }
    
    return nil;
}


@end
