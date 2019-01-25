//
//  Constants.h
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//




#ifndef Constants_h
#define Constants_h

// navigaitonBar标题大小
#define KNavigationTitleFontSize  18

//navigaitonBar背景颜色
#define KNavigationBarBackGroundColor [UIColor whiteColor]

//首页的导航杭栏背景颜色
#define KHomeNavigationBarBackGroundColor  [UIColor whiteColor]

//大号字体
#define KLargeFont [UIFont systemFontOfSize:18]

//普通字体
#define KNormalFont [UIFont systemFontOfSize:16]

//小字体
#define KSmallFont [UIFont systemFontOfSize:14]

//特小字体
#define KMinFont [UIFont systemFontOfSize:12]

//普通颜色
#define KNormalTextColor KHexRGB(0x333333)

//副标题颜色
#define KSubtitleTextColor KHexRGB(0x666666)

//
#define KlightGrayColor KHexRGB(0x999999)

#define KMinGrayColor KHexRGB(0xcccccc)

//分割线颜色
#define KSeparatorColor KHexRGB(0xe9e9e9)

#define KNavigationBarRedColor  KRGB(226, 47, 48)

#define HomeBannerHeight (92+KNavigationBarHeight) //banner图高度
#define HomeHeadHeight KDeviceW*361/375.f       //新首页头高度

#define KInClolor   KRGB(254, 115, 37)
#define KOutClolor  KHexRGB(0x1e9efb)
//企业详情一个格子的宽度
#define KDetailGridWidth KDeviceW/4.0
#define KReportExportNum 100

/*
 ================================== 通知 =====================
 */

//定位
#define  KUserLocation @"UserLocation"
//登录成功
#define KLoginSuccess   @"loginSuccess"
//推送 id
#define KPushID    @"push_id"
//退出登录
#define KLoginOut   @"loginOut"

//Token 失效
#define KTokenInvalid   @"KTokenInvalid"

//支付成功
#define KPaySuccess  @"KPaySuccess"

//关注数量变化
#define  KFocuNumChange  @"KFocuNumChange"
//搜索
#define KSearchPlaceholder @"请输入企业名称、人名、品牌等关键字"
//推送消息
#define KPushMessageSuccessNoti @"PushMessageSuccessNoti"

//添加根据记录
#define KAddFollowUpRecordNoti @"KAddFollowUpRecordNoti"

//选取地址
#define KSelectAddressNoti @"KSelectAddressNoti"

//用户信息修改成功
#define KModifyUserInfoSuccessNoti @"KModifyUserInfoSuccessNoti"
//时间纠偏
#define KQXBCurrentTimeToServerOffset @"QXBCurrentTimeToServerOffset"

//时间纠偏
#define KCurrentTimeToServerOffset @"CurrentTimeToServerOffset"

//点击搜索结果
#define KSelectSearchResultNoti @"KSelectSearchResultNoti"

//企业认证
#define KCertificationNoti @"KCertificationNoti"

//推送消息
typedef NS_ENUM(NSInteger, PushMessageType) {
    PushMessageAloneType = 0, //单个公司
    PushMessagemoreType   =   1,//多个公司
};

//大头针列表类型
typedef enum : NSUInteger {
    AnnotationListTypeMap,
    AnnotationListTypeSearch,
} AnnotationListType;

////搜索类型
//typedef enum : NSUInteger {
//    SearchTypeName,
//    SearchTypeAddress,
//} SearchType;

// 1.web页面  2.企业图谱 3.对外投资 4.分支机构 5.带tab 切换 web页面（比如 风险信息- 法院信息 页） 6.中标 7.招聘 8.无形资产-专利 9. 无形资产-商标 10.税务 欠税公告 11.行政处罚 12.股权出质 13.招标
#define KCompanyDetailGridType @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"]

#define KUserLocationKey @"userLocation"
//搜索的类型
typedef NS_ENUM(NSInteger, SearchType) {
    SearchWebType = -1, //H5页面
    SearchBlurryType = 0, //模糊查询
    SearchShareholderType  =   1,//股东高管查询
    SearchOurmainType   =   2,//主营产品查询
    SearchCrackcreditType = 3,// 失信查询
    SearchTaxCodeType = 4,//查税号
    SearchJobType = 5,//招聘
    SearchAddressBookType = 6,//企业通讯录
    SearchSeekRelationType = 7, //查关系
    SearchRiskAnalyzeType = 8,//风险分析
    SearchAddressType = 11, //地址电话查询
    SearchPromisenType = 12, //信用承诺，
    SearchVisitorType = 13, //访客，
    SearchsubmitType = 14, //自主填报，
    SearchBidType = 15, //中标信息
    SearchJudgementType = 16, //裁判文书
    SearchPenaltyType = 17, //行政处罚
    SearchBrandType = 18, //商标查询
};

//自主信息填报类型
typedef enum : NSUInteger {
    EditTypeInfo,//企业信息
    EditTypeProduct,//产品信息
    EditTypeHonor,//荣誉信息
    EditTypePartner,//合作伙伴信息
    EditTypeMember,//成员信息
} CreditEditType;

//push进入购买vip页的控制器
typedef enum : NSUInteger {
    BuyVipFromMine,//我的
    BuyVipFromReportList,//信用报告列表
} BuyVipFromType;

typedef enum : NSUInteger {
    ListTypeMyMonitor = 0,//我的监听列表
    ListTypeMyCollection,//我的收藏
} ListType;

typedef enum : NSUInteger {
    ObjectionTypeError,//异议纠错
    ObjectionTypeCredit,//信用异议
} ObjectionType;

//AppScheme
#define KAppScheme @"CreditInquiry"

//////百度地图  com.jusfoun.EnterpriseInquiry1
#define BaiDu_Appkey      @"ZDGjTGHV0mmAi1jxZCWBBmRHGnvuxnz9"

//apple id
#define KAppleID  @"1450104309"//1055909468

#endif /* Constants_h */
