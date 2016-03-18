//
//  BasicInfoViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/16.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "BasicInfoAvatarCell.h"
#import "BasicInfoDataSource.h"
#import "AvatarViewController.h"

@interface BasicInfoViewController ()<UITableViewDelegate> {
    
    BasicInfoDataSource * _dataSource;
    
}

@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    //    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    [self setupTableViewDataSource];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview datasource Setting 
- (void)setupTableViewDataSource {
    _dataSource = [[BasicInfoDataSource alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = _dataSource;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 120.0f;
    }else
        return 44.0f;
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置跳转
    AvatarViewController * avatarVC = [[AvatarViewController alloc]init];
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            //跳转到scrollview右上角带有item 选中
            [self.navigationController pushViewController:avatarVC animated:YES];
            
            break;
        case 1:
            // 跳转到名字修改的viewcontroller 用push
            
            break;
        case 2:
            // 跳转到性别选择的viewcontroller 用push
            
            break;
        case 3:
            // 跳转到地区选择的viewcontroller 用push
            
            break;
        case 4:
            // 跳转到生日选择
            //暂时忽略
            
            break;
        case 5:
            // 跳转到其他
            // 暂时忽略
            
            break;
        default:
            break;
    }
}

@end
