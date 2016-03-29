//
//  BasicInfoDataSource.m
//  Riff
//
//  Created by wuhaibin on 16/3/11.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "BasicInfoDataSource.h"
#import "BasicAvatarCell.h"
#import "BasicInfoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation BasicInfoDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * certif1 = @"BasicAvatarCell";
    
    static NSString * certif2 = @"BasicInfoCell";
    
    UINib * nib1 = [UINib nibWithNibName:certif1 bundle:nil];
    
    UINib * nib2 = [UINib nibWithNibName:certif2 bundle:nil];
    
    [tableView registerNib:nib1 forCellReuseIdentifier:certif1];
    [tableView registerNib:nib2 forCellReuseIdentifier:certif2];
    
    if (indexPath.row == 0) {
        //indexPath 为0 的时候设置头像的cell
        BasicAvatarCell * cell = [tableView dequeueReusableCellWithIdentifier:certif1];
        if (cell == nil) {
            cell = [[BasicAvatarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif1];
        }
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"avatarUrl"]) {
            NSString * avatarUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"avatarUrl"];
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"CHUANG"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        }else {
            cell.avatarImageView.image = [UIImage imageNamed:@"CHUANG"];
        }
        
        return cell;
    }else {
        BasicInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:certif2];
        if (cell == nil) {
            cell = [[BasicInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif2];
            //设置 cell的 具体的title 开实现赋值  和  跳转的信息的保存
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"名字";
            NSString * nameStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
            if (nameStr) {
                cell.contentLabel.text = nameStr;
            }else {
                cell.contentLabel.text = @"";
            }
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = @"性别";
            NSString * genderStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"gender"];
            if (genderStr) {
                if ([genderStr isEqualToString:@"male"]) {
                    cell.contentLabel.text = @"男";
                }else {
                    cell.contentLabel.text = @"女";
                }
            }else {
                cell.contentLabel.text = @"";
            }
        }else if (indexPath.row == 3) {
            cell.titleLabel.text = @"地区";
            NSString * district = [[NSUserDefaults standardUserDefaults]objectForKey:@"district"];
            if (district) {
                cell.contentLabel.text = district;
            }else {
                cell.contentLabel.text = @"";
            }
            cell.contentLabel.text = @"广东-广州";
        }else if (indexPath.row == 4) {
            cell.titleLabel.text = @"其他";
            cell.contentLabel.text = @"";
        }
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}



@end
