//
//  CityViewController.h
//  Riff
//
//  Created by wuhaibin on 16/4/12.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UIViewController

@property (strong,nonatomic) NSMutableDictionary * provinceDictionary;

@property (strong, nonatomic) NSArray * cityArray;

@property (strong, nonatomic) NSArray * areaArray;

@property (strong, nonatomic) NSString * provinceName;

@property BOOL isSpecial;

@end
