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
        return cell;
    }else {
        BasicInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:certif2];
        if (cell == nil) {
            cell = [[BasicInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif2];
            //设置 cell的 具体的title 开实现赋值  和  跳转的信息的保存
        }
        switch (indexPath.row) {
            case 1:
                cell.titleLabel.text = @"名字";
                break;
                case 2:
                cell.titleLabel.text = @"性别";
                break;
                case 3:
                cell.titleLabel.text = @"地區";
                break;
                case 4:
                cell.titleLabel.text = @"生日";
                break;
                case 5:
                cell.titleLabel.text = @"其他";
            default:
                break;
        }
        
        return cell;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}



@end
