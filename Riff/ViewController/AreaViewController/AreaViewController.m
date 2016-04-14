//
//  AreaViewController.m
//  Riff
//
//  Created by wuhaibin on 16/4/12.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "AreaViewController.h"
#import "ProvinceCell.h"
#import "CityViewController.h"

@interface AreaViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    IBOutlet UITableView *_tableView;
    
    NSMutableDictionary * _provincesDictionary;
    
    NSMutableArray * _provincesArray;
}

@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地区";
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Provinces" ofType:@"plist"];
    _provincesArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * certif = @"ProvinceCell";
    UINib * nib = [UINib nibWithNibName:certif bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:certif];
    ProvinceCell * cell = [tableView dequeueReusableCellWithIdentifier:certif];
    if (cell == nil) {
        cell = [[ProvinceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certif];
    }
    //初始化Cell的title
    NSMutableDictionary * provinceDictionary = [_provincesArray objectAtIndex:indexPath.row];
    NSString * provinceName = [provinceDictionary objectForKey:@"ProvinceName"];
    NSArray * cityArray = [provinceDictionary objectForKey:@"cities"];
    
    cell.provinceLabel.text = provinceName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //判断是不是特许情况  北京0 天津1 上海8 重庆21 香港（31）  澳门（32） 总共6 个 .
    NSDictionary * province = [_provincesArray objectAtIndex:indexPath.row];
    NSString * provinceName = [province objectForKey:@"ProvinceName"];
    [[NSUserDefaults standardUserDefaults]setObject:provinceName forKey:@"selectProvinceName"];
    CityViewController * cityViewController = [[CityViewController alloc]init];
    cityViewController.provinceName = provinceName;
    //默认是special
    cityViewController.isSpecial = YES;
    if (indexPath.row == 0) {
        //北京
        cityViewController.areaArray = [self getBeiJingArea];
        [self.navigationController pushViewController:cityViewController animated:YES];
    }else if (indexPath.row == 1) {
        //天津
        cityViewController.areaArray = [self getTianJinArea];
        [self.navigationController pushViewController:cityViewController animated:YES];
    }else if (indexPath.row == 8) {
        //上海
        cityViewController.areaArray = [self getShangHaiArea];
        [self.navigationController pushViewController:cityViewController animated:YES];
    }else if (indexPath.row == 21) {
        //重庆
        cityViewController.areaArray = [self getChongQingArea];
        [self.navigationController pushViewController:cityViewController animated:YES];
    }else if (indexPath.row == 31) {
        //香港
        cityViewController.areaArray = [self getHongKongArea];
        [self.navigationController pushViewController:cityViewController animated:YES];
    }else if (indexPath.row == 32) {
        //澳门
        cityViewController.areaArray = [self getMaCauArea];
        [self.navigationController pushViewController:cityViewController animated:YES];
    }else if (indexPath.row == 33){
        cityViewController.areaArray = [self getTaiWan];
        [self.navigationController pushViewController:cityViewController animated:YES];
    }
    else {
        //选中其他省份。
        NSArray * cityArray = [province objectForKey:@"cities"];
        cityViewController.isSpecial = NO;
        cityViewController.cityArray = cityArray;
        [self.navigationController pushViewController:cityViewController animated:YES];
    }
    // 重新赋值 到 内容中
}

