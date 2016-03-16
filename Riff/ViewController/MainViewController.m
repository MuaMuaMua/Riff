//
//  MainViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/9.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "MainViewController.h"
#import "BasicViewController.h"
#import "RiffDataSource.h"
#import "PersonInfoDataSource.h"
#import "SettingDataSource.h"

#define winSize [[UIScreen mainScreen]bounds]

//CGRect winSize = [[UIScreen mainScreen]bounds];


@interface MainViewController ()<UITableViewDelegate> {
    
    IBOutlet UITableView *_mainTableView;
    
    UITapGestureRecognizer * _tapGesture;
    
    UIButton * _riffBtn;
    
    UIButton * _personalInfoBtn;
    
    UIButton * _settingBtn;
    
    UIImageView * _riffImageView;
    
    UIImageView * _personalInfoImageView;
    
    UIImageView * _settingImageView;
    
    RiffDataSource * _riffDataSource;
    
    PersonInfoDataSource * _personInfoDataSource;
    
    SettingDataSource * _settingDataSource;
    
    int _dataSourceType; // 1 为 riffDataSource ； 2 为 personalInfoDataSource ； 3 为 riffDataSource
    
    UIButton * _exitBtn;
}

@end

@implementation MainViewController

#pragma mark viewcontroller的生命周期的回调

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSourceType = 1;
    self.title = @"Riff";
    [self setupTapGesture];
    [self setupExitBtn];
    [self setupNavigationBarTapGesture];
    [self setupBtns];
    [self setupDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidAppear:(BOOL)animated {
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNavigationBar)];
    _tapGesture.numberOfTapsRequired = 1;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    [self.navigationController.navigationBar addGestureRecognizer:_tapGesture];
    UIView * statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, winSize.size.width, 20)];
    statusBarView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:statusBarView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar removeGestureRecognizer:_tapGesture];
}

#pragma mark - setupTableViewTapGesture 
- (void)setupTapGesture {
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction)];
    tapGesture.numberOfTapsRequired = 1;
    _mainTableView.userInteractionEnabled = YES;
    [_mainTableView addGestureRecognizer:tapGesture];
}

- (void)tapGestureAction {
    [self hideBtns];
}

#pragma mark - setupExitBtn
- (void)setupExitBtn {
    _exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, winSize.size.height - 250, winSize.size.width, 50)];
    if (winSize.size.width == 320) {
        [_exitBtn setBackgroundImage:[UIImage imageNamed:@"5EXITBTN"] forState:UIControlStateNormal];
    }else if (winSize.size.width == 375) {
        [_exitBtn setBackgroundImage:[UIImage imageNamed:@"6EXITBTN"] forState:UIControlStateNormal];
    }else if (winSize.size.width == 414) {
        [_exitBtn setBackgroundImage:[UIImage imageNamed:@"6PEXITBTN"] forState:UIControlStateNormal];
    }
    [_mainTableView addSubview:_exitBtn];
    _exitBtn.hidden = YES;
}

#pragma mark - navigationbar gesture 
- (void)setupNavigationBarTapGesture {
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNavigationBar)];
    _tapGesture.numberOfTapsRequired = 1;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    [self.navigationController.navigationBar addGestureRecognizer:_tapGesture];
}

- (void)tapNavigationBar {

    if (_riffBtn.isHidden) {
        _riffBtn.hidden = NO;
        _settingBtn.hidden = NO;
        _personalInfoBtn.hidden= NO;
    }else {
        _riffBtn.hidden = YES;
        _personalInfoBtn.hidden = YES;
        _settingBtn.hidden = YES;
    }
    
}

