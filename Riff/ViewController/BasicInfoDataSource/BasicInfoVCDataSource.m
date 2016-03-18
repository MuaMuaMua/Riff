//
//  BasicInfoVCDataSource.m
//  Riff
//
//  Created by wuhaibin on 16/3/18.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "BasicInfoVCDataSource.h"
#import "BasicInfoAvatarCell.h"
#import "BasicInfoCell.h"

@implementation BasicInfoVCDataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.row == 0) {
        NSString * certif = @"BasicInfoAvatarCell";
        UINib * nib = [UINib nibWithNibName:certif bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:certif];
        
        BasicInfoAvatarCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
        if (cell == nil) {
            cell = [[BasicInfoAvatarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        
        return cell;
    }else  {
        NSString * certif = @"BasicInfoCell";
        UINib * nib = [UINib nibWithNibName:certif bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:certif];
        BasicInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
        if (cell == nil) {
            cell = [[BasicInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        //设置cell的title
        switch (indexPath.row) {
            case 1:
                cell.titleLabel.text = @"名字";
                break;
            case 2:
                cell.titleLabel.text = @"性别";
                break;
            case 3:
                cell.titleLabel.text = @"地区";
                break;
            case 4:
                cell.titleLabel.text = @"生日";
                break;
            case 5:
                cell.titleLabel.text = @"其他";
                break;
            default:
                break;
        }
        return cell;
    }
    return nil;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

@end