- (NSArray *)getTaiWan {
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //高雄
    NSDictionary * gaoxiong = [NSDictionary dictionaryWithObject:@"高雄" forKey:@"CityName"];

    //花莲县
    NSDictionary * hualianxian = [NSDictionary dictionaryWithObject:@"花莲县" forKey:@"CityName"];

    //基隆市
    NSDictionary * jilongshi = [NSDictionary dictionaryWithObject:@"基隆市" forKey:@"CityName"];

    //金门县
    NSDictionary * jinmenxian = [NSDictionary dictionaryWithObject:@"金门县" forKey:@"CityName"];

    //嘉义市
    NSDictionary * jiayishi = [NSDictionary dictionaryWithObject:@"嘉义市" forKey:@"CityName"];

    //嘉义县
    NSDictionary * jiayixian = [NSDictionary dictionaryWithObject:@"嘉义县" forKey:@"CityName"];

    //连江县
    NSDictionary * lianjiangxian = [NSDictionary dictionaryWithObject:@"连江县" forKey:@"CityName"];

    //苗粟县
    NSDictionary * miaosuxian = [NSDictionary dictionaryWithObject:@"苗粟县" forKey:@"CityName"];

    //南投县
    NSDictionary * nantouxian = [NSDictionary dictionaryWithObject:@"南投县" forKey:@"CityName"];

    //屏东县
    NSDictionary * pingdongxian = [NSDictionary dictionaryWithObject:@"屏东县" forKey:@"CityName"];

    //澎湖县
    NSDictionary * penghuxian = [NSDictionary dictionaryWithObject:@"澎湖县" forKey:@"CityName"];

    //台北市
    NSDictionary * taibeishi = [NSDictionary dictionaryWithObject:@"台北市" forKey:@"CityName"];

    //台东县
    NSDictionary * taidongxian = [NSDictionary dictionaryWithObject:@"台东县" forKey:@"CityName"];

    //桃园县
    NSDictionary * taoyuanxian = [NSDictionary dictionaryWithObject:@"桃园县" forKey:@"CityName"];

    //台中市
    NSDictionary * taizhongshi = [NSDictionary dictionaryWithObject:@"台中市" forKey:@"CityName"];

    //新北市
    NSDictionary * xinbeishi = [NSDictionary dictionaryWithObject:@"新北市" forKey:@"CityName"];

    //新竹市
    NSDictionary * xinzhushi = [NSDictionary dictionaryWithObject:@"新竹市" forKey:@"CityName"];

    //新竹县
    NSDictionary * xinzhuxian = [NSDictionary dictionaryWithObject:@"新竹县" forKey:@"CityName"];

    //云林县
    NSDictionary * yunlinxian = [NSDictionary dictionaryWithObject:@"云林县" forKey:@"CityName"];

    //宜兰县
    NSDictionary * yilanxian = [NSDictionary dictionaryWithObject:@"宜兰县" forKey:@"CityName"];

    //彰化县
    NSDictionary * zhanghuaxian = [NSDictionary dictionaryWithObject:@"彰化县" forKey:@"CityName"];

    [cityArray addObject:zhanghuaxian];
    [cityArray addObject:yilanxian];
    [cityArray addObject:yunlinxian];
    [cityArray addObject:xinzhushi];
    [cityArray addObject:xinzhuxian];
    [cityArray addObject:xinbeishi];
    [cityArray addObject:taizhongshi];
    [cityArray addObject:taoyuanxian];
    [cityArray addObject:taidongxian];
    [cityArray addObject:taibeishi];
    [cityArray addObject:pingdongxian];
    [cityArray addObject:penghuxian];
    [cityArray addObject:nantouxian];
    [cityArray addObject:miaosuxian];
    [cityArray addObject:lianjiangxian];
    [cityArray addObject:jiayishi];
    [cityArray addObject:jiayixian];
    [cityArray addObject:jinmenxian];
    [cityArray addObject:jilongshi];
    [cityArray addObject:gaoxiong];
    [cityArray addObject:hualianxian];
    
    return cityArray;
    
}

