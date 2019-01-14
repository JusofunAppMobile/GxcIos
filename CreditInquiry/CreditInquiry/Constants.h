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
//定位
#define  KUserLocation @"UserLocation"
//登录成功
#define KLoginSuccess   @"loginSuccess"
//推送 id
#define KPushID    @"push_id"
//退出登录
#define KLoginOut   @"loginOut"
#define  LOGIN_SUCCESS_NOTIFICATION @"LOGIN_SUCCESS_NOTIFICATION"
//第三方登录成功通知
#define  OTHER_LOGIN_SUCCESS_NOTIFICATION @"OTHER_LOGIN_SUCCESS_NOTIFICATION"
#define  UserinfoChangedNotification @"UserinfoChangedNotification"
#define KFocuNumChange  @"FocuNumChange"
//搜索
#define KSearchPlaceholder @"请输入企业名称、人名、品牌等关键字"
//推送消息
#define KPushMessageSuccessNoti @"PushMessageSuccessNoti"

//添加根据记录
#define KAddFollowUpRecordNoti @"KAddFollowUpRecordNoti"

//选取地址
#define KSelectAddressNoti @"KSelectAddressNoti"

//////百度地图  com.jusfoun.EnterpriseInquiry1
#define BaiDu_Appkey      @"ZDGjTGHV0mmAi1jxZCWBBmRHGnvuxnz9"


#define FOLLOWSTATES      @[@"已电话沟通",@"拜访中",@"已拜访",@"合作建立",@"正式合作"]

//地图列表事件通知
#define KANNOLISTCELLACTIONNOTI @"AnnoListCellActionNoti"
#define KANNOLISTCELLACTIONNOTIForSearch @"AnnoListCellActionNotiForSearch"

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
    BlurryType = 0, //模糊查询
    OurmainType   =   1,//主营产品查询
    ShareholderType  =   2,//股东高管查询
    AddressType = 3, //地址电话查询
    CompanyWebType = 4 ,// 企业网址查询
    CrackcreditType = 5,// 失信查询
    TaxCodeType = 6,//查税号
    JobType = 7,//招聘
    AddressBookType = 8,//企业通讯录
    PenetrationType = 9,//股东穿透
    RiskAnalyze,//d风险分析
    SeekRelation //查关系
};

//自主信息填报类型
typedef enum : NSUInteger {
    EditTypeInfo,//企业信息
    EditTypeProduct,//产品信息
    EditTypeHonor,//荣誉信息
    EditTypePartner,//合作伙伴信息
    EditTypeMember,//成员信息
} CreditEditType;


#endif /* Constants_h */
