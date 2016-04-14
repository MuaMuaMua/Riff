//
//  ProvinceModel.m
//  Riff
//
//  Created by wuhaibin on 16/4/12.
//  Copyright © 2016年 wuhaibin. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel

- (void)setupProvinceArray {
    
}

- (NSMutableDictionary *)setBeiJing {
    //北京
    NSMutableDictionary * beiJingDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    //太兴
    NSDictionary * taiXing = [NSDictionary dictionaryWithObject:@"太兴" forKey:@"city"];
    //平谷
    NSDictionary * pingGu = [NSDictionary dictionaryWithObject:@"平谷" forKey:@"city"];
    //石景山
    NSDictionary * shiJingShan = [NSDictionary dictionaryWithObject:@"石景山" forKey:@"city"];
    //西城
    NSDictionary * xiCheng = [NSDictionary dictionaryWithObject:@"西城" forKey:@"city"];
    //延庆
    NSDictionary * yanQing = [NSDictionary dictionaryWithObject:@"延庆" forKey:@"city"];
    //门头沟
    NSDictionary * menTouGou = [NSDictionary dictionaryWithObject:@"门头沟" forKey:@"city"];
    //昌平
    NSDictionary * changPing = [NSDictionary dictionaryWithObject:@"昌平" forKey:@"city"];
    //房山
    NSDictionary * fangShan = [NSDictionary dictionaryWithObject:@"房山" forKey:@"city"];
    //东城
    NSDictionary * dongCheng = [NSDictionary dictionaryWithObject:@"东城" forKey:@"city"];
    //通州
    NSDictionary * tongZhou = [NSDictionary dictionaryWithObject:@"通州" forKey:@"city"];
    //海淀
    NSDictionary * haiDian = [NSDictionary dictionaryWithObject:@"海淀" forKey:@"city"];
    //密云
    NSDictionary * miYun = [NSDictionary dictionaryWithObject:@"密云" forKey:@"city"];
    //顺义
    NSDictionary * shunYi = [NSDictionary dictionaryWithObject:@"顺义" forKey:@"city"];
    //朝阳
    NSDictionary * zhaoYang = [NSDictionary dictionaryWithObject:@"朝阳" forKey:@"city"];
    //丰台
    NSDictionary * fengTai = [NSDictionary dictionaryWithObject:@"丰台" forKey:@"city"];
    //怀柔
    NSDictionary * huaiRou = [NSDictionary dictionaryWithObject:@"怀柔" forKey:@"city"];
    [cityArray addObject:taiXing];
    [cityArray addObject:pingGu];
    [cityArray addObject:shiJingShan];
    [cityArray addObject:xiCheng];
    [cityArray addObject:yanQing];
    [cityArray addObject:menTouGou];
    [cityArray addObject:changPing];
    [cityArray addObject:fangShan];
    [cityArray addObject:dongCheng];
    [cityArray addObject:tongZhou];
    [cityArray addObject:haiDian];
    [cityArray addObject:miYun];
    [cityArray addObject:shunYi];
    [cityArray addObject:zhaoYang];
    [cityArray addObject:fengTai];
    [cityArray addObject:fengTai];
    [cityArray addObject:huaiRou];
    [beiJingDictionary setObject:@"北京" forKey:@"Province"];
    [beiJingDictionary setObject:cityArray forKey:@"cityArray"];
    return beiJingDictionary;
}

- (NSMutableDictionary *)setShanXi {
    //山西
    NSMutableDictionary * shanXiProvince = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    //大同
    NSDictionary * daTong = [NSDictionary dictionaryWithObject:@"大同" forKey:@"city"];
    //太原
    NSDictionary * taiYuan = [NSDictionary dictionaryWithObject:@"太原" forKey:@"city"];
    //吕梁
    NSDictionary * xinZhou = [NSDictionary dictionaryWithObject:@"忻州" forKey:@"city"];
    //长治
    NSDictionary * changZhi = [NSDictionary dictionaryWithObject:@"长治" forKey:@"city"];
    //晋中
    NSDictionary * jinZhong = [NSDictionary dictionaryWithObject:@"晋中" forKey:@"city"];
    //晋城
    NSDictionary * jinCheng = [NSDictionary dictionaryWithObject:@"晋城" forKey:@"city"];
    //朔州
    NSDictionary * shuoZhou = [NSDictionary dictionaryWithObject:@"朔州" forKey:@"city"];
    //阳泉
    NSDictionary * yunCheng = [NSDictionary dictionaryWithObject:@"运城" forKey:@"city"];
    //临汾
    NSDictionary * linFen = [NSDictionary dictionaryWithObject:@"临汾" forKey:@"city"];
    [shanXiProvince setObject:@"山西" forKey:@"Province"];
    [cityArray addObject:daTong];
    [cityArray addObject:taiYuan];
    [cityArray addObject:xinZhou];
    [cityArray addObject:changZhi];
    [cityArray addObject:jinCheng];
    [cityArray addObject:jinZhong];
    [cityArray addObject:shuoZhou];
    [cityArray addObject:yunCheng];
    [cityArray addObject:linFen];
    [shanXiProvince setObject:cityArray forKey:@"cityArray"];
    return shanXiProvince;
}