- (NSArray *)getBeiJingArea {
    
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //昌平
    NSDictionary * changPing = [NSDictionary dictionaryWithObject:@"昌平" forKey:@"CityName"];
    //朝阳
    NSDictionary * zhaoYang = [NSDictionary dictionaryWithObject:@"朝阳" forKey:@"CityName"];
    //东城
    NSDictionary * dongCheng = [NSDictionary dictionaryWithObject:@"东城" forKey:@"CityName"];
    
    //大兴
    NSDictionary * daXing = [NSDictionary dictionaryWithObject:@"大兴" forKey:@"CityName"];
    
    //房山
    NSDictionary * fangShan = [NSDictionary dictionaryWithObject:@"房山" forKey:@"CityName"];
    
    //丰台
    NSDictionary * fengTai = [NSDictionary dictionaryWithObject:@"丰台" forKey:@"CityName"];
    
    //海淀
    NSDictionary * haiDian = [NSDictionary dictionaryWithObject:@"海淀 " forKey:@"CityName"];
    
    //怀柔
    NSDictionary * huaiRou = [NSDictionary dictionaryWithObject:@"怀柔" forKey:@"CityName"];

    //门头沟
    NSDictionary * menTouGou = [NSDictionary dictionaryWithObject:@"门头沟" forKey:@"CityName"];
    
    //密云
    NSDictionary * miYun = [NSDictionary dictionaryWithObject:@"密云" forKey:@"CityName"];
    
    //平谷
    NSDictionary * pingGu = [NSDictionary dictionaryWithObject:@"平谷" forKey:@"CityName"];
    
    //石景山
    NSDictionary * shiJingShan = [NSDictionary dictionaryWithObject:@"石景山" forKey:@"CityName"];

    //顺义
    NSDictionary * shunYi = [NSDictionary dictionaryWithObject:@"顺义" forKey:@"CityName"];
    
    //通州
    NSDictionary * tongZhou = [NSDictionary dictionaryWithObject:@"通州" forKey:@"CityName"];

    //西城
    NSDictionary * xiCheng = [NSDictionary dictionaryWithObject:@"西城" forKey:@"CityName"];
    
    //延庆
    NSDictionary * yanQing = [NSDictionary dictionaryWithObject:@"延庆" forKey:@"CityName"];

    [cityArray addObject:yanQing];
    [cityArray addObject:xiCheng];
    [cityArray addObject:tongZhou];
    [cityArray addObject:shunYi];
    [cityArray addObject:shiJingShan];
    [cityArray addObject:pingGu];
    [cityArray addObject:miYun];
    [cityArray addObject:menTouGou];
    [cityArray addObject:huaiRou];
    [cityArray addObject:haiDian];
    [cityArray addObject:fengTai];
    [cityArray addObject:fangShan];
    [cityArray addObject:daXing];
    [cityArray addObject: dongCheng];
    [cityArray addObject:zhaoYang];
    [cityArray addObject:changPing];
    
    return cityArray;
}

- (NSArray *)getTianJinArea {
    
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    //北辰
    NSDictionary * beichen = [NSDictionary dictionaryWithObject:@"北辰" forKey:@"CityName"];

    //宝坻
    NSDictionary * baodi = [NSDictionary dictionaryWithObject:@"宝坻" forKey:@"CityName"];

    //滨海新区
    NSDictionary * binhaixinqu = [NSDictionary dictionaryWithObject:@"滨海新区" forKey:@"CityName"];

    //东丽
    NSDictionary * dongli = [NSDictionary dictionaryWithObject:@"东丽" forKey:@"CityName"];
    
    //河北
    NSDictionary * hebei = [NSDictionary dictionaryWithObject:@"河北" forKey:@"CityName"];

    //河东
    NSDictionary * hedong = [NSDictionary dictionaryWithObject:@"河东" forKey:@"CityName"];

    //和平
    NSDictionary * heping = [NSDictionary dictionaryWithObject:@"和平" forKey:@"CityName"];
    
    //红桥
    NSDictionary * hongqiao = [NSDictionary dictionaryWithObject:@"红桥" forKey:@"CityName"];
    
    //河西
    NSDictionary * hexi = [NSDictionary dictionaryWithObject:@"河西" forKey:@"CityName"];
    
    //静海
    NSDictionary * jinghai = [NSDictionary dictionaryWithObject:@"静海" forKey:@"CityName"];
    
    //津南
    NSDictionary * jinnan = [NSDictionary dictionaryWithObject:@"津南" forKey:@"CityName"];
    
    //蓟县
    NSDictionary * jixian = [NSDictionary dictionaryWithObject:@"蓟县" forKey:@"CityName"];
    
    //宁河
    NSDictionary * ninghe = [NSDictionary dictionaryWithObject:@"宁河" forKey:@"CityName"];

    //南开
    NSDictionary * nankai = [NSDictionary dictionaryWithObject:@"南开" forKey:@"CityName"];
    
    //武清
    NSDictionary * wuqing = [NSDictionary dictionaryWithObject:@"武清" forKey:@"CityName"];

    //西青
    NSDictionary * xiqing = [NSDictionary dictionaryWithObject:@"西青" forKey:@"CityName"];
    
    [cityArray addObject:xiqing];
    [cityArray addObject:wuqing];
    [cityArray addObject:nankai];
    [cityArray addObject:ninghe];
    [cityArray addObject:jixian];
    [cityArray addObject:jinnan];
    [cityArray addObject:jinghai];
    [cityArray addObject:hexi];
    [cityArray addObject:hongqiao];
    [cityArray addObject:heping];
    [cityArray addObject:hedong];
    [cityArray addObject:hebei];
    [cityArray addObject:dongli];
    [cityArray addObject:binhaixinqu];
    [cityArray addObject:baodi];
    [cityArray addObject:beichen];
    
    return cityArray;
}

