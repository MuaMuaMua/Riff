//
//  BasicInfoViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/16.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "BasicInfoAvatarCell.h"

@interface BasicInfoViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
}

@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * certif = @"BasicInfoAvatarCell";
    UINib * nib = [UINib nibWithNibName:@"BasicInfoAvatarCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:certif];
    
    if (indexPath.row == 0) {
        BasicInfoAvatarCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
        if (cell == nil) {
            cell = [[BasicInfoAvatarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
        }
        //设置头像部分 暂无
        
        return cell;
    }else {
        // 其他的 cell的样式 和 设定title
        
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}



@end
