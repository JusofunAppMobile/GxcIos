//
//  CompanyDetailController.m
//  EnterpriseInquiry
//
//  Created by WangZhipeng on 16/8/10.
//  Copyright © 2016年 王志朋. All rights reserved.
//

#import "CompanyDetailController.h"
#import "SearchResultController.h"
#import "RiskContainerController.h"
#import "AssetsContainerController.h"
#import "ReportTypeModel.h"

@interface CompanyDetailController()
{
    
    CompanyDetailModel * detailModel;
    NSMutableArray  *itemList;//菜单列表
    DetailView *detailView;
    UIButton *focuButton;
    
    UIButton *errorBtn;
    
    UIButton *shareBarButton;
    
    NSMutableArray *riskItemList;//风险信息
    
    NSMutableArray *manageItemList;//经营状况
    
    NSMutableArray *assetItemList;//无形资产
    
    NSTimer *refreshTimer;
    
    int refreshNum;
    NSMutableArray *taskArray;
    
    NSMutableArray *holderArray;//股东
    NSMutableArray *ggArray;//高管
    
    NSString *detailUrlStr;
    
}
@property (nonatomic ,strong) NSArray *reportTypeList;
@end

@implementation CompanyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.automaticallyAdjustsScrollViewInsets = NO;
    taskArray = [NSMutableArray arrayWithCapacity:1];
    self.view.backgroundColor = KNavigationBarRedColor;
    
    [self drawView];
    [self setBackBtn:@"whiteBack"];
    [self setRightBarBtn];
    [self loadCompanyInfo];
    [self loadHoldeInfo];
}




#pragma mark - 请求企业信息
-(void)loadCompanyInfo
{
    
    if(!self.companyId)
    {
        self.companyId = @"";
    }
    if(!self.companyName)
    {
        self.companyName = @"";
    }
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:self.companyId forKey:@"companyid"];
    [paraDic setObject:self.companyName forKey:@"companyname"];
    [paraDic setObject:KUSER.userId forKey:@"userid"];
    [paraDic setObject:self.companyName forKey:@"entname"];
    NSString* urlstr = [GetCompanyDetail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    KWeakSelf
    [self showLoadDataAnimation];
    
    NSURLSessionDataTask*task = [RequestManager QXBGetWithURLString:urlstr parameters:paraDic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [weakSelf hideLoadDataAnimation];
        
        _reportTypeList = [ReportTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"reportTypeList"]];//test

        
        
        NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        
        NSArray *tmpArray = [responseObject objectForKey:@"subclassMenu"];
        NSMutableArray *saveArray = [NSMutableArray arrayWithCapacity:1];
        
        for(NSDictionary *dic in tmpArray)
        {
            int type = [[dic objectForKey:@"type"] intValue];
            for(NSString *detailType in KCompanyDetailGridType)
            {
                if(type == [detailType intValue])
                {
                    [saveArray addObject:dic];
                    break;
                }
            }
        }
        [tmpDic setObject:saveArray forKey:@"subclassMenu"];
        
        
        detailModel = [CompanyDetailModel mj_objectWithKeyValues:tmpDic];
        
        
        if([detailModel.result intValue] == 0)
        {
            [weakSelf reloadOhterHeadWithtype:HeaderRiskType hud:NO];
            [weakSelf reloadOhterHeadWithtype:HeaderManageType hud:NO];
            [weakSelf reloadOhterHeadWithtype:HeaderMoneyType hud:NO];
            if([detailModel.hasCompanyData intValue] == 1)//没有数据
            {
                SearchResultController *SearchVc = [[SearchResultController alloc]init];
                SearchVc.btnTitile = self.companyName;
                SearchVc.searchType = SearchBlurryType;
                SearchVc.isFromNoData = YES;
                //SearchVc.delegate = self;
                [self.navigationController pushViewController:SearchVc animated:YES];
            }
            else//正常
            {
                focuButton.hidden = NO;
                shareBarButton.hidden = NO;
                itemList = [NSMutableArray arrayWithArray:detailModel.subclassMenu];
                //[infoView reloadInfoView:detailModel];
                // [self reloadCompanyView];
                detailView.detailModel = detailModel;
                if([detailModel.isattention isEqualToString:@"false"]||[detailModel.isattention isEqualToString:@"-"] ||[detailModel.isattention isEqualToString:@""] )
                {
                    [self setFoucsBtn:NO];
                }
                else
                {
                    [self setFoucsBtn:YES];
                }
                
            }
            
        }
        else
        {
            focuButton.hidden = YES;
            shareBarButton.hidden = YES;
            [self showNetFailViewWithFrame:self.view.bounds];
            [self setBackBtn:@""];
        }
        
    } failure:^(NSError *error) {
        focuButton.hidden = YES;
        shareBarButton.hidden = YES;
        [self showNetFailViewWithFrame:self.view.bounds];
        [self setBackBtn:@""];
    }];
    
  
    [taskArray addObject:task];
}
#pragma mark - 股东信息等
-(void)loadHoldeInfo
{
   
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:self.companyId forKey:@"companyId"];
    [paraDic setObject:self.companyName forKey:@"companyName"];
    [paraDic setObject:KUSER.userId forKey:@"userId"];
    NSString* urlstr = [KGetCorporateInfo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask*task = [RequestManager postWithURLString:urlstr parameters:paraDic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
       
        if ([responseObject[@"result"] integerValue] == 0)
        {
            NSDictionary *dic = [[responseObject objectForKey:@"data"] objectForKey:@"companyInfo"];
            if([[dic objectForKey:@"isCollect"] intValue] == 0)
            {
                [self setFoucsBtn:NO];
            }
            else
            {
                [self setFoucsBtn:YES];
            }
            detailUrlStr = [dic objectForKey:@"InfoH5Address"];
            if([[dic objectForKey:@"monitorType"] intValue] == 0)
            {
                [self setMonitorBtn:NO];
            }
            else
            {
                [self setMonitorBtn:YES];
            }
            
            holderArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"shareholder"]];
            ggArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"mainStaff"]];
            
            [detailView reloadViewWithType:HeaderHodelType gridArray:holderArray animate:NO];
            [detailView reloadViewWithType:HeaderGGType gridArray:ggArray animate:NO];
            
            
        }
        else
        {
             [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
       [MBProgressHUD showHint:@"请求失败" toView:self.view];
    }];
    
    
    [taskArray addObject:task];
}