- (void)setupBtns {
    
    //设置 初始化和frame
    _riffBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 3, winSize.size.width, 44)];
    _riffBtn.backgroundColor = [UIColor clearColor];

    [_riffBtn addTarget:self action:@selector(clickRiff) forControlEvents:UIControlEventTouchUpInside];
    
    [_riffBtn setImage:[UIImage imageNamed:@"6RiffBtn"] forState:UIControlStateNormal];
    
    _personalInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, winSize.size.width, 44)];
    
    _settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 97, winSize.size.width, 44)];
    
    [_personalInfoBtn setImage:[UIImage imageNamed:@"6PersonalInfoBtn"] forState:UIControlStateNormal];
    
    [_settingBtn setImage:[UIImage imageNamed:@"6SettingBtn"] forState:UIControlStateNormal];
    
    //设置target
    [_riffBtn addTarget:self action:@selector(clickRiff) forControlEvents:UIControlEventTouchUpInside];
    
    [_personalInfoBtn addTarget:self action:@selector(clickPersonalInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [_settingBtn addTarget:self action:@selector(clickSetting) forControlEvents:UIControlEventTouchUpInside];
    
    //添加子视图.
    [self.view addSubview:_riffBtn];
    
    [self.view addSubview:_personalInfoBtn];
    
    [self.view addSubview:_settingBtn];
    
    //一开始设置隐藏 触发了navigationBar的点击事件之后再显示
    _riffBtn.hidden = YES;
    
    _personalInfoBtn.hidden = YES;
    
    _settingBtn.hidden = YES;
}

#pragma mark 点击了按钮的触发事件..

- (void)clickPersonalInfo {
    if (_dataSourceType == 2) {
        return;
    }else {
        _mainTableView.dataSource = _personInfoDataSource;
        [_mainTableView reloadData];
    }
    [self hideBtns];
    _exitBtn.hidden = YES;
    self.title = @"個人信息";
    _dataSourceType = 2;
}

- (void)clickSetting {
    if (_dataSourceType == 3) {
        return;
    }else {
        _mainTableView.dataSource = _settingDataSource;
        [_mainTableView reloadData];
    }
    [self hideBtns];
    _exitBtn.hidden = NO;
    self.title = @"設置";
    _dataSourceType = 3;
}

- (void)clickRiff {
    if (_dataSourceType == 1) {
        return;
    }else {
        _mainTableView.dataSource = _riffDataSource;
        [_mainTableView reloadData];
    }
    [self hideBtns];
    _exitBtn.hidden = YES;
    self.title = @"Riff";
    _dataSourceType = 1;
}

- (void)hideBtns {
    _riffBtn.hidden = YES;
    _personalInfoBtn.hidden = YES;
    _settingBtn.hidden = YES;
}


#pragma mark - selectCell 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_dataSourceType == 2) {
        if (indexPath == 0) {
            BasicViewController * basicViewController = [[BasicViewController alloc]init];
            [self.navigationController pushViewController:basicViewController animated:YES];
        }
    }
    if ([_mainTableView.dataSource isKindOfClass:[RiffDataSource class]]) {
        
    }else if ([_mainTableView.dataSource isKindOfClass:[PersonInfoDataSource class]]) {
        
    }else if ([_mainTableView.dataSource isKindOfClass:[BasicViewController class]]) {
        
    }
    
}

#pragma mark - 初始化 三嗰datasource
- (void)setupDataSource {
    _mainTableView.separatorColor = [UIColor clearColor];
    
    _mainTableView.backgroundColor = [UIColor clearColor];
    
    _riffDataSource = [[RiffDataSource alloc]init];
    
    _personInfoDataSource = [[PersonInfoDataSource alloc]init];
    
    _settingDataSource = [[SettingDataSource alloc]init];
    
    _mainTableView.delegate = self;
    
    _mainTableView.dataSource = _riffDataSource;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSourceType == 1) {
        if (indexPath.row == 0) {
            return 120.0f;
        }
        return 200.0f;
    }else if(_dataSourceType == 2) {
        if (indexPath.row == 0) {
            return 100.0f;
        }else {
            return 300.0f;
        }
    }else {
        if (indexPath.section == 1) {
            return 50;
        }
        return 44;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
