//
//  BasicInfoCell.h
//  Riff
//
//  Created by wuhaibin on 16/3/11.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIView *separatorView;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end
