//
//  MainViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/9.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "MainViewController.h"
#import "RiffDataSource.h"
#import "PersonInfoDataSource.h"
#import "SettingDataSource.h"
#import "BasicInfoViewController.h"
#import "WXApi.h"
#import <WeiboSDK.h>
#import "RiffNetworkManager.h"
#import <MBProgressHUD.h>
#import "AppDelegate.h"
#import "RiffWebViewController.h"
#import "AboutRiffVC.h"
#import "ChangePwdVC.h"
#import "NSData+GZIP.h"
#import "NewNotificationVC.h"

#define winSize [[UIScreen mainScreen]bounds]

@interface MainViewController ()<UITableViewDelegate,UIGestureRecognizerDelegate,WXApiDelegate,WeiboSDKDelegate,UIWebViewDelegate,PersonalInfoDelegate> {
    
    IBOutlet UITableView *_mainTableView;
    
    UITapGestureRecognizer * _tapGesture;
    
    UITapGestureRecognizer * _tableTapGesture;
    
    RiffDataSource * _riffDataSource;
    
    PersonInfoDataSource * _personInfoDataSource;
    
    SettingDataSource * _settingDataSource;
    
    int _dataSourceType; // 1 为 riffDataSource ； 2 为 personalInfoDataSource ； 3 为 riffDataSource
    
    UIButton * _exitBtn;
    
    RiffNetworkManager * _riffNetworkManager;
    
    MBProgressHUD * _mbpHud;
    
    AppDelegate * _appDelegate;
    
    UIWebView * _webView;
    
    NSString * _clickStr;
    
    UIImageView * _downImageView;
    
    UIButton * _navigationBtn;
    
    UILabel * _contentLabel;
    
    UIImageView * _navigationImageView;
    
    IBOutlet UIButton *_riffBtn;
    
    IBOutlet UIButton *_personalInfoBtn;
    
    IBOutlet UIButton *_settingBtn;
    
    UIButton * _titleBtn;
    
    UIButton * _reloadBtn;
    
    BOOL _isFailLoaded;
}

@end

@implementation MainViewController

#pragma mark - setupNavigationBtn 
- (void)setupNavigationBtn {

}

#pragma mark - setupNavigationDownClickBtn 
- (void)setupNavigationDownClickBtn {
    
}

#pragma mark - initialize navigator gesture
- (void)initializeNavigatorTapGesture {
    if (_tapGesture) {
        
    }else {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNavigationBar)];
        _tapGesture.numberOfTapsRequired = 1;
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        [self.navigationController.navigationBar addGestureRecognizer:_tapGesture];
    }
}

#pragma mark - webview delegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    _isFailLoaded = YES;
    [self initializeNavigatorTapGesture];
    _reloadBtn.hidden = NO;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _mbpHud.labelText = @"网络故障,请检查您的网络";
    _mbpHud.mode = MBProgressHUDModeText;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

- (void)reloadWebView {
    [self setupWebView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([_mainTableView.dataSource isKindOfClass:[RiffDataSource class]]) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"正在加载";
        _mbpHud.mode = MBProgressHUDModeIndeterminate;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _isFailLoaded = NO;
    [self initializeNavigatorTapGesture];
    _reloadBtn.hidden = YES;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _mbpHud.labelText = @"加载成功";
    _mbpHud.mode = MBProgressHUDModeText;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

#pragma mark - changeNavigationBarBGView
- (void)changeNavigationBGView:(int)type {
    if (winSize.size.width == 320) {
        // 3.5、4.0 inch
    }else if (winSize.size.width == 375) {
        //4.7 inch
        switch (type) {
            case 0:
                //choose Riff DataSource
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"6NEWRiffBar"] forBarMetrics:UIBarMetricsDefault];
                break;
            case 1:
                //choose Personal DataSource
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"6NEWPersonalBar"] forBarMetrics:UIBarMetricsDefault];
                break;
            case 2:
                //choose setting DataSource
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"6NEWSettingBar"] forBarMetrics:UIBarMetricsDefault];
                break;
            default:
                break;
        }
    }else if (winSize.size.width == 414) {
        // 5.5 inch
    }
}