#pragma mark - 请求风险信息/经营状态/无形资产
-(void)reloadOhterHeadWithtype:(Headerype)type hud:(BOOL)isHud
{
    NSString *urlStr = @"";
    
    if(type == HeaderRiskType)//风险信息
    {
        urlStr = KRiskMessage;
    }
    else if (type == HeaderManageType)//经营状况
    {
        urlStr = KBusinessInfo;
    }
    else ////无形资产
    {
        urlStr = KIntangible;
    }
    
    if(isHud)
    {
        [MBProgressHUD showMessag:@"" toView:self.view];
    }
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:self.companyId forKey:@"companyid"];
    [paraDic setObject:self.companyName forKey:@"companyname"];
    [paraDic setObject:KUSER.userId forKey:@"userid"];
    [paraDic setObject:self.companyName forKey:@"entname"];
    NSString* url = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask*task = [RequestManager QXBGetWithURLString:url parameters:paraDic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            
            NSArray *tmpArray = [responseObject objectForKey:@"subclassMenu"];
            NSMutableArray *saveArray = [NSMutableArray arrayWithCapacity:1];
            
            for(NSDictionary *dic in tmpArray)
            {
                int type = [[dic objectForKey:@"type"] intValue];
                for(NSString *detailType in KCompanyDetailGridType)
                {
                    if(type == [detailType intValue])
                    {
                        [saveArray addObject:dic];
                        break;
                    }
                }
            }
            [tmpDic setObject:saveArray forKey:@"subclassMenu"];
            
            
            if(type == HeaderRiskType)//风险信息
            {
                riskItemList = [NSMutableArray arrayWithArray: [tmpDic objectForKey:@"subclassMenu"]];
            }
            else if (type == HeaderManageType)//经营状况
            {
                manageItemList = [NSMutableArray arrayWithArray:[tmpDic objectForKey:@"subclassMenu"]];
            }
            else ////无形资产
            {
                assetItemList = [NSMutableArray arrayWithArray:[tmpDic objectForKey:@"subclassMenu"]];
            }
            
            [detailView reloadViewWithType:type gridArray:[tmpDic objectForKey:@"subclassMenu"] animate:isHud];
        }
        else
        {
            [MBProgressHUD showError:detailModel.msg toView:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
        [MBProgressHUD showError:@"请求失败,请稍后重试" toView:self.view];
    }];
    
    
    [taskArray addObject:task];
}