- (NSArray *)getShangHaiArea {
    // 上海
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //宝山
    NSDictionary * baoshan = [NSDictionary dictionaryWithObject:@"宝山" forKey:@"CityName"];

    //崇明
    NSDictionary * chongming = [NSDictionary dictionaryWithObject:@"崇明" forKey:@"CityName"];

    //长宁
    NSDictionary * changning = [NSDictionary dictionaryWithObject:@"长宁" forKey:@"CityName"];

    //奉贤
    NSDictionary * fengxian = [NSDictionary dictionaryWithObject:@"奉贤" forKey:@"CityName"];
    
    //虹口
    NSDictionary * hongkou = [NSDictionary dictionaryWithObject:@"虹口" forKey:@"CityName"];
    
    //黄埔
    NSDictionary * huangpu = [NSDictionary dictionaryWithObject:@"黄埔" forKey:@"CityName"];

    //静安
    NSDictionary * jingan = [NSDictionary dictionaryWithObject:@"静安" forKey:@"CityName"];

    //嘉定
    NSDictionary * jiading = [NSDictionary dictionaryWithObject:@"嘉定" forKey:@"CityName"];

    //金山
    NSDictionary * jinshan = [NSDictionary dictionaryWithObject:@"金山" forKey:@"CityName"];
    
    // 卢湾
    NSDictionary * luwan = [NSDictionary dictionaryWithObject:@"卢湾" forKey:@"CityName"];
    
    //闵行
    NSDictionary * minxing = [NSDictionary dictionaryWithObject:@"闵行" forKey:@"CityName"];
    
    //浦东新区
    NSDictionary * pudongxinqu = [NSDictionary dictionaryWithObject:@"浦东新区" forKey:@"CityName"];
    
    //普陀
    NSDictionary * putuo = [NSDictionary dictionaryWithObject:@"普陀" forKey:@"CityName"];

    //青浦
    NSDictionary * qingpu = [NSDictionary dictionaryWithObject:@"青浦" forKey:@"CityName"];
    
    //松江
    NSDictionary * songjiang = [NSDictionary dictionaryWithObject:@"松江" forKey:@"CityName"];

    //徐汇
    NSDictionary * xuhui = [NSDictionary dictionaryWithObject:@"徐汇" forKey:@"CityName"];

    //杨浦
    NSDictionary * yangpu = [NSDictionary dictionaryWithObject:@"杨浦" forKey:@"CityName"];

    //闸北
    NSDictionary * zhabei = [NSDictionary dictionaryWithObject:@"闸北" forKey:@"CityName"];

    [cityArray addObject:zhabei];
    [cityArray addObject:yangpu];
    [cityArray addObject:xuhui];
    [cityArray addObject:songjiang];
    [cityArray addObject:qingpu];
    [cityArray addObject:putuo];
    [cityArray addObject:pudongxinqu];
    [cityArray addObject:minxing];
    [cityArray addObject:luwan];
    [cityArray addObject:jiading];
    [cityArray addObject:jinshan];
    [cityArray addObject:baoshan];
    [cityArray addObject:chongming];
    [cityArray addObject:changning];
    [cityArray addObject:changning];
    [cityArray addObject:fengxian];
    [cityArray addObject:hongkou];
    [cityArray addObject:huangpu];
    [cityArray addObject:jingan];
    
    return cityArray;
}

