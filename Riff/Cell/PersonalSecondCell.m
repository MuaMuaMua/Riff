//
//  PersonalSecondCell.m
//  Riff
//
//  Created by wuhaibin on 16/3/10.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "PersonalSecondCell.h"

@implementation PersonalSecondCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickWithdraw:(id)sender {
    [self.delegate withdrawAction];
}
@end