- (NSMutableDictionary *)setShanDong {
    //山东
    NSMutableDictionary * shanDongProvince = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    //日照
    NSDictionary * riZhao = [NSDictionary dictionaryWithObject:@"日照" forKey:@"city"];
    //青岛
    NSDictionary * qingDao = [NSDictionary dictionaryWithObject:@"青岛" forKey:@"city"];
    //东营
    NSDictionary * dongYing = [NSDictionary dictionaryWithObject:@"东营" forKey:@"city"];
    //威海
    NSDictionary * weiHai = [NSDictionary dictionaryWithObject:@"威海" forKey:@"city"];
    //泰安
    NSDictionary * taiAn = [NSDictionary dictionaryWithObject:@"泰安" forKey:@"city"];
    //莱芜
    NSDictionary * laiWu = [NSDictionary dictionaryWithObject:@"莱芜" forKey:@"city"];
    //聊城
    NSDictionary * liaoCheng = [NSDictionary dictionaryWithObject:@"聊城" forKey:@"city"];
    //淄博
    NSDictionary * ziBo = [NSDictionary dictionaryWithObject:@"淄博" forKey:@"city"];
    //菏泽
    NSDictionary * heZe = [NSDictionary dictionaryWithObject:@"菏泽" forKey:@"city"];
    //枣庄
    NSDictionary * zaoZhuang = [NSDictionary dictionaryWithObject:@"枣庄" forKey:@"city"];
    //滨州
    NSDictionary * binZhou = [NSDictionary dictionaryWithObject:@"滨州" forKey:@"city"];
    //德州
    NSDictionary * deZhou = [NSDictionary dictionaryWithObject:@"德州" forKey:@"city"];
    //济南
    NSDictionary * jiNan = [NSDictionary dictionaryWithObject:@"济南" forKey:@"city"];
    //济宁
    NSDictionary * jiNing = [NSDictionary dictionaryWithObject:@"济宁" forKey:@"city"];
    //烟台
    NSDictionary * yanTai = [NSDictionary dictionaryWithObject:@"烟台" forKey:@"city"];
    //潍坊
    NSDictionary * weiFang = [NSDictionary dictionaryWithObject:@"潍坊" forKey:@"city"];
    //临沂
    NSDictionary * linYi = [NSDictionary dictionaryWithObject:@"临沂" forKey:@"city"];

    [cityArray addObject:linYi];
    [cityArray addObject:weiFang];
    [cityArray addObject:yanTai];
    [cityArray addObject:jiNing];
    [cityArray addObject:jiNan];
    [cityArray addObject:deZhou];
    [cityArray addObject:binZhou];
    [cityArray addObject:zaoZhuang];
    [cityArray addObject:heZe];
    [cityArray addObject:ziBo];
    [cityArray addObject:liaoCheng];
    [cityArray addObject:laiWu];
    [cityArray addObject:taiAn];
    [cityArray addObject:weiHai];
    [cityArray addObject:dongYing];
    [cityArray addObject:qingDao];
    [cityArray addObject:riZhao];
    
    [shanDongProvince setObject:@"山东" forKey:@"Province"];
    [shanDongProvince setObject:cityArray forKey:@"cityArray"];
    return shanDongProvince;
}

- (NSMutableDictionary *)setShangHai {
    //上海
    
    NSMutableDictionary * shangHaiProvince = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //宝山
    NSDictionary * baoShan = [NSDictionary dictionaryWithObject:@"宝山" forKey:@"city"];
    //崇明
    NSDictionary * chongMing = [NSDictionary dictionaryWithObject:@"崇明" forKey:@"city"];
    //长宁
    NSDictionary * changNing = [NSDictionary dictionaryWithObject:@"长宁" forKey:@"city"];
    //奉贤
    NSDictionary * fengXian = [NSDictionary dictionaryWithObject:@"奉贤" forKey:@"city"];
    //虹口
    NSDictionary * hongKou = [NSDictionary dictionaryWithObject:@"虹口" forKey:@"city"];
    //黄浦
    NSDictionary * huangPu = [NSDictionary dictionaryWithObject:@"黄埔" forKey:@"city"];
    //静安
    NSDictionary * jingAn = [NSDictionary dictionaryWithObject:@"静安" forKey:@"city"];
    //嘉定
    NSDictionary * jiaDing = [NSDictionary dictionaryWithObject:@"嘉定" forKey:@"city"];
    //金山
    NSDictionary * jinShan = [NSDictionary dictionaryWithObject:@"金山" forKey:@"city"];
    //卢湾
    NSDictionary * luWan = [NSDictionary dictionaryWithObject:@"卢湾" forKey:@"city"];
    //闵行
    NSDictionary * minXing = [NSDictionary dictionaryWithObject:@"闵行" forKey:@"city"];
    //浦东新区
    NSDictionary * puDongXinQu = [NSDictionary dictionaryWithObject:@"浦东新区" forKey:@"city"];
    //普陀
    NSDictionary * puTuo = [NSDictionary dictionaryWithObject:@"普陀" forKey:@"city"];
    //青浦
    NSDictionary * qingPu = [NSDictionary dictionaryWithObject:@"青浦" forKey:@"city"];
    //松江
    NSDictionary * songJiang = [NSDictionary dictionaryWithObject:@"松江" forKey:@"city"];
    //徐汇
    NSDictionary * xuHui = [NSDictionary dictionaryWithObject:@"徐汇" forKey:@"city"];
    //杨浦
    NSDictionary * yangPu = [NSDictionary dictionaryWithObject:@"杨浦" forKey:@"city"];
    //闸北
    NSDictionary *zhaBei = [NSDictionary dictionaryWithObject:@"闸北" forKey:@"city"];
    
    [cityArray addObject:zhaBei];
    [cityArray addObject:yangPu];
    [cityArray addObject:xuHui];
    [cityArray addObject:songJiang];
    [cityArray addObject:qingPu];
    [cityArray addObject:puTuo];
    [cityArray addObject:puDongXinQu];
    [cityArray addObject:minXing];
    [cityArray addObject:luWan];
    [cityArray addObject:jinShan];
    [cityArray addObject:jiaDing];
    [cityArray addObject:jingAn];
    [cityArray addObject:huangPu];
    [cityArray addObject:hongKou];
    [cityArray addObject:fengXian];
    [cityArray addObject:changNing];
    [cityArray addObject:chongMing];
    [cityArray addObject:baoShan];
    
    [shangHaiProvince setObject:@"上海" forKey:@"Province"];
    [shangHaiProvince setObject:cityArray forKey:@"cityArray"];
    return shangHaiProvince;
}

