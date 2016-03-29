//
//  RiffWebViewController.m
//  Riff
//
//  Created by wuhaibin on 16/3/22.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "RiffWebViewController.h"

@interface RiffWebViewController () {
    UIWebView * _webView;
}

@end

@implementation RiffWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupWebView 
- (void)setupWebView {
    CGRect winSize = [[UIScreen mainScreen]bounds];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, winSize.size.width, winSize.size.height)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.24.93.146:8088/Advertisement/getAdvertisement?userId=1&advertisementId=1"]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
