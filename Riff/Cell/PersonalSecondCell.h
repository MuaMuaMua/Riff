//
//  PersonalSecondCell.h
//  Riff
//
//  Created by wuhaibin on 16/3/10.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalCellWithdrawDelegate <NSObject>

@optional
- (void)withdrawAction;

@end

@interface PersonalSecondCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *numberlLabel;

@property (strong, nonatomic) IBOutlet UIButton *withdrawalBtn;

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) id<PersonalCellWithdrawDelegate> delegate;

@end