- (NSMutableDictionary *)setTianjin {
    //天津
    NSMutableDictionary * tianJinDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //北辰
    NSDictionary * beiChen = [NSDictionary dictionaryWithObject:@"北辰" forKey:@"city"];
    //宝坻
    NSDictionary * baoDi = [NSDictionary dictionaryWithObject:@"宝坻" forKey:@"city"];
    //滨海新区
    NSDictionary * binHaiXinQu = [NSDictionary dictionaryWithObject:@"滨海新区" forKey:@"city"];
    //东丽
    NSDictionary * dongLi = [NSDictionary dictionaryWithObject:@"东丽" forKey:@"city"];
    //河北
    NSDictionary * heBei = [NSDictionary dictionaryWithObject:@"河北" forKey:@"city"];

    //河东
    NSDictionary * heDong = [NSDictionary dictionaryWithObject:@"河东" forKey:@"city"];

    //和平
    NSDictionary * hePing = [NSDictionary dictionaryWithObject:@"和平" forKey:@"city"];

    //红桥
    NSDictionary * hongQiao = [NSDictionary dictionaryWithObject:@"红桥" forKey:@"city"];

    //河西
    NSDictionary * heXi = [NSDictionary dictionaryWithObject:@"河西" forKey:@"city"];

    //静海
    NSDictionary * jingHai = [NSDictionary dictionaryWithObject:@"静海" forKey:@"city"];

    //津南
    NSDictionary * jinNan = [NSDictionary dictionaryWithObject:@"津南" forKey:@"city"];

    //蓟县
    NSDictionary * jiXian = [NSDictionary dictionaryWithObject:@"蓟县" forKey:@"city"];

    //宁河
    NSDictionary * ningHe = [NSDictionary dictionaryWithObject:@"宁河" forKey:@"city"];

    //南开
    NSDictionary * nanKai = [NSDictionary dictionaryWithObject:@"南开" forKey:@"city"];

    //武清
    NSDictionary * wuQing = [NSDictionary dictionaryWithObject:@"武清" forKey:@"city"];
    
    //西青
    NSDictionary * xiQing = [NSDictionary dictionaryWithObject:@"西青" forKey:@"city"];
    
    [cityArray addObject:xiQing];
    [cityArray addObject:wuQing];
    [cityArray addObject:nanKai];
    [cityArray addObject:ningHe];
    [cityArray addObject:jiXian];
    [cityArray addObject:jinNan];
    [cityArray addObject:jingHai];
    [cityArray addObject:heXi];
    [cityArray addObject:hongQiao];
    [cityArray addObject:hePing];
    [cityArray addObject:heDong];
    [cityArray addObject:heBei];
    [cityArray addObject:dongLi];
    [cityArray addObject:binHaiXinQu];
    [cityArray addObject:baoDi];
    [cityArray addObject:beiChen];
    [tianJinDictionary setObject:@"天津" forKey:@"Province"];
    [tianJinDictionary setObject:cityArray forKey:@"cityArray"];
    return tianJinDictionary;
}

- (NSMutableDictionary *)setNeiMengGu {
    //内蒙古
    NSMutableDictionary * neiMengGuDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    //阿拉善
    NSDictionary * aLaShan = [NSDictionary dictionaryWithObject:@"阿拉善" forKey:@"city"];
    //包头
    NSDictionary * baoTou = [NSDictionary dictionaryWithObject:@"包头" forKey:@"city"];
    //巴彦淖尔
    NSDictionary * baYanNaoEr = [NSDictionary dictionaryWithObject:@"巴彦淖尔" forKey:@"city"];
    //赤峰
    NSDictionary * chiFeng = [NSDictionary dictionaryWithObject:@"赤峰" forKey:@"city"];
    //鄂尔多斯
    NSDictionary * eErDuoSi = [NSDictionary dictionaryWithObject:@"鄂尔多斯" forKey:@"city"];
    //呼和浩特
    NSDictionary * huHeHaoTe = [NSDictionary dictionaryWithObject:@"呼和浩特" forKey:@"city"];
    //呼伦贝尔
    NSDictionary * huLunBeiEr = [NSDictionary dictionaryWithObject:@"呼伦贝尔" forKey:@"city"];
    //通辽
    NSDictionary * liaoTong = [NSDictionary dictionaryWithObject:@"通辽" forKey:@"city"];
    //乌海
    NSDictionary * wuHai = [NSDictionary dictionaryWithObject:@"乌海" forKey:@"city"];
    //乌兰察布
    NSDictionary * wuLanChaBu = [NSDictionary dictionaryWithObject:@"乌兰察布" forKey:@"city"];
    //兴安
    NSDictionary * xingAn = [NSDictionary dictionaryWithObject:@"兴安" forKey:@"city"];
    //锡林郭勒
    NSDictionary * xiLinGuoLe = [NSDictionary dictionaryWithObject:@"锡林郭勒" forKey:@"city"];
    
    [cityArray addObject:xiLinGuoLe];
    [cityArray addObject:xingAn];
    [cityArray addObject:wuLanChaBu];
    [cityArray addObject:wuHai];
    [cityArray addObject:liaoTong];
    [cityArray addObject:huLunBeiEr];
    [cityArray addObject:huHeHaoTe];
    [cityArray addObject:eErDuoSi];
    [cityArray addObject:chiFeng];
    [cityArray addObject:baYanNaoEr];
    [cityArray addObject:baoTou];
    [cityArray addObject:aLaShan];
    
    [neiMengGuDictionary setObject:@"内蒙古" forKey:@"Province"];
    [neiMengGuDictionary setObject:cityArray forKey:@"cityArray"];
    return neiMengGuDictionary;
}