-(void)headerClick:(Headerype)type
{
    [self reloadOhterHeadWithtype:type hud:YES];
}

#pragma mark - 关注公司
-(void)focuCompany:(UIButton*)sender
{
   //（0：取消收藏  1：添加收藏）
    NSString * type = @"1";
    KBolckSelf;
    if(sender.tag == 45678)//关注这家企业
    {
        
        if(KUSER.userId.length>0)
        {
            type = @"1";
        }
        else
        {
            
            LoginController *view = [[LoginController alloc]init];
            view.loginSuccessBlock = ^{
                [blockSelf focuCompany:focuButton];
            };
            [self.navigationController pushViewController:view animated:YES];
            
            return;
        }
    }
    else //取消关注企业
    {
        if (KUSER.userId.length>0) {
            type = @"0";
        }else
        {
            LoginController *view = [[LoginController alloc]init];
            view.loginSuccessBlock = ^{
                [blockSelf focuCompany:focuButton];
            };
            [self.navigationController pushViewController:view animated:YES];
            return;
        }
        
    }
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:detailModel.companyid forKey:@"companyid"];
    [paraDic setObject:type forKey:@"monitorType"];
    [paraDic setObject:KUSER.userId forKey:@"userId"];
    [paraDic setObject:self.companyName forKey:@"companyname"];
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSString* urlstr = [KCollection stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask*task = [RequestManager postWithURLString:urlstr parameters:paraDic success:^(id responseObject) {
        
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            if(sender.tag == 45678)
            {
                [MBProgressHUD showSuccess:@"关注成功" toView:self.view];
            }
            else
            {
                [MBProgressHUD showSuccess:@"取消关注成功" toView:self.view];
            }
            
            
            if(sender.tag == 45678)
            {
                [self setFoucsBtn:YES];
                //关注成功
                [[NSNotificationCenter defaultCenter]postNotificationName:KFocuNumChange object:@"1"];
            }
            else
            {
                [self setFoucsBtn:NO];
                //取消关注
                [[NSNotificationCenter defaultCenter]postNotificationName:KFocuNumChange object:@"0"];
            }
            
            detailModel.attentioncount = [responseObject objectForKey:@"attentioncount"];
            detailView.detailModel = detailModel;
            
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
            
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
        
    }];
     [taskArray addObject:task];
}


#pragma mark - 监控公司
-(void)monitorCompany:(UIButton*)sender
{
    //（0:取消监控  1：添加监控）
    NSString * type = @"1";
    KBolckSelf;
    if([sender.titleLabel.text isEqualToString:@"监控"])//关注这家企业
    {
        
        if(KUSER.userId.length>0)
        {
            type = @"1";
        }
        else
        {
            
            LoginController *view = [[LoginController alloc]init];
            view.loginSuccessBlock = ^{
                [blockSelf focuCompany:focuButton];
            };
            [self.navigationController pushViewController:view animated:YES];
            
            return;
        }
    }
    else //取消关注企业
    {
        if (KUSER.userId.length>0) {
            type = @"0";
        }else
        {
            LoginController *view = [[LoginController alloc]init];
            view.loginSuccessBlock = ^{
                [blockSelf focuCompany:focuButton];
            };
            [self.navigationController pushViewController:view animated:YES];
            return;
        }
        
    }
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:detailModel.companyid forKey:@"companyid"];
    [paraDic setObject:type forKey:@"monitorType"];
    [paraDic setObject:KUSER.userId forKey:@"userId"];
    [paraDic setObject:self.companyName forKey:@"companyname"];
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSString* urlstr = [KMonitor stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask*task = [RequestManager postWithURLString:urlstr parameters:paraDic success:^(id responseObject) {
        
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            if([sender.titleLabel.text isEqualToString:@"监控"])
            {
                [MBProgressHUD showSuccess:@"添加监控成功" toView:self.view];
                [self setMonitorBtn:YES];
            }
            else
            {
                [MBProgressHUD showSuccess:@"取消监控成功" toView:self.view];
                [self setMonitorBtn:NO];
            }
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
            
        }
        [sender setImagePosition:LXMImagePositionTop spacing:5];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
        
    }];
    [taskArray addObject:task];
}