#pragma mark viewcontroller的生命周期的回调

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 162, 28)];
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"RiffTitleView"] forState:UIControlStateNormal];
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"RiffTitleViewSelected"] forState:UIControlStateHighlighted];
    [_titleBtn addTarget:self action:@selector(tapNavigationBar) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _titleBtn;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BGVIEW"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSourceType = 1;
    [self.navigationController.navigationBar addSubview:_downImageView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNewPassage) name:@"ReloadNewPassage" object:nil];
    [self setupDataSource];
    [self setupExitBtn];
    [self setupNetworkManager];
    [self setupBtns];
    [self sendDeviceToken];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNavigationBar)];
    _tapGesture.numberOfTapsRequired = 1;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    [self.navigationController.navigationBar addGestureRecognizer:_tapGesture];
    //判断是否nsuserdefault 中的参数是否是空 如果是空的话  进入直接reload
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"ReloadKey"] isEqualToString:@"YES"]) {
        [self reloadNewPassage];
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"ReloadKey"];
    }
    if ([_mainTableView.dataSource isKindOfClass:[PersonInfoDataSource class]]) {
        [_mainTableView reloadData];
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    //待定
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    NSLog(@"收到了微博的回调");
    //优化看回调的内容，如果发送成功则策略待定
}

- (void)viewDidAppear:(BOOL)animated {
//    if ([_mainTableView.dataSource isKindOfClass:[PersonInfoDataSource class]]) {
//        [self changeNavigationBGView:1];
//    }else if ([_mainTableView.dataSource isKindOfClass:[RiffDataSource class]]) {
//        [self changeNavigationBGView:0];
//    }else if ([_mainTableView.dataSource isKindOfClass:[SettingDataSource class]]) {
//        [self changeNavigationBGView:2];
//    }
    UIView * statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, winSize.size.width, 20)];
    statusBarView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:statusBarView];
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([_mainTableView.dataSource isKindOfClass:[PersonInfoDataSource class]]) {
//        self.title = @"個人信息";
    }
    _downImageView.hidden = YES;
    [self.navigationController.navigationBar removeGestureRecognizer:_tapGesture];
}

#pragma mark - 获取新的passage
- (void)reloadNewPassage {
    //获取新的URL 和reload 新的RiffDataSource
    [self getNewAdvertisement];
}

#pragma mark - sendDeviceToken 
- (void)sendDeviceToken {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"]) {
        [_riffNetworkManager saveDeviceTokenWithDeviceToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] DTZSuccessBlock:^(NSDictionary *successBlock) {
        } DTZFailBlock:^(NSDictionary *failBlock) {
            
        }];
    }
}

#pragma mark - setupWebView
- (void)setupWebView {
    if (_webView) {
        [_webView removeFromSuperview];
    }
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 120, winSize.size.width, winSize.size.height - 60 - 120 - 64)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.delegate = self;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"urlStr"]]];
    [_webView loadRequest:request];
    _webView.scrollView.bouncesZoom = YES;
    _webView.scrollView.bounces = YES;
    _webView.scalesPageToFit = YES;
    if ([_mainTableView.dataSource isKindOfClass:[PersonInfoDataSource class]]) {
        _webView.hidden = YES;
    }else if ([_mainTableView.dataSource isKindOfClass:[SettingDataSource class]]) {
        _webView.hidden = YES;
    }else if([_mainTableView.dataSource isKindOfClass:[RiffDataSource class]]) {
        _webView.hidden = NO;
    }
    [_mainTableView addSubview:_webView];
}