- (NSMutableDictionary *)setGanSu {
    //甘肃
    NSMutableDictionary * ganSuDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //白银
    NSDictionary * baiYin = [NSDictionary dictionaryWithObject:@"白银" forKey:@"city"];
    //定西
    NSDictionary * dingXi = [NSDictionary dictionaryWithObject:@"定西" forKey:@"city"];
    //甘南
    NSDictionary * ganNan = [NSDictionary dictionaryWithObject:@"甘南" forKey:@"city"];
    //金昌
    NSDictionary * jinChang = [NSDictionary dictionaryWithObject:@"金昌" forKey:@"city"];
    //酒泉
    NSDictionary * jiuQuan = [NSDictionary dictionaryWithObject:@"酒泉" forKey:@"city"];
    //嘉峪关
    NSDictionary * jiaYuGuan = [NSDictionary dictionaryWithObject:@"嘉峪关" forKey:@"city"];
    //陇南
    NSDictionary * longNan = [NSDictionary dictionaryWithObject:@"陇南" forKey:@"city"];
    //临夏
    NSDictionary * linXia = [NSDictionary dictionaryWithObject:@"临夏" forKey:@"city"];
    //兰州市
    NSDictionary * lanZhouShi = [NSDictionary dictionaryWithObject:@"兰州市" forKey:@"city"];
    //平凉
    NSDictionary * pingLiang = [NSDictionary dictionaryWithObject:@"平凉" forKey:@"city"];
    //庆阳
    NSDictionary * qingYang = [NSDictionary dictionaryWithObject:@"庆阳" forKey:@"city"];
    //天水
    NSDictionary * tianShui = [NSDictionary dictionaryWithObject:@"天水" forKey:@"city"];
    //武威
    NSDictionary * wuWei = [NSDictionary dictionaryWithObject:@"武威" forKey:@"city"];
    //张掖
    NSDictionary * zhangYe = [NSDictionary dictionaryWithObject:@"张掖" forKey:@"city"];

    [cityArray addObject:zhangYe];
    [cityArray addObject:wuWei];
    [cityArray addObject:tianShui];
    [cityArray addObject:qingYang];
    [cityArray addObject:pingLiang];
    [cityArray addObject:lanZhouShi];
    [cityArray addObject:linXia];
    [cityArray addObject:longNan];
    [cityArray addObject:jiaYuGuan];
    [cityArray addObject:jiuQuan];
    [cityArray addObject:jinChang];
    [cityArray addObject:ganNan];
    [cityArray addObject:dingXi];
    [cityArray addObject:baiYin];
    
    [ganSuDictionary setObject:@"甘肃" forKey:@"Province"];
    [ganSuDictionary setObject:cityArray forKey:@"cityArray"];
    
    return ganSuDictionary;
    
}

- (NSMutableDictionary *)setSiChuan {
    //四川
    
    NSMutableDictionary * siChuanDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //阿坝
    NSDictionary * aBa = [NSDictionary dictionaryWithObject:@"阿坝" forKey:@"city"];
    //巴中
    NSDictionary * baZhong = [NSDictionary dictionaryWithObject:@"巴中" forKey:@"city"];
    //成都
    NSDictionary * chengDu = [NSDictionary dictionaryWithObject:@"成都" forKey:@"city"];
    //德阳
    NSDictionary * deYang = [NSDictionary dictionaryWithObject:@"德阳" forKey:@"city"];
    //达州
    NSDictionary * daZhou = [NSDictionary dictionaryWithObject:@"达州" forKey:@"city"];
    //广安
    NSDictionary * guangAn = [NSDictionary dictionaryWithObject:@"广安" forKey:@"city"];
    //广元
    NSDictionary * guangYuan = [NSDictionary dictionaryWithObject:@"广元" forKey:@"city"];
    //甘孜
    NSDictionary * ganZi = [NSDictionary dictionaryWithObject:@"甘孜" forKey:@"city"];
    //乐山
    NSDictionary * leShan = [NSDictionary dictionaryWithObject:@"乐山" forKey:@"city"];
    //凉山
    NSDictionary * liangShan = [NSDictionary dictionaryWithObject:@"凉山" forKey:@"city"];
    //泸州
    NSDictionary * luZhou = [NSDictionary dictionaryWithObject:@"泸州" forKey:@"city"];
    //眉山
    NSDictionary * meiShan = [NSDictionary dictionaryWithObject:@"眉山" forKey:@"city"];
    //绵阳
    NSDictionary * mianYang = [NSDictionary dictionaryWithObject:@"绵阳" forKey:@"city"];
    //南充
    NSDictionary * nanChong = [NSDictionary dictionaryWithObject:@"南充" forKey:@"city"];
    //内江
    NSDictionary * neiJiang = [NSDictionary dictionaryWithObject:@"内江" forKey:@"city"];
    //攀枝花
    NSDictionary * panZhiHua = [NSDictionary dictionaryWithObject:@"攀枝花" forKey:@"city"];
    //遂宁
    NSDictionary * suiNing = [NSDictionary dictionaryWithObject:@"遂宁" forKey:@"city"];
    //雅安
    NSDictionary * yaAn = [NSDictionary dictionaryWithObject:@"雅安" forKey:@"city"];
    //宜宾
    NSDictionary * yiBin = [NSDictionary dictionaryWithObject:@"宜宾" forKey:@"city"];
    //自贡
    NSDictionary * ziGong = [NSDictionary dictionaryWithObject:@"自贡" forKey:@"city"];
    //资阳
    NSDictionary * ziYang = [NSDictionary dictionaryWithObject:@"资阳" forKey:@"city"];
    
    [cityArray addObject:ziYang];
    [cityArray addObject:ziGong];
    [cityArray addObject:yiBin];
    [cityArray addObject:yaAn];
    [cityArray addObject:suiNing];
    [cityArray addObject:panZhiHua];
    [cityArray addObject:neiJiang];
    [cityArray addObject:nanChong];
    [cityArray addObject:mianYang];
    [cityArray addObject:meiShan];
    [cityArray addObject:luZhou];
    [cityArray addObject:liangShan];
    [cityArray addObject:leShan];
    [cityArray addObject:ganZi];
    [cityArray addObject:guangYuan];
    [cityArray addObject:guangAn];
    [cityArray addObject:daZhou];
    [cityArray addObject:deYang];
    [cityArray addObject:chengDu];
    [cityArray addObject:baZhong];
    [cityArray addObject:aBa];
    
    [siChuanDictionary setObject:@"四川" forKey:@"Province"];
    [siChuanDictionary setObject:cityArray forKey:@"cityArray"];
    
    return siChuanDictionary;
}

