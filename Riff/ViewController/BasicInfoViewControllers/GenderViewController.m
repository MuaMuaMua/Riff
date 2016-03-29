//
//  GenderViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/19.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "GenderViewController.h"
#import "GenderCell.h"
#import "RiffNetworkManager.h"


@interface GenderViewController ()<UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *_tableView;
    RiffNetworkManager * _riffNetworkManager;
}

@end

@implementation GenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataSource];
    [self setupNetworkManager];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupNetworkManager 
- (void)setupNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
}

#pragma mark - setupTableView Delegate && dataSource
- (void)setupDataSource {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * genderStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"gender"];
    static NSString * certif = @"GenderCell";
    UINib * nib = [UINib nibWithNibName:certif bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:certif];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"sex"]) {
        // 不为空 设置为
        
    }
    if (indexPath.row == 0) {
        GenderCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
        if (cell == nil) {
            cell = [[GenderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        if (genderStr == nil) {
            //不作处理
            cell.rightImageView.hidden = YES;
        }else {
            if ([genderStr isEqualToString:@"male"]) {
                cell.rightImageView.hidden = NO;
            }else {
                cell.rightImageView.hidden = YES;
            }
        }
        cell.sexLabel.text = @"男";
        return cell;
    }else if(indexPath.row == 1) {
        GenderCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
        if (cell == nil) {
            cell = [[GenderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        if (genderStr == nil) {
            //不做处理
            cell.rightImageView.hidden = YES;
        }else {
            if ([genderStr isEqualToString:@"female"]) {
                cell.rightImageView.hidden = NO;
            }else {
                cell.rightImageView.hidden = YES;
            }
        }
        cell.sexLabel.text = @"女";
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //设置为男性
        [[NSUserDefaults standardUserDefaults]setObject:@"male" forKey:@"gender"];
        [_riffNetworkManager userChangeUserSexInfoWithGender:@"male" DTZSuccessBlock:^(NSDictionary *successBlock) {
            // 微信策略是不需要写上服务器
            NSNumber * code = [successBlock objectForKey:@"code"];
            if (code.intValue == 200) {
                
            }
        } DTZFailBlock:^(NSDictionary *failBlock) {
            
        }];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        //设置为女性
        [[NSUserDefaults standardUserDefaults]setObject:@"female" forKey:@"gender"];
        [_riffNetworkManager userChangeUserSexInfoWithGender:@"female" DTZSuccessBlock:^(NSDictionary *successBlock) {
            
        } DTZFailBlock:^(NSDictionary *failBlock) {
            
        }];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