#pragma mark -  查询企业认证
-(void)checkAuthStatus
{
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:KUSER.userId forKey:@"userId"];
    NSURLSessionDataTask*task = [RequestManager postWithURLString:KGetIdentVip parameters:paraDic success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
           // 0：未认证  1：审核中 2：审核失败 3：审核成功
            int status = [[dic objectForKey:@"authStatus"] intValue];
            if(status == 0||status == 2)
            {
                ComCertificationController *vc = [[ComCertificationController alloc]init];
                vc.companyName = self.companyName;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                NSString *companyName = [dic objectForKey:@"authCompany"];
                if([companyName isEqualToString:self.companyName])
                {
                    ComCertificationController *vc = [[ComCertificationController alloc]init];
                    vc.isShow = YES;
                    vc.status = [dic objectForKey:@"authStatus"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    if(status == 1)
                    {
                        [MBProgressHUD showHint:@"您的认证正在审核中" toView:self.view];
                    }
                    else if(status == 3)
                    {
                        [MBProgressHUD showHint:@"您已有认证企业" toView:self.view];
                    }
                }
            }
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
        
    }];
    [taskArray addObject:task];
}


-(void)abnormalViewReload
{
    [self setBackBtn:@"whiteBack"];
    [self loadCompanyInfo];
}

#pragma mark- 纠错
-(void)errorCorrection
{
    RecoveryErrorViewController *recoveryErrorView = [[RecoveryErrorViewController alloc] init];
    recoveryErrorView.squearList =  itemList;
    recoveryErrorView.companyId = detailModel.companyid;
    recoveryErrorView.companyName = self.companyName;
    [self.navigationController pushViewController:recoveryErrorView animated:YES];
}

#pragma mark - 分享
-(void)share
{
    //[MobClick event:@"Detail58"];//企业详情页－分享按钮点击数
    //[[BaiduMobStat defaultStat] logEvent:@"Detail58" eventLabel:@"企业详情页－分享按钮点击数"];
//
//    ShareView *view = [[ShareView alloc]init];
//    view.descStr = [NSString stringWithFormat:@"查询公司：%@",detailModel.companyname];
//    view.detailUrlStr = detailModel.shareurl;
//    [[UIApplication sharedApplication ].keyWindow addSubview:view];
}


#pragma mark - 更新企业信息
-(void)updataCompanyInfo
{
    //[MobClick event:@"Detail59"];//企业详情页－刷新按钮点击数
    //[[BaiduMobStat defaultStat] logEvent:@"Detail59" eventLabel:@"企业详情页－刷新按钮点击数"];

    [MBProgressHUD showMessag:@"" toView:self.view];
    NSString *str = [NSString stringWithFormat:@"%@?entid=%@&userId=%@&entname=%@",RefreshEntInfo,detailModel.companyid,KUSER.userId,self.companyName];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [detailView beginRefreshAnimation];

    KWeakSelf
//    refreshNum = 1;
//    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopRefreshAnimation) userInfo:nil repeats:YES];
   NSURLSessionDataTask*task =  [RequestManager QXBGetWithURLString:str parameters:nil success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"]intValue] == 0)
        {
//            [MBProgressHUD showHint:@"已通知相关人员更新" toView:self.view];
//            detailModel.isupdate = @"2";
//            detailModel.updatestate = @"更新：今天";
//            detailView.detailModel = detailModel;
//            if(refreshNum < 5)
//            {
//                [detailView beginRefreshAnimation];
//            }
//            else
//            {
//                [detailView stopRefreshAnimation];
//                [refreshTimer invalidate];
//                refreshTimer = nil;
//            }
            [weakSelf performSelector:@selector(checkUpdateStatus) withObject:nil afterDelay:20];
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
            [detailView stopRefreshAnimation];//停止动画
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
        [detailView stopRefreshAnimation];
    }];
    
     [taskArray addObject:task];
}

//开启定时器轮询检查更新状态
- (void)startTimerRequest{
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(checkUpdateStatus) userInfo:nil repeats:YES];
    [refreshTimer fire];
}

