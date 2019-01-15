//
//  URLManager.h
//  框架
//
//  Created by WangZhipeng on 16/5/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#ifndef URLManager_h
#define URLManager_h

//线下
#define HOSTURL   @"http://39.106.181.46:9080"
// http://39.106.181.46:9080/swagger-ui.html
//H5 交互规则
#define Md5Encryption  @"md5encryption://parameter"

//线上
//#define HOSTURL @"http://api.jusfoun.com/api_qixinbao"

//企信宝接口
#define QXBHOSTURL @"http://api.jusfoun.com/api_qixinbao"

//首页
#define KGetHomeData   @""HOSTURL"/app/Home/GetHomeData"


//行业资讯
#define KIndustryInformation   @""HOSTURL"/app/Home/IndustryInformation"

//企业风险分析
#define KeEnterpriseRiskAnalysis   @""HOSTURL"/app/Home/EnterpriseRiskAnalysis"

//企业信息
#define KGetCorporateInfo   @""HOSTURL"/app/CorporateInfo/GetCorporateInfo"

//   企业收藏/取消收藏
#define  KCollection @""HOSTURL"/app/mineManager/AddOrCancelCollection"

//  企业添加/取消监控
#define  KMonitor @""HOSTURL"/app/MonitoringDynamics/AddOrCancelMonitor"


// 上传图片接口
#define  KFileUpload @""HOSTURL"/app/sys/fileupload"



//登录
#define KLogin   @""HOSTURL"/app/UserLogin/loginApp"

//注册
#define KRegister   @""HOSTURL"/app/UserLogin/RegisterApp"

//发送验证码
#define KSendMesCode   @""HOSTURL"/app/UserLogin/sendMesCode"

//监控动态
#define KGetMonitorDynamic @""HOSTURL"/app/MonitoringDynamics/GetmonitoringDynamics"


//企业认证信息接口
#define KCertification @""HOSTURL"/app/Company/subCompanyMsg"

//  查询企业认证信息接口
#define KGetCertification @""HOSTURL"/app/Company/getCompanyMsg"

//上传图片
#define KUploadImage @""HOSTURL"/app/sys/fileupload"

//修改手机号
#define KChangePhone @""HOSTURL"/app/mineManager/upTelphone"

//修改个人信息
#define KChangeUserInfo @""HOSTURL"/app/mineManager/upUserInfo"


//我的订单
#define KMyOrderList @""HOSTURL"/app/mineManager/OrderList"

//我的监控列表
#define KMyMonitorList @""HOSTURL"/app/mineManager/monitorList"

//我的收藏列表
#define KMyCollectionList @""HOSTURL"/app/mineManager/CollectionList"











////////////////////////////////////////////////////////

//企业详情
#define GetCompanyDetail  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetCompanyDetails_beta"]
//企业图谱
#define GetEntAtlasData  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/EntAll/GetEntAtlasData"]
//    企业图谱查询企业或股东信息
#define GetEntAtlasEntDetail  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/EntAll/GetEntAtlasEntDetail"]


//对外投资和分支机构
#define GetEntBranchOrInvesment  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetEntBranchOrInvesment"]



//获取热词
#define GetHotKey  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/Tools/GetHotSearchWord"]

//搜索

#define GetSear  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/Search/GetSear"]


//热词搜索接口
#define GetHotSearch  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/Tools/GetHotSearch"]

//失信热词搜索接口
#define SXGetHotSearch  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/Tools/SXGetHotSearch"]


//更新企业信息
#define RefreshEntInfo  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/EntAll/RefreshEntInfo"]

//获取企业信息更新状态
#define GetRefreshEntInfo [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/EntAll/GetRefreshEntInfo"]


//获取筛选条件
#define GetKeyWordSummary  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/Api/FirstPage/GetKeyWordSummary"]

//获取失信的筛选条件
#define PriviceListDeal  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/Tools/PriviceListDeal"]

//失信查询
#define BlackListSearch  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/BlackListNew/BlackListSearch"]

//九宫格-风险信息
#define KRiskMessage [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetRiskInformation_beta"]

//九宫格-经营状况
#define KBusinessInfo [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetBusinessInformation_beta"]

//九宫格-无形资产
#define KIntangible [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetIntangibleAssets_beta"]

//招投标
#define KGetBid [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetBidWinningNoticeInfo"]

//招投标详情
//#define KBidDetail  @""KH5URL"bidInformation.html"

//无形资产-商标
#define KTrademarkList [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetCompIcon"]

//招聘
#define KGetJob [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetCompInJobPage"]

//招聘详情
//#define KJobDetail  @""KH5URL"recruitInformation.html"

//专利
#define KGetPatent [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetCompPatent"]


//行政处罚
#define KGetPenalty [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetEntXZPunishmentInfoModel"]

//股权出质
#define KGetGuQuan [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetEstateMortgageByEntName"]

// 经营状况–招标
#define KGetZhaoBiao [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetTenderNoticeRawByProcurementCompany"]

//查税号
#define KGetSearByRegCode [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/search/GetSearByRegCode"]

//招聘搜索
#define KGetCompInJobPage [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetCompInJobPageAll"]

//企业通讯录搜索
#define KSearchEntContact [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/Contacts/get"]

//获取纠错问题列表
#define KGetQuestionList [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetQuestionResult"]

//提交纠错问题列表
#define KCommitQuestion [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/PostQuestionResult"]

//纠错
#define KErrorCorrection [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/Api/ErrorBack/InsertErrorBack"]

//欠税公告
#define KGetEntOwingTaxList [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetEntOwingTaxAnnouncement"]

//全网查找
#define FullWebSearch @"/Html/AIC_search.html"


#endif /* URLManager_h */
