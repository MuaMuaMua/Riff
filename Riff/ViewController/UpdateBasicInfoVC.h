//
//  UpdateBasicInfoVC.h
//  Riff
//
//  Created by wuhaibin on 16/3/19.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateBasicInfoVC : UIViewController


//typeStr 为 1 名字；2性别；3地区；4生日；5其他
@property (strong, nonatomic) NSString * typeStr;

@property (strong, nonatomic) NSString * originalStr;

@property (strong, nonatomic) NSString * keyStr;

@property (strong, nonatomic) NSString * originalValue;

@property (strong, nonatomic) NSString * titleStr;

@end
