//
//  BasicVCDataSource.m
//  Riff
//
//  Created by wuhaibin on 16/3/11.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "BasicVCDataSource.h"

@implementation BasicVCDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}



@end
