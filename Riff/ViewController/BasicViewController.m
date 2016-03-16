//
//  BasicViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/9.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "BasicViewController.h"
#import "BasicInfoDataSource.h"

@interface BasicViewController ()<UITableViewDelegate> {
    BasicInfoDataSource * _basicInfoDataSource;
}

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableview Setting 

- (void)setupTableView {
    _basicInfoDataSource = [[BasicInfoDataSource alloc]init];
    self.basicInfoTableView.delegate = self;
    self.basicInfoTableView.dataSource = _basicInfoDataSource;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //重新设定 选中的条目来跳转

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
