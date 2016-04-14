//
//  CityViewController.m
//  Riff
//
//  Created by wuhaibin on 16/4/12.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "CityViewController.h"
#import "CityCell.h"
#import "RiffNetworkManager.h"

@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    IBOutlet UITableView *_cityTableView;
    
    RiffNetworkManager * _riffNetworkManager;
}

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.provinceName;
    [self setupNetworkManager];
    [self setupTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupNetworkManager 
- (void)setupNetworkManager {
    _riffNetworkManager = [RiffNetworkManager sharedInstance];
    
}

#pragma mark - setupTableView delegate and dataSource
- (void)setupTableView {
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSpecial) {
        return self.areaArray.count;
    }else {
        return self.cityArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * certif = @"CityCell";
    UINib * nib = [UINib nibWithNibName:certif bundle:nil];
    [_cityTableView registerNib:nib forCellReuseIdentifier:certif];
    //创建TableviewCell
    CityCell * cell = [_cityTableView dequeueReusableCellWithIdentifier:certif];
    if (cell == nil) {
        cell = [[CityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
    }
    //赋值 具体城市名称
    if (self.isSpecial) {
        //负责赋值到 areaArray中的数值中
        NSDictionary * cityDictionary = [self.areaArray objectAtIndex:indexPath.row];
        
        NSString * cityName = [cityDictionary objectForKey:@"CityName"];
        cell.cityLabel.text = cityName;
    }else {
        //负责赋值到 cityArray中的数值中
        NSDictionary * cityDictionary = [self.cityArray objectAtIndex:indexPath.row];
        NSString * cityName = [cityDictionary objectForKey:@"CityName"];
        cell.cityLabel.text = cityName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //做出判断 保存地址信息
    NSDictionary * cityDictionary;
    if (self.isSpecial) {
        cityDictionary = [self.areaArray objectAtIndex:indexPath.row];
    }else {
        cityDictionary = [self.cityArray objectAtIndex:indexPath.row];
    }
    NSString * cityName = [cityDictionary objectForKey:@"CityName"];
    NSString * provinceStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectProvinceName"];
    NSString * wholeLocationStr;
    if (provinceStr!=nil) {
        wholeLocationStr = [provinceStr stringByAppendingString:[NSString stringWithFormat:@" - %@",cityName]];
        [[NSUserDefaults standardUserDefaults]setObject:wholeLocationStr forKey:@"locationStr"];
    }
    //没做请求失败处理.
    [_riffNetworkManager userChangeUserInfoWithProperty:@"city" PropertyValue:wholeLocationStr DTZSuccessBlock:^(NSDictionary *successBlock) {
        
        NSLog(@"上传成功");
    } DTZFailBlock:^(NSDictionary *failBlock) {
        NSLog(@"上传失败");
    }];
    
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
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
