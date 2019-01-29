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
#define HOSTURL   @"http://202.106.10.250:48088"
//正式
//#define HOSTURL   @"http://guoxin.sic-credit.com:8089"
#define HTMLHOST @"http://202.106.10.250:4808"
//#define HTMLHOST @"http://guoxin.sic-credit.com:9090"

//H5 交互规则
#define Md5Encryption  @"md5encryption://parameter"


//企信宝接口
#define QXBHOSTURL @"http://api.jusfoun.com/api_qixinbao"

//首页
#define KGetHomeData   @""HOSTURL"/app/Home/GetHomeData"


// 插入关键词接口
#define  KInsertKey @""HOSTURL"/app/sys/insertSearchWord"

//  热门搜索关键词查询接口
#define  KHotSearchWord @""HOSTURL"/app/sys/hotSearchWord"

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

//  查询企业认证、VIP状态接口
#define  KGetIdentVip @""HOSTURL"/app/Company/getIdentVip"


//获取热词
#define KGetHotKey  @""HOSTURL"/app/sys/hotSearchWord"

//插入热词
#define KInsertHotKey  @""HOSTURL"/app/sys/insertSearchWord"


// 访客
#define  KVisitorRecord @""HOSTURL"/app/CreditService/visitorRecord"

// 浏览记录
#define  KBrowseList @""HOSTURL"/app/mineManager/BrowseHistoryList"

// 浏览记录
#define  KDelBrowseList @""HOSTURL"/app/mineManager/delBrowseHistory"

// 上传图片接口
#define  KFileUpload @""HOSTURL"/app/sys/fileupload"

// 查询价格
#define  KGetOrderMsg @""HOSTURL"/app/order/getOrderMsg"

// 支付
#define  KOrderPay @""HOSTURL"/app/order/orderPay"


//登录
#define KLogin   @""HOSTURL"/app/UserLogin/loginApp"

//退出登录
#define KLoginoutMethod @""HOSTURL"/app/UserLogin/ExitApp"

//注册
#define KRegister   @""HOSTURL"/app/UserLogin/RegisterApp"

//忘记密码
#define KForgetPassword   @""HOSTURL"/app/UserLogin/forgetPassword"

//发送验证码
#define KSendMesCode   @""HOSTURL"/app/UserLogin/sendMesCode"

//监控动态
#define KGetMonitorDynamic @""HOSTURL"/app/MonitoringDynamics/GetmonitoringDynamics"

//监控动态详情
#define KDynamicDetail @""HOSTURL"/app/MonitoringDynamics/DynamicDetails"

//监控动态筛选条件
#define KDynamicFilter @""HOSTURL"/app/MonitoringDynamics/GetFilterCondition"

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

//自主填报-企业信息
#define KGetCompanyInfo @""HOSTURL"/app/Company/getCompanyInfo"

//自主填报-企业信息编辑
#define KEditCompanyInfo @""HOSTURL"/app/Company/CompanyInfoEditor"

//自主填报-企业产品
#define KGetCompanyProduct @""HOSTURL"/app/Company/getProductList"

//自主填报-企业产品编辑
#define KEditCompanyProduct @""HOSTURL"/app/Company/productEditor"

//自主填报-企业荣誉
#define KGetCompanyHonor @""HOSTURL"/app/Company/getHonorList"

//自主填报-企业荣誉编辑
#define KEditCompanyHonor @""HOSTURL"/app/Company/honorEditor"

//自主填报-合作伙伴
#define KGetCompanyPartner @""HOSTURL"/app/Company/getpartnerList"

//自主填报-合作伙伴编辑
#define KEditCompanyPartner @""HOSTURL"/app/Company/partnerEditor"

//自主填报-企业成员
#define KGetCompanyMember @""HOSTURL"/app/Company/getEmployerList"

//自主填报-企业成员编辑
#define KEditCompanyMember @""HOSTURL"/app/Company/CompanyEmpEditor"

//信用服务-首页
#define KGetCreditHomeInfo @""HOSTURL"/app/CreditService/GetHomeInfo"

//信用报告
#define KGetCreditReportList @""HOSTURL"/app/CorporateInfo/CreditReport"

//发送报告
#define KSendCreditReport   @""HOSTURL"/app/CorporateInfo/createCreditWord"


//信用承诺上传
#define KUploadPromise     @""HOSTURL"/app/CreditService/uploadLetter"

//信用承诺模版
#define KGetPromiseSample  @""HOSTURL"/app/CreditService/getTemplateByEmail"

//获取信用异议
#define KGetObjectionInfo  @""HOSTURL"/app/errorTypeService/getErrorTypeList"

//提交异议纠错
#define KCommitObjectionError @""HOSTURL"/app/CorporateInfo/ObjectionError"

//提交信用异议
#define KCommitObjectionCredit @""HOSTURL"/app/CreditService/creditError"


//用户协议
#define KUserProtocol @""HTMLHOST"/creditReport/useragreement.html"

//隐私政策
#define KPrivacy @""HTMLHOST"/creditReport/privacyprotectionagreement.html"

//使用帮助
#define KUseHelp @""HTMLHOST"/dist/#/check/help"

//关于我们
#define KAboutUS @""HTMLHOST"/dist/#/about"

#define KGETH5URL @""HOSTURL"/app/Home/GetH5Address"


////////////////////////////////////////////////////////

//企业详情
#define GetCompanyDetail  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetCompanyDetails_beta"]
//企业图谱
#define GetEntAtlasData  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/EntAll/GetEntAtlasData"]
//    企业图谱查询企业或股东信息
#define GetEntAtlasEntDetail  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/EntAll/GetEntAtlasEntDetail"]


//对外投资和分支机构
#define GetEntBranchOrInvesment  [NSString stringWithFormat:@"%@%@",QXBHOSTURL,@"/api/entdetail/GetEntBranchOrInvesment"]




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
