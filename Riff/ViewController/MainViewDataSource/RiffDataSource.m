//
//  RiffDataSource.m
//  Riff
//
//  Created by wuhaibin on 16/3/9.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "RiffDataSource.h"
#import "AdvCell.h"

@implementation RiffDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;
}

#pragma mark - 重新设置

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UINib * nib = [UINib nibWithNibName:@"AdvCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:@"AdvCell"];
    
    AdvCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AdvCell"];
    
    if ( cell == nil ) {
        cell = [[AdvCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AdvCell"];
    }
    cell.totalMoneyLabel.textColor = [UIColor colorWithRed:249.0/255 green:233.0/255 blue:0/255 alpha:10];
    cell.moneyTypeLabel.textColor = [UIColor colorWithRed:94.0/255 green:80.0/255 blue:120.0/255 alpha:1];
    cell.companyNameLabel.textColor = [UIColor colorWithRed:94.0/255 green:80.0/255 blue:120.0/255 alpha:1];
    //重新设置回调 再去设置.
    return cell;
}



@end
