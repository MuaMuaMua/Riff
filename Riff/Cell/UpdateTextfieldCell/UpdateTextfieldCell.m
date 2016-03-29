//
//  UpdateTextfieldCell.m
//  Riff
//
//  Created by wuhaibin on 16/3/19.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "UpdateTextfieldCell.h"

@implementation UpdateTextfieldCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [self.delegate enableSaveBtn:NO];
    [self.updateTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(id)sender {
    if ([self.updateTextfield.text isEqualToString:self.originalStr]) {
        [self.delegate enableSaveBtn:NO];
    }else {
        [self.delegate enableSaveBtn:YES];
    }
}


@end
