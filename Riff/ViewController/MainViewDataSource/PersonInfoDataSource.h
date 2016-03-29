//
//  PersonInfoDataSource.h
//  Riff
//
//  Created by wuhaibin on 16/3/9.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PersonalSecondCell.h"

@protocol PersonalInfoDelegate <NSObject>

@optional
- (void)withdrawTrans;

@end

@interface PersonInfoDataSource : NSObject<UITableViewDataSource,PersonalCellWithdrawDelegate>

@property (strong, nonatomic) id<PersonalInfoDelegate> delegate;

@end