- (void)getNewAdvertisement {
    [_riffNetworkManager getNewAdvWithDTZSuccessBlock:^(NSDictionary *successBlock) {
        NSLog(@"%@",successBlock);
        NSDictionary * advertisement = [successBlock objectForKey:@"advertisement"];
        NSString * urlStr = [successBlock objectForKey:@"url"];
        NSString * imageUrlStr = [advertisement objectForKey:@"imageUrl"];
        NSNumber * clickNumber = [advertisement objectForKey:@"click"];
        NSString * companyName = [advertisement objectForKey:@"companyName"];
        NSString * shareTitle = [advertisement objectForKey:@"title"];
        NSString * companyLogoUrl = [advertisement objectForKey:@"companyLogoUrl"];
        if (urlStr) {
            if ([urlStr isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"urlStr"]]) {
                NSLog(@"两次的url 是同一个.");
            }else {
                [[NSUserDefaults standardUserDefaults] setObject:urlStr forKey:@"urlStr"];
                [self setupWebView];
            }
            [[NSUserDefaults standardUserDefaults] setObject:urlStr forKey:@"urlStr"];
            if (_webView) {
                NSLog(@"WebView is not nil");
            }else {
                [self setupWebView];
            }
        }
        if (companyLogoUrl) {
            [[NSUserDefaults standardUserDefaults] setObject:companyLogoUrl forKey:@"companyLogoUrl"];
        }
        if (companyName) {
            [[NSUserDefaults standardUserDefaults]setObject:companyName forKey:@"companyName"];
        }
        if (shareTitle) {
            [[NSUserDefaults standardUserDefaults]setObject:shareTitle forKey:@"shareTitle"];
        }
        if (imageUrlStr) {
            [[NSUserDefaults standardUserDefaults] setObject:imageUrlStr forKey:@"imageUrlStr"];
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlStr]];
            [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"imageData"];
        }
        //保存图片到本地NSUserDefault 中 上传到微信的时候再上传。
        if (clickNumber) {
            [[NSUserDefaults standardUserDefaults] setObject:clickNumber forKey:@"clickTime"];
        }
        if ([_mainTableView.dataSource isKindOfClass:[RiffDataSource class]]) {
            //reload tableview
            [_mainTableView reloadData];
        }
    } DTZFailBlock:^(NSDictionary *failBlock) {
        NSLog(@"%@",failBlock);
        if (_reloadBtn) {
            // 如果存在则不做处理
            // 如果不存在则 重新初始化
            if ([_mainTableView.dataSource isKindOfClass:[RiffDataSource class]]) {
                _reloadBtn.hidden = NO;
            }
        }else {
            _reloadBtn = [[UIButton alloc]init];
            _reloadBtn.frame = CGRectMake(winSize.size.width / 2 - 60.5, winSize.size.height / 2 - 50, 121, 46);
            [_reloadBtn setBackgroundImage:[UIImage imageNamed:@"ReloadBtn"] forState:UIControlStateNormal];
            _reloadBtn.hidden = YES;
            [_reloadBtn addTarget:self action:@selector(reloadWebView) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_reloadBtn];
            
            if ([_mainTableView.dataSource isKindOfClass:[RiffDataSource class]]) {
                _reloadBtn.hidden = NO;
            }
        }
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"网络故障";
        _mbpHud.mode = MBProgressHUDModeText;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        //添加一个Button是加载网络故障的问题
        
    }];
}

#pragma mark - setupRiffNetworkManager
- (void)setupNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
    [self getNewAdvertisement];
}

#pragma mark - setupTableViewTapGesture 
- (void)setupTapGesture {
    // 解决手势冲突
    if (_tableTapGesture == nil) {
        _tableTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        _tableTapGesture.numberOfTapsRequired = 1;
        _tableTapGesture.delegate = self;
        [_webView addGestureRecognizer:_tableTapGesture];
        [_mainTableView addGestureRecognizer:_tableTapGesture];
    }
}

- (void)tapAction {
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (_riffBtn.isHidden) {
        return NO;
    }else {
        [self hideBtns];
        return YES;
    }
    return YES;
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
    [_exitBtn addTarget:self action:@selector(clickExit) forControlEvents:UIControlEventTouchUpInside];
    _exitBtn.hidden = YES;
}

