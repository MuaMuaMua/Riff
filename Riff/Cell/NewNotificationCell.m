//
//  NewNotificationCell.m
//  Riff
//
//  Created by wuhaibin on 16/3/16.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "NewNotificationCell.h"

@implementation NewNotificationCell {
    
    IBOutlet UISwitch *_switch;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)switchChange:(id)sender {
    //设置APNS 开关
    if (_switch.isOn) {
        NSLog(@"开启");
    }else {
        NSLog(@"取消APNS");
    }
}


@end