- (NSMutableDictionary *)setTaiWan {
    //台湾
    
    NSMutableDictionary * taiWanDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //高雄
    NSDictionary * gaoXiong = [NSDictionary dictionaryWithObject:@"高雄" forKey:@"city"];
    //花莲县
    NSDictionary * huaLianXian = [NSDictionary dictionaryWithObject:@"花莲县" forKey:@"city"];
    //基隆市
    NSDictionary * jiLongShi = [NSDictionary dictionaryWithObject:@"基隆市" forKey:@"city"];
    //金门县
    NSDictionary * jinMenXian = [NSDictionary dictionaryWithObject:@"金门县" forKey:@"city"];
    //嘉义市
    NSDictionary * jiaYiShi = [NSDictionary dictionaryWithObject:@"嘉义市" forKey:@"city"];
    //嘉义县
    NSDictionary * jiaYiXian = [NSDictionary dictionaryWithObject:@"嘉义县" forKey:@"city"];
    //连江县
    NSDictionary * lianJiaXian = [NSDictionary dictionaryWithObject:@"连江县" forKey:@"city"];

    //苗粟县
    NSDictionary * miaoShuXian = [NSDictionary dictionaryWithObject:@"苗粟县" forKey:@"city"];

    //南投县
    NSDictionary * nanTouXian = [NSDictionary dictionaryWithObject:@"南投县" forKey:@"city"];

    //屏东县
    NSDictionary * pingDongXian = [NSDictionary dictionaryWithObject:@"屏东县" forKey:@"city"];

    //澎湖县
    NSDictionary * pengHuXian = [NSDictionary dictionaryWithObject:@"澎湖县" forKey:@"city"];

    //台北市
    NSDictionary * taiBeiShi = [NSDictionary dictionaryWithObject:@"阿坝" forKey:@"city"];

    //台东县
    NSDictionary * taiDongXian = [NSDictionary dictionaryWithObject:@"台东县" forKey:@"city"];

    //台南市
    NSDictionary * taiNanShi = [NSDictionary dictionaryWithObject:@"台南市" forKey:@"city"];

    //桃园县
    NSDictionary * taoYuanXian = [NSDictionary dictionaryWithObject:@"桃园县" forKey:@"city"];

    //台中市
    NSDictionary * taiZhongShi = [NSDictionary dictionaryWithObject:@"台中市" forKey:@"city"];

    //新北市
    NSDictionary * xinBeiShi = [NSDictionary dictionaryWithObject:@"新北市" forKey:@"city"];

    //新竹市
    NSDictionary * xinZhuShi = [NSDictionary dictionaryWithObject:@"新竹市" forKey:@"city"];

    //新竹县
    NSDictionary * xinZhuXian = [NSDictionary dictionaryWithObject:@"新竹县" forKey:@"city"];

    //云林县
    NSDictionary * yunLinXian = [NSDictionary dictionaryWithObject:@"云林县" forKey:@"city"];

    //宜兰县
    NSDictionary * yiLanXian = [NSDictionary dictionaryWithObject:@"宜兰县" forKey:@"city"];

    //彰化县
    NSDictionary * zhangHuaXian = [NSDictionary dictionaryWithObject:@"彰化县" forKey:@"city"];

    [cityArray addObject:zhangHuaXian];
    [cityArray addObject:yiLanXian];
    [cityArray addObject:yunLinXian];
    [cityArray addObject:xinZhuShi];
    [cityArray addObject:xinZhuXian];
    [cityArray addObject:xinBeiShi];
    [cityArray addObject:taiZhongShi];
    [cityArray addObject:taoYuanXian];
    [cityArray addObject:taiNanShi];
    [cityArray addObject:taiDongXian];
    [cityArray addObject:taiBeiShi];
    [cityArray addObject:pengHuXian];
    [cityArray addObject:pingDongXian];
    [cityArray addObject:nanTouXian];
    [cityArray addObject:miaoShuXian];
    [cityArray addObject:lianJiaXian];
    [cityArray addObject:jiaYiXian];
    [cityArray addObject:jiaYiShi];
    [cityArray addObject:jinMenXian];
    [cityArray addObject:jiLongShi];
    [cityArray addObject:huaLianXian];
    [cityArray addObject:gaoXiong];
    
    [taiWanDictionary setObject:@"台湾" forKey:@"Province"];
    [taiWanDictionary setObject:cityArray forKey:@"cityArray"];
    
    return taiWanDictionary;
}