- (NSArray *)getChongQingArea {
    
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //北碚
    NSDictionary * beibei = [NSDictionary dictionaryWithObject:@"北碚" forKey:@"CityName"];
    //巴南
    NSDictionary * banan = [NSDictionary dictionaryWithObject:@"巴南" forKey:@"CityName"];
    //璧山
    NSDictionary * bishan = [NSDictionary dictionaryWithObject:@"璧山" forKey:@"CityName"];
    //城口
    NSDictionary * chengkou = [NSDictionary dictionaryWithObject:@"城口" forKey:@"CityName"];
    //长寿
    NSDictionary * changshou = [NSDictionary dictionaryWithObject:@"长寿" forKey:@"CityName"];
    //大渡口
    NSDictionary * dadukou = [NSDictionary dictionaryWithObject:@"大渡口" forKey:@"CityName"];
    //垫江
    NSDictionary * dianjiang = [NSDictionary dictionaryWithObject:@"垫江" forKey:@"CityName"];
    //大足
    NSDictionary * dazu = [NSDictionary dictionaryWithObject:@"大足" forKey:@"CityName"];
    //丰都
    NSDictionary * fengdu = [NSDictionary dictionaryWithObject:@"丰都" forKey:@"CityName"];
    //奉节
    NSDictionary * fengjie = [NSDictionary dictionaryWithObject:@"奉节" forKey:@"CityName"];
    //涪陵
    NSDictionary * fuling = [NSDictionary dictionaryWithObject:@"涪陵" forKey:@"CityName"];
    //合川
    NSDictionary * hechuan = [NSDictionary dictionaryWithObject:@"合川" forKey:@"CityName"];
    //北江
    NSDictionary * beijiang = [NSDictionary dictionaryWithObject:@"北江 " forKey:@"CityName"];
    //北津
    NSDictionary * beijin = [NSDictionary dictionaryWithObject:@"北津" forKey:@"CityName"];
    //九龙坡
    NSDictionary * jiulongpo = [NSDictionary dictionaryWithObject:@"九龙坡" forKey:@"CityName"];
    //开县
    NSDictionary * kaixian = [NSDictionary dictionaryWithObject:@"开县" forKey:@"CityName"];
    //两江新区
    NSDictionary * liangjiangxinqu  = [NSDictionary dictionaryWithObject:@"两江新区" forKey:@"CityName"];
    //梁平
    NSDictionary * liangping = [NSDictionary dictionaryWithObject:@"梁平" forKey:@"CityName"];
    //南岸
    NSDictionary * nanan = [NSDictionary dictionaryWithObject:@"南岸" forKey:@"CityName"];
    //南川
    NSDictionary * nanchuan = [NSDictionary dictionaryWithObject:@"南川" forKey:@"CityName"];
    //彭水
    NSDictionary * pengshui = [NSDictionary dictionaryWithObject:@"彭水" forKey:@"CityName"];
    //綦江区
    NSDictionary * qijiangqu = [NSDictionary dictionaryWithObject:@"綦江区" forKey:@"CityName"];
    //黔江
    NSDictionary * qianjiang = [NSDictionary dictionaryWithObject:@"黔江" forKey:@"CityName"];
    //荣昌
    NSDictionary * rongchang = [NSDictionary dictionaryWithObject:@"荣昌" forKey:@"CityName"];
    //沙坪坝
    NSDictionary * shapingba = [NSDictionary dictionaryWithObject:@"沙坪坝" forKey:@"CityName"];
    //双桥
    NSDictionary * shuangqiao = [NSDictionary dictionaryWithObject:@"双桥" forKey:@"CityName"];
    //石柱
    NSDictionary * shizhu = [NSDictionary dictionaryWithObject:@"石柱" forKey:@"CityName"];
    //铜梁
    NSDictionary * tongliang = [NSDictionary dictionaryWithObject:@"铜梁" forKey:@"CityName"];
    //潼南
    NSDictionary * tongnan = [NSDictionary dictionaryWithObject:@"潼南" forKey:@"CityName"];
    //武隆
    NSDictionary * wulong = [NSDictionary dictionaryWithObject:@"武隆" forKey:@"CityName"];
    //巫山
    NSDictionary * wushan = [NSDictionary dictionaryWithObject:@"巫山" forKey:@"CityName"];
    //万盛
    NSDictionary * wansheng = [NSDictionary dictionaryWithObject:@"万盛" forKey:@"CityName"];
    //巫溪
    NSDictionary * wuxi = [NSDictionary dictionaryWithObject:@"巫溪" forKey:@"CityName"];
    //万州
    NSDictionary * wanzhou = [NSDictionary dictionaryWithObject:@"万州" forKey:@"CityName"];
    //秀山
    NSDictionary * xiushan = [NSDictionary dictionaryWithObject:@"秀山" forKey:@"CityName"];
    //渝北
    NSDictionary * yubei = [NSDictionary dictionaryWithObject:@"渝北 " forKey:@"CityName"];
    //永川
    NSDictionary * yongchuan = [NSDictionary dictionaryWithObject:@"永川" forKey:@"CityName"];
    //酉阳
    NSDictionary * youyang = [NSDictionary dictionaryWithObject:@"酉阳" forKey:@"CityName"];
    //云阳
    NSDictionary * yunyang = [NSDictionary dictionaryWithObject:@"云阳" forKey:@"CityName"];
    //渝中
    NSDictionary * yuzhong = [NSDictionary dictionaryWithObject:@"渝中" forKey:@"CityName"];
    //忠县
    NSDictionary * zhongxian = [NSDictionary dictionaryWithObject:@"忠县" forKey:@"CityName"];

    [cityArray addObject:zhongxian];
    [cityArray addObject:yuzhong];
    [cityArray addObject:yunyang];
    [cityArray addObject:youyang];
    [cityArray addObject:yongchuan];
    [cityArray addObject:yubei];
    [cityArray addObject:xiushan];
    [cityArray addObject:wanzhou];
    [cityArray addObject:wuxi];
    [cityArray addObject:wansheng];
    [cityArray addObject:pengshui];
    [cityArray addObject:qijiangqu];
    [cityArray addObject:qianjiang];
    [cityArray addObject:rongchang];
    [cityArray addObject:shapingba];
    [cityArray addObject:shuangqiao];
    [cityArray addObject:shizhu];
    [cityArray addObject:tongliang];
    [cityArray addObject:tongnan];
    [cityArray addObject:wulong];
    [cityArray addObject:wushan];
    [cityArray addObject:fuling];
    [cityArray addObject:hechuan];
    [cityArray addObject:beijiang];
    [cityArray addObject:beijin];
    [cityArray addObject:jiulongpo];
    [cityArray addObject:kaixian];
    [cityArray addObject:liangjiangxinqu];
    [cityArray addObject:liangping];
    [cityArray addObject:nanan];
    [cityArray addObject:nanchuan];
    [cityArray addObject:beibei];
    [cityArray addObject:banan];
    [cityArray addObject:bishan];
    [cityArray addObject:chengkou];
    [cityArray addObject:changshou];
    [cityArray addObject:dadukou];
    [cityArray addObject:dianjiang];
    [cityArray addObject:dazu];
    [cityArray addObject:fengdu];
    [cityArray addObject:fengjie];
    
    return cityArray;
}