- (void)clickExit {
    //登出
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    [_riffNetworkManager userLogoutWithTokenwithDTZSuccessBlock:^(NSDictionary *successBlock) {
        //清楚内部缓存,数据NsuserDefault中的数据.
        NSNumber * code = [successBlock objectForKey:@"code"];
        if (code.intValue == 200) {
            _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _mbpHud.labelText = @"登出成功";
            _mbpHud.mode = MBProgressHUDModeText;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW , 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            NSString * appDomain = [[NSBundle mainBundle]bundleIdentifier];
            [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
            _appDelegate = [UIApplication sharedApplication].delegate;
            [_appDelegate setupLoginVC];
        }else {
            NSString * appDomain = [[NSBundle mainBundle]bundleIdentifier];
            [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
            _appDelegate = [UIApplication sharedApplication].delegate;
            [_appDelegate setupLoginVC];
        }
    } DTZFailBlock:^(NSDictionary *failBlock) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"服务器故障，请稍后再试";
        _mbpHud.mode = MBProgressHUDModeText;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW , 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

#pragma mark - navigationbar gesture
- (void)setupNavigationBarTapGesture {
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNavigationBar)];
    _tapGesture.numberOfTapsRequired = 1;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    [self.navigationController.navigationBar addGestureRecognizer:_tapGesture];
}

- (void)tapNavigationBar {
    [self setupTapGesture];
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
//    //设置target
    [_riffBtn addTarget:self action:@selector(clickRiff) forControlEvents:UIControlEventTouchUpInside];
    [_personalInfoBtn addTarget:self action:@selector(clickPersonalInfo) forControlEvents:UIControlEventTouchUpInside];
    [_settingBtn addTarget:self action:@selector(clickSetting) forControlEvents:UIControlEventTouchUpInside];
//一开始设置隐藏 触发了navigationBar的点击事件之后再显示
    _riffBtn.hidden = YES;
    _personalInfoBtn.hidden = YES;
    _settingBtn.hidden = YES;
}

#pragma mark 点击了按钮的触发事件..

- (void)clickPersonalInfo {
    if (_reloadBtn.hidden) {
    }else {
        _reloadBtn.hidden = YES;
    }
    if (_dataSourceType == 2) {
        [self hideBtns];
        //重新获取新的数据。未提现的数目。
        return;
    }else {
        _mainTableView.dataSource = _personInfoDataSource;
        _mainTableView.delegate = self;
        [_mainTableView reloadData];
    }
    _downImageView.frame = CGRectMake(winSize.size.width / 2 + 45, 11, 20, 20);
    //获取新的总次数。
    [self getNewCount];
    [self hideBtns];
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"PersonalTitleView"] forState:UIControlStateNormal];
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"PersonalTitleViewSelected"] forState:UIControlStateHighlighted];
    _webView.hidden = YES;
    _exitBtn.hidden = YES;
    _dataSourceType = 2;
}

- (void)clickSetting {
    if (_reloadBtn.hidden) {
    }else {
        _reloadBtn.hidden = YES;
    }
    if (_dataSourceType == 3) {
        [self hideBtns];
        return;
    }else {
        _mainTableView.dataSource = _settingDataSource;
        _mainTableView.delegate = self;
        [_mainTableView reloadData];
    }
    _downImageView.frame = CGRectMake(winSize.size.width / 2 + 25, 11, 20, 20);
    [self hideBtns];
    _webView.hidden = YES;
    _exitBtn.hidden = NO;
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"SettingTitleView"] forState:UIControlStateNormal];
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"SettingTitleViewSelected"] forState:UIControlStateHighlighted];
    _dataSourceType = 3;
    
}

