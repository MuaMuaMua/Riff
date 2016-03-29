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
#import "UpdateBasicInfoVC.h"
#import "GenderViewController.h"
#import "SocialVC.h"
#import <MBProgressHUD.h>
#import "MainViewController.h"

@interface BasicInfoViewController ()<UITableViewDelegate> {
    
    BasicInfoDataSource * _dataSource;
    
    MBProgressHUD * _mbpHud;
}

@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    self.navigationItem.leftBarButtonItem.title = @"個人信息";
    [self.navigationItem.backBarButtonItem setTitle:@"個人信息"];
    self.navigationController.navigationItem.backBarButtonItem.title = @"個人信息";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableView) name:@"reloadTableView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadError) name:@"reloadError" object:nil];
    [self setupTableViewDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [_tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
//    MainViewController * mainViewController = [self.navigationController.viewControllers objectAtIndex:0];
//    mainViewController.title = @"個人信息";
}

#pragma mark - NSNotification CallBack
- (void)reloadTableView {
    [self.tableView reloadData];
}

- (void)reloadError {
    _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _mbpHud.labelText = @"网络故障，请稍后再试";
    _mbpHud.mode = MBProgressHUDModeText;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        AvatarViewController * avatarVC = [[AvatarViewController alloc]init];
        [self.navigationController pushViewController:avatarVC animated:YES];
    }else if (indexPath.row == 1) {
        UpdateBasicInfoVC * updateBasicInfoVC = [[UpdateBasicInfoVC alloc]init];
        updateBasicInfoVC.keyStr = @"username";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"username"]) {
            updateBasicInfoVC.originalValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        }else {
            updateBasicInfoVC.originalValue = @"";
        }
        [self.navigationController pushViewController:updateBasicInfoVC animated:YES];
    }else if (indexPath.row ==2) {
        // 跳转到genderViewController
        GenderViewController * genderVC = [[GenderViewController alloc]init];
        [self.navigationController pushViewController:genderVC animated:YES];
    }else if (indexPath.row == 3) {
        // 暂时忽略.
        
    }else if (indexPath.row == 4) {
        // 跳转到其他 socialVC
        SocialVC * socialVC = [[SocialVC alloc]init];
        [self.navigationController pushViewController:socialVC animated:YES];
    }
}

@end