- (NSArray *)getHongKongArea {
    
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //北区
    NSDictionary * beiQu = [NSDictionary dictionaryWithObject:@"北区" forKey:@"CityName"];

    //大埔区
    NSDictionary * daBuQu = [NSDictionary dictionaryWithObject:@"大埔区" forKey:@"CityName"];

    //东区
    NSDictionary * dongQu = [NSDictionary dictionaryWithObject:@"东区" forKey:@"CityName"];
    
    //观塘区
    NSDictionary * guanTangQu = [NSDictionary dictionaryWithObject:@"观塘区" forKey:@"CityName"];

    //黄大仙区
    NSDictionary * huangDaXianQu = [NSDictionary dictionaryWithObject:@"黄大仙区" forKey:@"CityName"];
    
    //九龙城区
    NSDictionary * jiuLongChengQu = [NSDictionary dictionaryWithObject:@"九龙城区" forKey:@"CityName"];

    //葵青区
    NSDictionary * kuiqingqu = [NSDictionary dictionaryWithObject:@"葵青区" forKey:@"CityName"];

    //离岛区
    NSDictionary * lidaoqu = [NSDictionary dictionaryWithObject:@"离岛区" forKey:@"CityName"];

    //南区
    NSDictionary * nanqu = [NSDictionary dictionaryWithObject:@"南区" forKey:@"CityName"];
    
    //荃湾区
    NSDictionary * quanwanqu = [NSDictionary dictionaryWithObject:@"荃湾区" forKey:@"CityName"];
    
    //深水埗区
    NSDictionary * shenshuibuqu = [NSDictionary dictionaryWithObject:@"深水埗区" forKey:@"CityName"];

    //沙田区
    NSDictionary * shatianqu = [NSDictionary dictionaryWithObject:@"沙田区" forKey:@"CityName"];

    //屯门区
    NSDictionary * tunmenqu = [NSDictionary dictionaryWithObject:@"屯门区" forKey:@"CityName"];

    //湾仔区
    NSDictionary * wanzaiqu = [NSDictionary dictionaryWithObject:@"湾仔区" forKey:@"CityName"];
    
    //西贡区
    NSDictionary * xigongqu = [NSDictionary dictionaryWithObject:@"西贡区" forKey:@"CityName"];
    
    //油尖旺区
    NSDictionary * youjianwangqu = [NSDictionary dictionaryWithObject:@"油尖旺区" forKey:@"CityName"];

    //元朗区
    NSDictionary * yuanlangqu = [NSDictionary dictionaryWithObject:@"元朗区" forKey:@"CityName"];
    
    //中西区
    NSDictionary * zhongxiqu = [NSDictionary dictionaryWithObject:@"中西区" forKey:@"CityName"];

    [cityArray addObject:zhongxiqu];
    [cityArray addObject:yuanlangqu];
    [cityArray addObject:youjianwangqu];
    [cityArray addObject:xigongqu];
    [cityArray addObject:wanzaiqu];
    [cityArray addObject:tunmenqu];
    [cityArray addObject:shatianqu];
    [cityArray addObject:shenshuibuqu];
    [cityArray addObject:quanwanqu];
    [cityArray addObject:nanqu];
    [cityArray addObject:lidaoqu];
    [cityArray addObject:kuiqingqu];
    [cityArray addObject:jiuLongChengQu];
    [cityArray addObject:huangDaXianQu];
    [cityArray addObject:guanTangQu];
    [cityArray addObject:dongQu];
    [cityArray addObject:daBuQu];
    [cityArray addObject:beiQu];
    
    return cityArray;
}