- (void)clickRiff {
    
    if (_isFailLoaded) {
        _reloadBtn.hidden = NO;
    }else {
        _reloadBtn.hidden = YES;
    }
    if (_dataSourceType == 1) {
        [self hideBtns];
        return;
    }else {
        _mainTableView.dataSource = _riffDataSource;
        _mainTableView.delegate = self;
        [_mainTableView reloadData];
    }
    _downImageView.frame = CGRectMake(winSize.size.width/2+18, 11, 20, 20);
    [self hideBtns];
    _webView.hidden = NO;
    _exitBtn.hidden = YES;
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"RiffTitleView"] forState:UIControlStateNormal];
    [_titleBtn setBackgroundImage:[UIImage imageNamed:@"RiffTitleViewSelected"] forState:UIControlStateHighlighted];
    _dataSourceType = 1;
}

#pragma mark - setupNewCount
- (void)getNewCount {
    [_riffNetworkManager countNotWithdrawWithDTZSuccessBlock:^(NSDictionary *successBlock) {
        NSLog(@"%@",successBlock);
        NSNumber * code = [successBlock objectForKey:@"code"];
        if (code.intValue == 200) {
            NSNumber * clickTime = [successBlock objectForKey:@"clickTime"];
            if (clickTime) {
                [[NSUserDefaults standardUserDefaults]setObject:clickTime forKey:@"totalClickTime"];
            }
            if (self) {
                if ([_mainTableView.dataSource isKindOfClass:[PersonInfoDataSource class]]) {
                    [_mainTableView reloadData];
                }
            }
        }
    } DTZFailBlock:^(NSDictionary *failBlock) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"网络出错，请检查网络";
        _mbpHud.mode = MBProgressHUDModeText;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

#pragma mark - hide Buttons
- (void)hideBtns {
    _riffBtn.hidden = YES;
    _personalInfoBtn.hidden = YES;
    _settingBtn.hidden = YES;
    _tableTapGesture = nil;
    [_webView removeGestureRecognizer:_tableTapGesture];
    [_mainTableView removeGestureRecognizer:_tableTapGesture];
}

#pragma mark - selectCell 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_mainTableView.dataSource isKindOfClass:[RiffDataSource class]]) {
        if (indexPath.row == 0) {
            //应该push webview 未写好
            return;
        }else {
            return ;
        }
    }else if ([_mainTableView.dataSource isKindOfClass:[PersonInfoDataSource class]]) {
        if (indexPath.row == 0) {
            BasicInfoViewController * basicInfoViewController = [[BasicInfoViewController alloc]init];
            _downImageView.hidden = YES;
            UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BGVIEW"] forBarMetrics:UIBarMetricsDefault];
            temporaryBarButtonItem.title=@"個人信息";
            self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
            [self.navigationController pushViewController:basicInfoViewController animated:YES];
        }else {
            return;
        }
    }else if ([_mainTableView.dataSource isKindOfClass:[SettingDataSource class]]) {
        if (indexPath.row == 0) {
            //跳转到通知
            _downImageView.hidden = YES;
            NewNotificationVC * newNotificationVC = [[NewNotificationVC alloc]init];
            _clickStr = @"設置";
            UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
            temporaryBarButtonItem.title=@"设置";
            self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
            [self.navigationController pushViewController:newNotificationVC animated:YES];
        }
//        else if (indexPath.row == 1) {
//            // 跳转 到评价 由于还没有上架 所以 不能评价。
//        }
        else if (indexPath.row == 1) {
            _downImageView.hidden = YES;
            AboutRiffVC * aboutVC = [[AboutRiffVC alloc]init];
            UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
            temporaryBarButtonItem.title=@"设置";
            self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
            [self.navigationController pushViewController:aboutVC animated:YES];
        }else if (indexPath.row == 2) {
            // 跳转到 密码修改的界面.
            _downImageView.hidden = YES;
            ChangePwdVC * changePwdVC = [[ChangePwdVC alloc]init];
            UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
            temporaryBarButtonItem.title=@"设置";
            self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
            [self.navigationController pushViewController:changePwdVC animated:YES];
        }
    }
}