- (NSMutableDictionary *)setJiLin {
    //吉林
    
    NSMutableDictionary * jiLinDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //白城
    NSDictionary * baiCheng = [NSDictionary dictionaryWithObject:@"白城" forKey:@"city"];
    
    //白山
    NSDictionary * baiShan = [NSDictionary dictionaryWithObject:@"白山" forKey:@"city"];

    //长春
    NSDictionary * changChun = [NSDictionary dictionaryWithObject:@"长春" forKey:@"city"];
    
    //吉林
    NSDictionary * jiLin = [NSDictionary dictionaryWithObject:@"吉林" forKey:@"city"];

    //辽源
    NSDictionary * liaoYuan = [NSDictionary dictionaryWithObject:@"辽源" forKey:@"city"];

    //四平
    NSDictionary * siPing = [NSDictionary dictionaryWithObject:@"四平" forKey:@"city"];

    //松原
    NSDictionary * songYuan = [NSDictionary dictionaryWithObject:@"松原" forKey:@"city"];

    //通化
    NSDictionary * tongHua = [NSDictionary dictionaryWithObject:@"通化" forKey:@"city"];

    //延边
    NSDictionary * yanBian = [NSDictionary dictionaryWithObject:@"延边" forKey:@"city"];

    [cityArray addObject:yanBian];
    [cityArray addObject:tongHua];
    [cityArray addObject:songYuan];
    [cityArray addObject:siPing];
    [cityArray addObject:liaoYuan];
    [cityArray addObject:jiLin];
    [cityArray addObject:changChun];
    [cityArray addObject:baiShan];
    [cityArray addObject:baiCheng];
    
    [jiLinDictionary setObject:@"吉林" forKey:@"Province"];
    [jiLinDictionary setObject:cityArray forKey:@"cityArray"];
    
    return jiLinDictionary;
}

- (NSMutableDictionary *)setJiangXi {
    //江西
    
    NSMutableDictionary * jiangXiDictionary = [[NSMutableDictionary alloc]init];
    
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //抚州
    NSDictionary * fuZhou = [NSDictionary dictionaryWithObject:@"抚州" forKey:@"city"];

    //赣州
    NSDictionary * ganZhou = [NSDictionary dictionaryWithObject:@"赣州" forKey:@"city"];
    
    //吉安
    NSDictionary * jiAn = [NSDictionary dictionaryWithObject:@"吉安" forKey:@"city"];
    
    //景德镇
    NSDictionary * jingDeZhen = [NSDictionary dictionaryWithObject:@"景德镇" forKey:@"city"];

    //九江
    NSDictionary * jiuJiang = [NSDictionary dictionaryWithObject:@"九江" forKey:@"city"];

    //南昌
    NSDictionary * nanChang = [NSDictionary dictionaryWithObject:@"南昌" forKey:@"city"];
    
    //萍乡
    NSDictionary * pingXiang = [NSDictionary dictionaryWithObject:@"萍乡" forKey:@"city"];

    //上饶
    NSDictionary * shangRao = [NSDictionary dictionaryWithObject:@"上饶" forKey:@"city"];

    //新余
    NSDictionary * xinYu = [NSDictionary dictionaryWithObject:@"新余" forKey:@"city"];

    //宜春
    NSDictionary * yiChun = [NSDictionary dictionaryWithObject:@"宜春" forKey:@"city"];
    
    //鹰潭
    NSDictionary * yingTan = [NSDictionary dictionaryWithObject:@"鹰潭" forKey:@"city"];

    [cityArray addObject:yingTan];
    [cityArray addObject:yiChun];
    [cityArray addObject:xinYu];
    [cityArray addObject:shangRao];
    [cityArray addObject:pingXiang];
    [cityArray addObject:nanChang];
    [cityArray addObject:jiuJiang];
    [cityArray addObject:jingDeZhen];
    [cityArray addObject:jiAn];
    [cityArray addObject:ganZhou];
    [cityArray addObject:fuZhou];
    
    [jiangXiDictionary setObject:@"江西" forKey:@"Province"];
    [jiangXiDictionary setObject:cityArray forKey:@"cityArray"];
    
    return jiangXiDictionary;
}

- (NSMutableDictionary *)setJiangSu {
    //江苏
    
    NSMutableDictionary * jiangSuDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //常州
    NSDictionary * changZhou = [NSDictionary dictionaryWithObject:@"常州" forKey:@"city"];

    //淮安
    NSDictionary * huaiAn = [NSDictionary dictionaryWithObject:@"淮安" forKey:@"city"];

    //连云港
    NSDictionary * lianYunGang = [NSDictionary dictionaryWithObject:@"连云港" forKey:@"city"];

    //南京
    NSDictionary * nanJing = [NSDictionary dictionaryWithObject:@"南京" forKey:@"city"];

    //南通
    NSDictionary * nanTong = [NSDictionary dictionaryWithObject:@"南通" forKey:@"city"];

    //宿迁
    NSDictionary * suQian = [NSDictionary dictionaryWithObject:@"宿迁" forKey:@"city"];

    //苏州
    NSDictionary * suZhou = [NSDictionary dictionaryWithObject:@"苏州" forKey:@"city"];

    //泰州
    NSDictionary * taiZhou = [NSDictionary dictionaryWithObject:@"泰州" forKey:@"city"];

    //无锡
    NSDictionary * wuXi = [NSDictionary dictionaryWithObject:@"无锡" forKey:@"city"];

    //徐州
    NSDictionary * xuZhou = [NSDictionary dictionaryWithObject:@"徐州" forKey:@"city"];

    //盐城
    NSDictionary * yanCheng = [NSDictionary dictionaryWithObject:@"盐城" forKey:@"city"];

    //扬州
    NSDictionary * yangZhou = [NSDictionary dictionaryWithObject:@"扬州" forKey:@"city"];

    //镇江
    NSDictionary * zhenJiang = [NSDictionary dictionaryWithObject:@"镇江" forKey:@"city"];

    [cityArray addObject:zhenJiang];
    [cityArray addObject:yangZhou];
    [cityArray addObject:xuZhou];
    [cityArray addObject:wuXi];
    [cityArray addObject:taiZhou];
    [cityArray addObject:suZhou];
    [cityArray addObject:suQian];
    [cityArray addObject:nanTong];
    [cityArray addObject:nanJing];
    [cityArray addObject:lianYunGang];
    [cityArray addObject:huaiAn];
    [cityArray addObject:changZhou];
    
    [jiangSuDictionary setObject:@"江苏" forKey:@"Province"];
    [jiangSuDictionary setObject:cityArray forKey:@"cityArray"];
    
    return jiangSuDictionary;
}

