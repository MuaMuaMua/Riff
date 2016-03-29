//
//  SocialVC.m
//  Riff
//
//  Created by wuhaibin on 16/3/22.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "SocialVC.h"
#import "SocialDataSource.h"
#import <MBProgressHUD.h>
#import "UpdateBasicInfoVC.h"

@interface SocialVC () {
    SocialDataSource * _dataSource;
    MBProgressHUD * _mbpHud;
}

@end

@implementation SocialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社交信息";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadTableView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateError) name:@"updateError" object:nil];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)updateError {
    _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _mbpHud.labelText = @"网络故障,请检查网络连接";
    _mbpHud.mode = MBProgressHUDModeText;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (void)reloadTableView {
    [self.socialTableview reloadData];
}

#pragma mark - setupTableView 
- (void)setupTableView {
    _dataSource = [[SocialDataSource alloc]init];
    self.socialTableview.delegate = self;
    self.socialTableview.dataSource = _dataSource;
    self.socialTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    if (indexPath.row == 0) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"手机号码不能修改";
        _mbpHud.mode = MBProgressHUDModeText;
        //隐藏view
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }else if (indexPath.row == 1) {
        //跳转到修改邮箱
        UpdateBasicInfoVC * updateBasicInfo = [[UpdateBasicInfoVC alloc]init];
        updateBasicInfo.keyStr = @"email";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"email"]) {
            updateBasicInfo.originalValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
        }else {
            updateBasicInfo.originalValue = @"";
        }
        [self.navigationController pushViewController:updateBasicInfo animated:YES];
    }else if (indexPath.row == 2) {
        //跳转到微信
        UpdateBasicInfoVC * updateBasicInfo = [[UpdateBasicInfoVC alloc]init];
        updateBasicInfo.keyStr = @"weChat";
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"weChat"]) {
            updateBasicInfo.originalValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"weChat"];
        }else {
            updateBasicInfo.originalValue = @"";
        }
        
        [self.navigationController pushViewController:updateBasicInfo animated:YES];
    }else if (indexPath.row == 3) {
        //跳转到修改微博
        UpdateBasicInfoVC * updateBasicInfo = [[UpdateBasicInfoVC alloc]init];
        updateBasicInfo.keyStr = @"weibo";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"weibo"]) {
            updateBasicInfo.originalValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"weibo"];
        }else {
            updateBasicInfo.originalValue = @"";
        }
        [self.navigationController pushViewController:updateBasicInfo animated:YES];
    }else if (indexPath.row == 4) {
        //跳转到修改QQ
        UpdateBasicInfoVC * updateBasicInfo = [[UpdateBasicInfoVC alloc]init];
        updateBasicInfo.keyStr = @"qq";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"qq"]) {
            updateBasicInfo.originalValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"qq"];
        }else {
            updateBasicInfo.originalValue = @"";
        }
        [self.navigationController pushViewController:updateBasicInfo animated:YES];
    }
}

@end