#pragma mark - 初始化 三嗰datasource
- (void)setupDataSource {
    _mainTableView.separatorColor = [UIColor clearColor];
    
    _mainTableView.backgroundColor = [UIColor clearColor];
    
    _riffDataSource = [[RiffDataSource alloc]init];
    
    _personInfoDataSource = [[PersonInfoDataSource alloc]init];
    
    _personInfoDataSource.delegate = self;
    
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

#pragma mark - IB Action
- (IBAction)clickWechatFrd:(id)sender {
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
    req.scene = WXSceneTimeline;
    WXMediaMessage * message = [WXMediaMessage message];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"shareTitle"]) {
        message.title = [[NSUserDefaults standardUserDefaults]objectForKey:@"shareTitle"];
    }
    WXWebpageObject * webpageObject = [WXWebpageObject object];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"urlStr"]) {
        webpageObject.webpageUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"urlStr"];
    }
    message.mediaObject = webpageObject;
    NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageData"];
    UIImage * image = [UIImage imageWithData:data];
    message.thumbData = UIImageJPEGRepresentation(image, 1);
    // 设置下载完图片异步加载到本地
    req.message = message;
    [WXApi sendReq:req];
}

- (IBAction)clickWechatDis:(id)sender {
    SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
    req.scene = WXSceneSession;
    WXMediaMessage * message = [WXMediaMessage message];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"shareTitle"]) {
        message.title = [[NSUserDefaults standardUserDefaults]objectForKey:@"shareTitle"];
    }
    WXWebpageObject * webpageObject = [WXWebpageObject object];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"urlStr"]) {
        webpageObject.webpageUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"urlStr"];
    }
    message.mediaObject = webpageObject;
    
    NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageData"];
    UIImage * image = [UIImage imageWithData:data];
    message.thumbData = UIImageJPEGRepresentation(image, 1);    // 设置下载完图片异步加载到本地
    req.message = message;
    [WXApi sendReq:req];

}

- (IBAction)clickWeibo:(id)sender {
    //Share到微博
    WBSendMessageToWeiboRequest * request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    [WeiboSDK sendRequest:request];
}

- (IBAction)clickOthers:(id)sender {
    _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _mbpHud.labelText = @"暂时没设定";
    _mbpHud.mode = MBProgressHUDModeText;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (WBMessageObject *)messageToShare {
    WBMessageObject * message = [WBMessageObject message];
    WBWebpageObject * mediaObject = [WBWebpageObject object];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"urlStr"]) {
        mediaObject.webpageUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"urlStr"];
    }
    NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageData"];
    UIImage * image = [UIImage imageWithData:data];
    mediaObject.thumbnailData = UIImageJPEGRepresentation(image, 1);
    mediaObject.title = [[NSUserDefaults standardUserDefaults]objectForKey:@"shareTitle"];
    mediaObject.objectID = @"identifier1";
    mediaObject.description = @"";
    message.mediaObject = mediaObject;
    return message;
}

#pragma mark - personalInfoDateSource Withdraw Delegate
- (void)withdrawTrans {
    // 实现提现接口
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    NSString * mobileStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
    [_riffNetworkManager userWithdrawWithDTZSuccess:^(NSDictionary *successBlock) {
        NSNumber * code = [successBlock objectForKey:@"code"];
        if (code.intValue == 200) {
            _mbpHud = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            _mbpHud.labelText = [NSString stringWithFormat:@"提现成功\n24小时内会发到\n%@支付宝账号上",mobileStr];
            _mbpHud.mode = MBProgressHUDModeText;
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            [self getNewCount];
        }else if (code.intValue == 500) {
            _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _mbpHud.labelText = @"目前的积累金额为0";
            _mbpHud.mode = MBProgressHUDModeText;
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }
    } DTZFailBlock:^(NSDictionary *failBlock) {
        _mbpHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _mbpHud.labelText = @"服务器故障";
        _mbpHud.mode = MBProgressHUDModeText;
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

@end