- (NSMutableDictionary *)setXiZang {
    //西藏
    NSMutableDictionary * tibetDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //阿里
    NSDictionary * aLi = [NSDictionary dictionaryWithObject:@"阿里" forKey:@"city"];
    
    //昌都
    NSDictionary * changDu = [NSDictionary dictionaryWithObject:@"昌都" forKey:@"city"];

    //拉萨
    NSDictionary * laSa = [NSDictionary dictionaryWithObject:@"拉萨" forKey:@"city"];

    //林芝
    NSDictionary * linZhi = [NSDictionary dictionaryWithObject:@"林芝" forKey:@"city"];

    //那曲
    NSDictionary * naQu = [NSDictionary dictionaryWithObject:@"那曲" forKey:@"city"];

    //日喀则
    NSDictionary * riKaZe = [NSDictionary dictionaryWithObject:@"日喀则" forKey:@"city"];

    //山南
    NSDictionary * shanNan = [NSDictionary dictionaryWithObject:@"山南" forKey:@"city"];

    [cityArray addObject:aLi];
    [cityArray addObject:changDu];
    [cityArray addObject:laSa];
    [cityArray addObject:linZhi];
    [cityArray addObject:naQu];
    [cityArray addObject:riKaZe];
    [cityArray addObject:shanNan];
    
    [tibetDictionary setObject:@"西藏" forKey:@"Province"];
    [tibetDictionary setObject:cityArray forKey:@"cityArray"];
    
    return tibetDictionary;
}

- (NSMutableDictionary *)setAnHui {
    //安徽
    
    NSMutableDictionary * anHuiDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //安庆
    NSDictionary * anQing = [NSDictionary dictionaryWithObject:@"安庆" forKey:@"city"];

    //蚌埠bengbu
    NSDictionary * bengBu = [NSDictionary dictionaryWithObject:@"蚌埠" forKey:@"city"];

    //亳州 bozhou
    NSDictionary * boZhou = [NSDictionary dictionaryWithObject:@"亳州" forKey:@"city"];

    //巢湖
    NSDictionary * chaoHu = [NSDictionary dictionaryWithObject:@"巢湖" forKey:@"city"];

    //滁州
    NSDictionary * chuZhou = [NSDictionary dictionaryWithObject:@"滁州" forKey:@"city"];

    //池州
    NSDictionary * chiZHou = [NSDictionary dictionaryWithObject:@"池州" forKey:@"city"];

    //阜阳 fuyang
    NSDictionary * fuYang = [NSDictionary dictionaryWithObject:@"阜阳" forKey:@"city"];

    //淮北
    NSDictionary * huaiBei = [NSDictionary dictionaryWithObject:@"淮北" forKey:@"city"];

    //合肥
    NSDictionary * heFei = [NSDictionary dictionaryWithObject:@"合肥" forKey:@"city"];

    //淮南
    NSDictionary * huaiNan = [NSDictionary dictionaryWithObject:@"淮南" forKey:@"city"];

    //黄山
    NSDictionary * huangShan = [NSDictionary dictionaryWithObject:@"黄山" forKey:@"city"];

    //六安
    NSDictionary * liuAn = [NSDictionary dictionaryWithObject:@"六安" forKey:@"city"];

    //马鞍山
    NSDictionary * maAnShan = [NSDictionary dictionaryWithObject:@"马鞍山" forKey:@"city"];

    //宿州
    NSDictionary * suZhou = [NSDictionary dictionaryWithObject:@"宿州" forKey:@"city"];

    //铜陵
    NSDictionary * tongLing = [NSDictionary dictionaryWithObject:@"铜陵" forKey:@"city"];

    //芜湖
    NSDictionary * wuHu = [NSDictionary dictionaryWithObject:@"芜湖" forKey:@"city"];

    //宣城
    NSDictionary * xuanCheng = [NSDictionary dictionaryWithObject:@"宣城" forKey:@"city"];

    [cityArray addObject:xuanCheng];
    [cityArray addObject:wuHu];
    [cityArray addObject:tongLing];
    [cityArray addObject:suZhou];
    [cityArray addObject:maAnShan];
    [cityArray addObject:liuAn];
    [cityArray addObject:huangShan];
    [cityArray addObject:huaiNan];
    [cityArray addObject:heFei];
    [cityArray addObject:huaiBei];
    [cityArray addObject:fuYang];
    [cityArray addObject:chiZHou];
    [cityArray addObject:chuZhou];
    [cityArray addObject:chaoHu];
    [cityArray addObject:boZhou];
    [cityArray addObject:bengBu];
    [cityArray addObject:anQing];
    
    [anHuiDictionary setObject:@"安徽" forKey:@"Province"];
    [anHuiDictionary setObject:cityArray forKey:@"cityArray"];
    
    return anHuiDictionary;
}

