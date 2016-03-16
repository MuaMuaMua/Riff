//
//  RiffViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/11.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "RiffViewController.h"

@interface RiffViewController ()

@end

@implementation RiffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.riffWebView loadHTMLString:@"http://chuangcifang.co/" baseURL:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
