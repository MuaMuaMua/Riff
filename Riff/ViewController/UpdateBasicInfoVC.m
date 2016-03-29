//
//  UpdateBasicInfoVC.m
//  Riff
//
//  Created by wuhaibin on 16/3/19.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "UpdateBasicInfoVC.h"
#import "UpdateTextfieldCell.h"
#import "RiffNetworkManager.h"
#import <MBProgressHUD.h>

@interface UpdateBasicInfoVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UpdateTextfieldCellDelegate> {
    
    IBOutlet UITableView *_tableView;
    
    UIBarButtonItem * _rightBarButtonItem;
    
    UIButton * _rightBtn;
    
    RiffNetworkManager * _riffNetworkManager;
    
    UpdateTextfieldCell * _cell;
    
    MBProgressHUD * _mbpHud;
}

@end

@implementation UpdateBasicInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.keyStr;
    
    if ([self.keyStr isEqualToString:@"weChat"]) {
        self.title = @"微信";
    }else if ([self.keyStr isEqualToString:@"weibo"]) {
        self.title = @"微博";
    }else if ([self.keyStr isEqualToString:@"username"]) {
        self.title = @"名字";
    }else if ([self.keyStr isEqualToString:@"email"]) {
        self.title = @"邮箱";
    }else if ([self.keyStr isEqualToString:@"qq"]) {
        self.title = @"QQ";
    }
    
    [self setupNetworkManager];
    [self setupTableView];
    [self addRightNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setupNetworkManager 
- (void)setupNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
}

#pragma mark - addRightNavigationItem 
- (void)addRightNavigationItem {
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,40, 20)];
    [_rightBtn setTitle:@"储存" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [_rightBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    //看看小白哥 策略
    _rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"储存" style:UIBarButtonItemStylePlain target:self action:@selector(clickRI)];
    self.navigationItem.rightBarButtonItem = _rightBarButtonItem;
}

- (void)clickRI {
    [self updateUserInfo];
}

- (void)updateUserInfo {
    // 判断这个是选择了什么的方向 不需要的参数
    [_riffNetworkManager userChangeUserInfoWithProperty:self.keyStr PropertyValue:_cell.updateTextfield.text DTZSuccessBlock:^(NSDictionary *successBlock) {
        [[NSUserDefaults standardUserDefaults]setObject:_cell.updateTextfield.text forKey:self.keyStr];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadTableView" object:nil];
    } DTZFailBlock:^(NSDictionary *failBlock) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updateError" object:nil];
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview delegate setting && datasource 
- (void)setupTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * certif = @"UpdateTextfieldCell";
    UINib * nib = [UINib nibWithNibName:@"UpdateTextfieldCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:certif];
    _cell = [tableView dequeueReusableCellWithIdentifier:certif];
    if ( _cell == nil ) {
        _cell = [[UpdateTextfieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
    }
    
    if ([self.keyStr isEqualToString:@"weChat"]) {
        _cell.updateTextfield.placeholder = @"微信";
    }else if ([self.keyStr isEqualToString:@"weibo"]) {
        _cell.updateTextfield.placeholder = @"微博";
    }else if ([self.keyStr isEqualToString:@"username"]) {
        _cell.updateTextfield.placeholder = @"名字";
    }else if ([self.keyStr isEqualToString:@"email"]) {
        _cell.updateTextfield.placeholder = @"邮箱";
    }else if ([self.keyStr isEqualToString:@"qq"]) {
        _cell.updateTextfield.placeholder = @"QQ";
    }
    _cell.updateTextfield.text = self.originalValue;
    _cell.originalStr = self.originalValue;
    _cell.delegate = self;
    _cell.updateTextfield.delegate = self;
    return _cell;
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //设置 如果 输入的内容和originalString 不一致 则显示导航栏的保存按钮
    
}

- (void)enableSaveBtn:(BOOL)enable {
    if (enable) {
        _rightBarButtonItem.enabled = YES;
    }else {
        _rightBarButtonItem.enabled = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

@end