- (NSArray *)getMaCauArea {
    
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //大堂区
    NSDictionary * daTangQu = [NSDictionary dictionaryWithObject:@"大堂区" forKey:@"CityName"];
    
    //氹仔
    NSDictionary * dangZai = [NSDictionary dictionaryWithObject:@"氹仔" forKey:@"CityName"];

    //风顺堂区
    NSDictionary * fengShunTangQu = [NSDictionary dictionaryWithObject:@"风顺堂区" forKey:@"CityName"];

    //花地玛堂区
    NSDictionary * huaDiMaTangQu = [NSDictionary dictionaryWithObject:@"花地玛堂区" forKey:@"CityName"];
    
    //路环岛
    NSDictionary * luHuanDao = [NSDictionary dictionaryWithObject:@"路环岛" forKey:@"CityName"];

    //圣安多尼堂区
    NSDictionary * shengAnDuoNiTangQu = [NSDictionary dictionaryWithObject:@"圣安多尼堂区" forKey:@"CityName"];

    //望德堂区
    NSDictionary * wangDeTangQu = [NSDictionary dictionaryWithObject:@"望德堂区" forKey:@"CityName"];
    
    [cityArray addObject:wangDeTangQu];
    [cityArray addObject:shengAnDuoNiTangQu];
    [cityArray addObject:luHuanDao];
    [cityArray addObject:huaDiMaTangQu];
    [cityArray addObject:fengShunTangQu];
    [cityArray addObject:dangZai];
    [cityArray addObject:daTangQu];
    
    return cityArray;
}


@end