- (NSMutableDictionary *)setHeBei {
    //河北
    
    NSMutableDictionary * heBeiDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray  = [[NSMutableArray alloc]init];
    
    // 保定
    NSDictionary * baoDing = [NSDictionary dictionaryWithObject:@"保定" forKey:@"city"];

    //承德
    NSDictionary * chengDe = [NSDictionary dictionaryWithObject:@"承德" forKey:@"city"];

    //沧州
    NSDictionary * cangZhou = [NSDictionary dictionaryWithObject:@"沧州" forKey:@"city"];

    //邯郸handan
    NSDictionary * hanDan = [NSDictionary dictionaryWithObject:@"邯郸" forKey:@"city"];

    //衡水
    NSDictionary * hengShui = [NSDictionary dictionaryWithObject:@"衡水" forKey:@"city"];

    //廊坊
    NSDictionary * langFang = [NSDictionary dictionaryWithObject:@"廊坊" forKey:@"city"];

    //秦皇岛
    NSDictionary * qinHuangDao = [NSDictionary dictionaryWithObject:@"秦皇岛" forKey:@"city"];

    //石家庄
    NSDictionary * shiJiaZhuang = [NSDictionary dictionaryWithObject:@"石家庄" forKey:@"city"];

    //唐山
    NSDictionary * tangShan = [NSDictionary dictionaryWithObject:@"唐山" forKey:@"city"];

    //邢台
    NSDictionary * xingTai = [NSDictionary dictionaryWithObject:@"邢台" forKey:@"city"];

    //张家口
    NSDictionary * zhangJiaKou = [NSDictionary dictionaryWithObject:@"张家口" forKey:@"city"];

    [cityArray addObject:baoDing];
    [cityArray addObject:chengDe];
    [cityArray addObject:cangZhou];
    [cityArray addObject:hanDan];
    [cityArray addObject:hengShui];
    [cityArray addObject:langFang];
    [cityArray addObject:qinHuangDao];
    [cityArray addObject:shiJiaZhuang];
    [cityArray addObject:shiJiaZhuang];
    [cityArray addObject:tangShan];
    [cityArray addObject:xingTai];
    [cityArray addObject:zhangJiaKou];
    
    [heBeiDictionary setObject:@"河北" forKey:@"Province"];
    [heBeiDictionary setObject:cityArray forKey:@"cityArray"];
    
    return heBeiDictionary;
}

- (NSMutableDictionary *)setHeNan {
    //河南
    
    NSMutableDictionary * heNanDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * cityArray = [[NSMutableArray alloc]init];
    
    //安阳
    NSDictionary * anYang = [NSDictionary dictionaryWithObject:@"安阳" forKey:@"city"];

    //鹤壁
    NSDictionary * heBi = [NSDictionary dictionaryWithObject:@"鹤壁" forKey:@"city"];

    //济源
    NSDictionary * jiYuan = [NSDictionary dictionaryWithObject:@"济源" forKey:@"city"];

    //焦作
    NSDictionary * jiaoZuo = [NSDictionary dictionaryWithObject:@"焦作" forKey:@"city"];

    //开封
    NSDictionary * kaiFeng = [NSDictionary dictionaryWithObject:@"开封" forKey:@"city"];

    //漯河
    NSDictionary * luoHe = [NSDictionary dictionaryWithObject:@"漯河" forKey:@"city"];

    //洛阳
    NSDictionary * luoYang = [NSDictionary dictionaryWithObject:@"洛阳" forKey:@"city"];

    //南阳
    NSDictionary * nanYang = [NSDictionary dictionaryWithObject:@"南阳" forKey:@"city"];

    //平顶山
    NSDictionary * pingDingShan = [NSDictionary dictionaryWithObject:@"平顶山" forKey:@"city"];

    //濮阳
    NSDictionary * puYang = [NSDictionary dictionaryWithObject:@"濮阳" forKey:@"city"];

    //三门峡
    NSDictionary * sanMenXia = [NSDictionary dictionaryWithObject:@"三门峡" forKey:@"city"];

    //商丘
    NSDictionary * shangQiu = [NSDictionary dictionaryWithObject:@"安庆" forKey:@"city"];

    //许昌
//    NSDictionary * 
    //新乡
    //信阳
    //周口
    //驻马店
    //郑州
    
    
    return nil;
}

- (NSMutableDictionary *)setQingHai {
    //青海
    return nil;
}

- (NSMutableDictionary *)setHK {
    //香港
    return nil;
}

- (NSMutableDictionary *)setChongQing {
    //重庆
    return nil;
}

- (NSMutableDictionary *)setSHANXI {
    //陕西 大写区分山西
    
    return nil;
}

- (NSMutableDictionary *)setZheJiang {
    //浙江
    return nil;
}

- (NSMutableDictionary *)setNanHai {
    //南海
    
    return nil;
}

- (NSMutableDictionary *)setGuiZhou {
    //贵州
    return nil;
}

- (NSMutableDictionary *)setHuBei {
    //湖北
    return nil;
}

- (NSMutableDictionary *)setHuNan {
    //湖南
    
    return nil;
}

- (NSMutableDictionary *)setHeiLongJiang{
    //黑龙江
    return nil;
}

- (NSMutableDictionary *)setYunNan {
    //云南
    return nil;

}

- (NSMutableDictionary *)setFuJian {
    //福建
    return nil;
}

- (NSMutableDictionary *)setXinJiang {
    //新疆
    return nil;
}

- (NSMutableDictionary *)setGuangDong {
    //广东
    return nil;
}

- (NSMutableDictionary *)setGuangXi {
    //广西
    return nil;
}

- (NSMutableDictionary *)setNingXia {
    //宁夏
    return nil;
}

- (NSMutableDictionary *)setLiaoNing {
    //辽宁
    return nil;
}

- (NSMutableDictionary *)setMacao {
    //澳门
    return nil;
}

@end

