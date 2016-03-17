//
//  NotificationViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/16.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "NotificationViewController.h"
#import "NewNotificationCell.h"

@interface NotificationViewController () <UITableViewDelegate,UITableViewDataSource> {
    
}

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewDelegate  && dataSource 
- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * certif = @"NewNotificationCell";
    UINib * nib = [UINib nibWithNibName:certif bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:certif];
    NewNotificationCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
    if (cell == nil) {
        cell = [[NewNotificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
    }
    
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
