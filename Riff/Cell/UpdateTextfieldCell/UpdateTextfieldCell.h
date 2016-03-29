//
//  UpdateTextfieldCell.h
//  Riff
//
//  Created by wuhaibin on 16/3/19.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateTextfieldCellDelegate <NSObject>

@optional

- (void)enableSaveBtn:(BOOL)enable;

@end

@interface UpdateTextfieldCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *updateTextfield;

@property (strong, nonatomic) id<UpdateTextfieldCellDelegate> delegate;

@property (strong, nonatomic) NSString * originalStr;

@end