//检测更新状态
- (void)checkUpdateStatus{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (KUSER.userId) {
        [params setObject:KUSER.userId forKey:@"userId"];
    }
    [params setObject:self.companyName forKey:@"entName"];
    [params setObject:detailModel.companyid forKey:@"entId"];
    KWeakSelf
    NSURLSessionDataTask*task = [RequestManager QXBGetWithURLString:GetRefreshEntInfo parameters:params success:^(id responseObject) {
        if([responseObject[@"result"]intValue] == 0){
            
            detailModel.currentstate = responseObject[@"currentstate"];
            if ([detailModel.currentstate intValue] == 1) {//更新完成
                detailModel.updatestate = responseObject[@"updatestate"];
                detailView.detailModel = detailModel;//此处会导致动画和timer的停止，刷新tableview导致cell重建，动画为nil
                [weakSelf stopTimerRequest];
            }
        }
    } failure:^(NSError *error) {
    }];
    [taskArray addObject:task];
}

- (void)stopTimerRequest{
    [refreshTimer invalidate];
    refreshTimer = nil;
    [detailView stopRefreshAnimation];
}

#pragma mark - 九宫格点击
-(void)gridButtonClick:(ItemModel *)model cellSection:(int)section
{

    if(section == 2) //企业背景
    {
        BackgroundController *vc = [[BackgroundController alloc] init];
        vc.companyName = detailModel.companyname;
        vc.saveTitleStr = model.menuname;
        vc.itemModel = model;
        vc.companyId = detailModel.companyid;
        vc.itemArray = itemList;
        //[MobClick event:model.umeng];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (section == 3)//风险信息
    {
        
        RiskContainerController *vc = [RiskContainerController new];
        vc.saveTitleStr = model.menuname;
        vc.itemArray = riskItemList;
        vc.itemModel = model;
        vc.companyId = detailModel.companyid;
        vc.companyName = detailModel.companyname;
        //[MobClick event:model.umeng];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (section == 4)//经营状况
    {
        OperatingController *vc1 = [[OperatingController alloc] init];
        vc1.companyName = detailModel.companyname;
        vc1.saveTitleStr = model.menuname;
        vc1.itemModel = model;
        vc1.companyId = detailModel.companyid;
        vc1.itemArray = manageItemList;
        //[MobClick event:model.umeng];
        [self.navigationController pushViewController:vc1 animated:YES];

    }
    else if (section == 5)//无形资产
    {
        AssetsContainerController *vc = [AssetsContainerController new];
        vc.saveTitleStr = model.menuname;
        vc.companyId = detailModel.companyid;
        vc.companyName = detailModel.companyname;
        vc.itemModel = model;
        vc.itemArray = assetItemList;
        
        //[MobClick event:model.umeng];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - 获取报告/纠错/监控/认证
-(void)checkReport:(UIButton *)button
{
    if(button.tag == KDetailOperationTag)//获取报告
    {
        
    }
    else if (button.tag == KDetailOperationTag+1)//纠错
    {
        RecoveryErrorViewController *recoveryErrorView = [[RecoveryErrorViewController alloc] init];
        recoveryErrorView.squearList =  itemList;
        recoveryErrorView.companyId = detailModel.companyid;
        recoveryErrorView.companyName = self.companyName;
        [self.navigationController pushViewController:recoveryErrorView animated:YES];
    }
    else if (button.tag == KDetailOperationTag+2)//监控
    {
        [self monitorCompany:button];
    }
    else //if (button.tag == KDetailOperationTag+2)//认证
    {
        [self checkAuthStatus];
    }
}



-(void)loginSuccessCheckReport:(NSString *)reportType
 {
//    [MBProgressHUD showMessag:@"" toView:self.view];
//    NSString *str = [NSString stringWithFormat:@"%@?entId=%@&userId=%@&entName=%@&type=%@",KCheckEntReportVipType,detailModel.companyid,KUSER.userId,self.companyName,reportType];
//    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    KBolckSelf;
//    NSURLSessionDataTask*task = [RequestManager QXBGetWithURLString:str parameters:nil success:^(id responseObject) {
//        [MBProgressHUD hideHudToView:self.view animated:YES];
//        NSLog(@"查看企业报告=%@",responseObject);
//        if([[responseObject objectForKey:@"result"]intValue] == 0){//跳转各种报告
//            ReportController *vc = [[ReportController alloc]init];
//            vc.url = [NSString stringWithFormat:@"%@&version=%@&apptype=1",[[responseObject objectForKey:@"data"] objectForKey:@"reportUrl"],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] ;
//            vc.vipType = [[responseObject objectForKey:@"data"] objectForKey:@"vipType"];
//            vc.companyId = detailModel.companyid;
//            vc.companyName = self.companyName;//test此处需要传入报告类型
//            [blockSelf.navigationController pushViewController:vc animated:YES];
//        }else{
//            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
//        }
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"请求失败" toView:self.view];
//    }];
//     [taskArray addObject:task];
}

#pragma mark - 点击地理位置
-(void)companyAdress
{
    //[MobClick event:@"Detail60"];//企业详情页－地址点击数
    //[[BaiduMobStat defaultStat] logEvent:@"Detail60" eventLabel:@"企业详情页－地址点击数"];

    MapViewController *view = [[MapViewController alloc]init];
    view.companyDetailModel = detailModel;
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 拨打电话
-(void)callCompany:(NSString *)phoneStr
{
//    //[MobClick event:@"Detail61"];//企业详情页－电话点击数
//    //[[BaiduMobStat defaultStat] logEvent:@"Detail61" eventLabel:@"企业详情页－电话点击数"];
//
//    MyAlertView *alertView = [[MyAlertView alloc] initWithTitle:@"提示" icon:nil message:[NSString stringWithFormat:@"确定拨打电话：%@ ？",phoneStr] delegate:self buttonTitles:@"呼叫",@"取消", nil];
//    [alertView show];
    
    
    //[MobClick event:@"Businessdetails02"]; //企业详情-联系电话点击数
    //[[BaiduMobStat defaultStat] logEvent:@"Businessdetails02" eventLabel:@"企业详情-联系电话点击数"];
    
    NSLog(@"呼叫");
    NSString *string =[[self->detailModel.companyphonelist objectAtIndex:0] objectForKey:@"number"];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",string];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

#pragma mark 导出企业通讯录
-(void)downContact
{
//    if (KUSER.userId.length) {
//        DownContactController*vc = [[DownContactController alloc]init];
//        NSMutableArray *phoneArray = [NSMutableArray array];
//        for(NSDictionary *dic in detailModel.companyphonelist)
//        {
//            [phoneArray addObject:[dic objectForKey:@"number"]];
//        }
//        vc.dataArray = @[@{@"name":detailModel.companyname,@"establishDate":detailModel.cratedate,@"phoneArr":phoneArray,@"id":detailModel.companyid}].mutableCopy;
//
//        //    AddressBookModel *model = [[AddressBookModel alloc]init];
//        //    model.phoneArr = detailModel.companyphonelist;
//        //    model.entId = detailModel.companyid;
//        //    model.name = detailModel.companyname;
//        //    model.establishDate = detailModel.cratedate;
//        //    vc.dataArray = @[model];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        [self goToLogin];
//    }
}

- (void)goToLogin{
//    LoginController *view = [[LoginController alloc]init];
//    view.loginSuccessBlock = ^{
//        
//    };
//    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 刷新
-(void)refreshCompany
{
    
    if([detailModel.currentstate integerValue] == 1)//已是最新
    {
        [MBProgressHUD showHint:@"已是最新信息" toView:self.view];
    }else//可以进行更新
    {
        [self updataCompanyInfo];
    }
    
}

#pragma mark -  股东高管查看更多
-(void)detailHolderCheckMore:(DetailHolderType)type
{
    int idType = type == DetailHolderGDType?2:3;
    for(NSDictionary *dic in itemList)
    {
        if([[dic objectForKey:@"menuid"] intValue] == idType)
        {
            ItemModel *sqModel = [ItemModel mj_objectWithKeyValues:dic];
            [self gridButtonClick:sqModel cellSection:2];
            break;
        }
    }
}


#pragma mark 企业图谱/关联关系 /股权结构
- (void)detailMapButtonClick:(UIButton *)button
{
    if(button.tag == KDetailMapBtnTag)//企业图谱
    {
        for(NSDictionary *dic in itemList)
        {
            if([[dic objectForKey:@"type"] intValue] == 2)//企业图谱
            {
                ItemModel *sqModel = [ItemModel mj_objectWithKeyValues:dic];
                [self gridButtonClick:sqModel cellSection:2];
                break;
            }
        }
    }
    else if(button.tag == KDetailMapBtnTag+1)//关联关系
    {
        
    }
    else//股权结构
    {
        
    }
}
#pragma mark 企业风险
-(void)checkDetailRisk
{
    
}
#pragma mark 更多信息
-(void)checkDetailMoreInfo
{
    CommonWebViewController *view = [[CommonWebViewController alloc]init];
    view.urlStr = detailUrlStr;
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 网址
-(void)CompanyUrl:(NSString *)urlStr
{
    CommonWebViewController *view = [[CommonWebViewController alloc]init];
    view.titleStr = @"";
    
    NSRange range = [urlStr rangeOfString:@"http"];
    if(range.location != NSNotFound)//存在
    {
        view.urlStr = urlStr;
    }
    else
    {
        view.urlStr = [NSString stringWithFormat:@"http://%@",urlStr];//添加https
    }
    
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 拨打电话代理
-(void)alertView:(MyAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        NSLog(@"取消");
    }else
    {
        //[MobClick event:@"Businessdetails02"]; //企业详情-联系电话点击数
        //[[BaiduMobStat defaultStat] logEvent:@"Businessdetails02" eventLabel:@"企业详情-联系电话点击数"];

        NSLog(@"呼叫");
        NSString *string =[[self->detailModel.companyphonelist objectAtIndex:0] objectForKey:@"number"];
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",string];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}

//设置关注按钮的标题文字
-(void)setFoucsBtn:(BOOL)isFouc
{
    
    if(!isFouc)
    {
        [focuButton setImage:KImageName(@"详情收藏") forState:UIControlStateNormal];
        focuButton.tag = 45678;
    }
    else
    {
        [focuButton setImage:KImageName(@"详情收藏_h") forState:UIControlStateNormal];
        focuButton.tag = 45677;
    }
}

//设置关注按钮的标题文字
-(void)setMonitorBtn:(BOOL)isMonitor
{
    UIButton *sender = [self.view viewWithTag:KDetailOperationTag+2];
    
    if(!isMonitor)
    {
        [sender setTitle:@"监控" forState:UIControlStateNormal];
        
    }
    else
    {
        [sender setTitle:@"已监控" forState:UIControlStateNormal];
    }
}


-(void)drawView
{
    detailView = [[DetailView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight)];
    detailView.delegate = self;
    [self.view addSubview:detailView];
}

//创建navigaiton上的东西
-(void)setRightBarBtn
{
    
    NSMutableArray *buttonArray = [[NSMutableArray alloc ] init];
    
    shareBarButton = [self addRightItemWithImage:@"分享icon" withImageRectRect:CGRectMake(0, 0, 20, 17) action:@selector(share)];

    focuButton = [self addRightItemWithImage:@"详情收藏" withImageRectRect:CGRectMake(0, 0, 17, 17) action:@selector(focuCompany:)];
    
    errorBtn = [self addRightItemWithImage:@"详情" withImageRectRect:CGRectMake(0, 0, 20, 17) action:@selector(errorCorrection)];
    
    
    if (@available(iOS 11.0,*) ){
      
    }else{
        UIBarButtonItem *negativeSpace = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                          target:nil action:nil];
        negativeSpace.width = -15;
        [buttonArray addObject:negativeSpace];
    }
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBarButton];
    UIBarButtonItem *focuItem = [[UIBarButtonItem alloc] initWithCustomView:focuButton];
   // UIBarButtonItem *errorItem = [[UIBarButtonItem alloc] initWithCustomView:errorBtn];
    
   // [buttonArray addObject:errorItem];
    [buttonArray addObject:focuItem];
    //[buttonArray addObject:shareItem];
    
    self.navigationItem.rightBarButtonItems = buttonArray;
}

//ios11下改变item间距
- (void)viewDidLayoutSubviews{
    
    if (@available(iOS 11.0,*)) {
        UINavigationItem * item=self.navigationItem;
        NSArray * array=item.rightBarButtonItems;
        if (array&&array.count!=0){
            UIBarButtonItem * buttonItem=array[0];
            UIView * view =[[[buttonItem.customView superview] superview] superview];
            NSArray * arrayConstraint=view.constraints;
            for (NSLayoutConstraint * constant in arrayConstraint) {
                if (constant.constant==-16) {//-16表示右侧
                    constant.constant = 0;
                }
            }
        }
    }

}

//创建导航栏右边按钮的button
- (UIButton *)addRightItemWithImage:(NSString *)imageName withImageRectRect:(CGRect)imageRect action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    //[button setTitle:imageName forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar fs_setBackgroundColor:KNavigationBarRedColor];
}

-(void)back
{
    for(NSURLSessionDataTask *task in taskArray)
    {
        if(task)
        {
            [task cancel];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopTimerRequest];//停止检查更新状态
}


- (BOOL)shouldAutorotate
{
    return YES;
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return  UIInterfaceOrientationPortrait ;
}



@end
