//
//  SearchResultController.m
//  EnterpriseInquiry
//
//  Created by WangZhipeng on 17/9/15.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import "SearchResultController.h"
#import "CompanyInfoModel.h"
#import "CompanyDetailController.h"
#import "MJRefresh.h"
#import "SearchTaxCodeCell.h"
#import "SearchCompanyCell.h"
#import "SearchJobCell.h"
#import "SearchTaxCodeModel.h"
#import "SearchJobModel.h"
#import "CommonWebViewController.h"
#import "FilterView.h"
#import "FilterCellModel.h"
#import "ExportBar.h"
#import "AddressBookCell.h"
#import "AddressBookModel.h"
#import "ReportExportBar.h"
#import "CustomAlert.h"

#import "ShareholderCell.h"

#define kCellID @"SearchCollectionCell"
#define kReusableHeaderView @"reusableHeaderView"
#define kReusableFooterView @"reusableFooterView"

#define SearchTaxID     @"SearchTaxCodeCell"
#define SearchCompanyID @"SearchCompanyCell"
#define SearchJobID     @"SearchJobCell"
#define AddressBookID   @"AddressBookCell"
#define ShareholderID   @"ShareholderCell"




@interface SearchResultController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,FilterViewDelegate,SearchCellSelectedDelegate,ExportBarProtocol>

{
    bool _openSection[10];
    
    BOOL isShowLoseFootView;//是否展示失信的footview
    
    BOOL isShowFootView;//全网查找的footview;
    
    SearchAllWebView *searchAllWebView;
}

@property (nonatomic, strong) UISearchBar  *companySearchBaBar;//搜索bar
@property (nonatomic, strong) UIView *searchView;//barView
@property (nonatomic, strong) UITableView *companySearchTableView;
@property (nonatomic, strong) UITableView *sortSearchTableView;
@property (nonatomic, assign) NSInteger currpage; //当前页
@property (nonatomic, strong) NSMutableArray *companyAllArr;

//@property (nonatomic, strong) ChooseView *chooseView;//筛选界面

@property (nonatomic, assign) CGFloat sortBarH;//排序条高
@property (nonatomic, assign) CGFloat tipsBarH;//搜索结果数条高

@property (nonatomic, strong) UILabel *tipsLab;//搜索到企业数
@property (nonatomic ,strong) FilterView *filterView;

@property (nonatomic ,strong) NSMutableDictionary *exportModels;

@property (nonatomic ,assign) BOOL showCheckbox;//企业通讯录 选择、取消选择
@property (nonatomic ,assign) BOOL allSelected;//通讯录全选

@property (nonatomic ,strong) ExportBar *exportBar;
@property (nonatomic ,strong) ReportExportBar *reportExportBar;//企业报告导出



@end

@implementation SearchResultController
{
    
    
    NSInteger _iszhankai;
    UIView *viewbtn;
    UIButton *Hotsort;
    UIButton *capitalsort;
    UIButton *timesort;
    
    UIButton *hotalphabtn;
    UIButton *alphaBtn;//用于控制注册资金按钮点击状态是否可以点击
    UIButton *timeralphaBtn;//用于控制注册时间按钮点击状态是否可以点击
    
    
    NSString *City;//城市
    NSString *Province;//省份
    NSString *industry;//行业
    NSString *Registeredcapital;//注册资金
    NSString *Establishmentperiod;//行业
    
    
    UIButton *popBtn; //返回透明btn
    
    //    ChooseView *chooseView;//筛选界面
    
    NSString *SortHistory;// 排序记录
    
    NSMutableDictionary *chooseDic;//筛选的条件
    
    UIButton *defaultBtn;//默认排序按钮
    UIButton *moneyBtn;//注册资金
    UIButton *timeBtn;//注册时间
    
    SortType sortType;//排序
    
    LoseCreditType loseCreditType;//失信的type
    
    UIButton *clearBtn;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBtn:@""];
    
    self.view.backgroundColor = KHexRGB(0xf8f8f8);
    //初始化
    _iszhankai = -1;
    _currpage = 1;
    chooseDic = [NSMutableDictionary dictionaryWithCapacity:1];

    loseCreditType = 1;
    isShowLoseFootView = NO;
    isShowFootView = NO;
    
    [self.searchView addSubview:self.companySearchBaBar];
    self.navigationItem.titleView = self.searchView;
    
    //绘制筛选按钮
    if (self.searchType != SearchTaxCodeType&&self.searchType != SearchJobType&&self.searchType != SearchRiskAnalyzeType ) {
        [self drawFilterBtn];//绘制筛选按钮
        [KeyWindow addSubview:self.filterView];//添加筛选列表
    }
    
    //是否显示排序
    if (self.searchType != SearchTaxCodeType && self.searchType != SearchRiskAnalyzeType) {
        _sortBarH = self.searchType== SearchCrackcreditType?36:51;
        if (self.searchType == SearchAddressBookType||self.searchType == SearchPenaltyType) {
            [self drawExportBar];
        }else{
            [self drawSortView];
        }
    }
    //搜索结果数
    if (self.searchType != SearchCrackcreditType) {
        [self drawTipsView];
    }
    
    [self.view addSubview:self.companySearchTableView];
    self.companySearchTableView.mj_footer.hidden = YES;
    
    //给tableview添加手势隐藏键盘
    [self hidekeyboard];
    [self setupRefresh];
    
    [self loadData:YES];
    
    
}

//弹出筛选页面
- (void)ScreenClick{
    
    //[MobClick event:@"Search47"];//搜索结果页－筛选按钮点击数
    //[[BaiduMobStat defaultStat] logEvent:@"Search47" eventLabel:@"搜索结果页－筛选按钮点击数"];
    [self.filterView showChooseView];
}

#pragma mark - 请求信息
- (void)loadData:(BOOL)loading {
    
    NSString *urlStr;
    NSMutableDictionary *paraDic  = [NSMutableDictionary dictionaryWithDictionary:chooseDic];
    isShowLoseFootView = NO;
    isShowFootView = NO;
    [searchAllWebView removeFromSuperview];
    
    HttpRequestType requestType;
    if(self.searchType == SearchCrackcreditType)
    {
        urlStr = BlackListSearch;
        [paraDic setObject:[NSString stringWithFormat:@"%d",(int)loseCreditType] forKey:@"type"];
        requestType = HttpRequestTypePost;
    }else if (self.searchType == SearchTaxCodeType){
        
        urlStr = KGetSearByRegCode;
        requestType = HttpRequestTypeGet;

    }else if (self.searchType == SearchJobType){
        urlStr = KGetCompInJobPage;
        requestType = HttpRequestTypeGet;
        [paraDic setObject:self.btnTitile forKey:@"entName"];

    }else if (self.searchType == SearchAddressBookType){
        urlStr = KSearchEntContact;
        requestType = HttpRequestTypeGet;
        sortType= sortType?:TimeDownSortType;
        [paraDic setObject:self.btnTitile forKey:@"entName"];
        [paraDic setObject:@(sortType) forKey:@"sequence"];

    }else{
        urlStr = GetSear;
        sortType= sortType?:TimeDownSortType;
        int type = _searchType == SearchSeekRelationType?6:_searchType;

        [paraDic setObject:@(type) forKey:@"type"];
        [paraDic setObject:@(sortType) forKey:@"sequence"];
        requestType = HttpRequestTypeGet;
        
        if(sortType == HotSortType)
        {
            //[MobClick event:@"Search54"];//默认排序
            //[[BaiduMobStat defaultStat] logEvent:@"Search54" eventLabel:@"搜索结果页－默认排序点击数"];
            
        }
        else if (sortType == MoneyUpSortType||sortType == MoneyDownSortType)
        {
            //[MobClick event:@"Search55"];//注资排序
            //[[BaiduMobStat defaultStat] logEvent:@"Search55" eventLabel:@"搜索结果页－注资排序点击数"];
            
        }
        else
        {
            //[MobClick event:@"Search56"];//时间排序
            //[[BaiduMobStat defaultStat] logEvent:@"Search56" eventLabel:@"搜索结果页－时间排序点击数"];
            
        }
        
        if(self.searchType == SearchBlurryType)
        {
            //[MobClick event:@"Search29"];//企业总搜索次数
            //[[BaiduMobStat defaultStat] logEvent:@"Search29" eventLabel:@"企业总搜索次数"];
        }
        
    }
    
    [paraDic setObject:self.btnTitile forKey:@"searchkey"];
    [paraDic setObject:@"20" forKey:@"pageSize"];
    [paraDic setObject:@(_currpage) forKey:@"pageIndex"];
    
    if (loading) {
        [self showLoadDataAnimation];
    }
    
    KWeakSelf
    [RequestManager QXBRequestWithURLString:urlStr parameters:paraDic type:requestType success:^(id responseObject) {
        NSLog(@"responseObject---%@",responseObject);
        [weakSelf hideLoadDataAnimation];
        [ weakSelf endRefresh];
        
        NSArray * tmpArray;
        
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            if ( weakSelf.currpage == 1) {
                [self.exportModels removeAllObjects];//刷新排序 清空导出map
                [ weakSelf.companyAllArr removeAllObjects];
//                [self.companySearchTableView setContentOffset:CGPointMake(0,0) animated:YES];
            }
            
            if(self.searchType == SearchCrackcreditType)
            {
                SearchLoseCreitARRModel *loseCreitArrModel = [SearchLoseCreitARRModel mj_objectWithKeyValues:responseObject];
                tmpArray = [NSArray arrayWithArray:loseCreitArrModel.dishonestylist];
            }else if (self.searchType == SearchTaxCodeType){
                
                tmpArray = [SearchTaxCodeModel mj_objectArrayWithKeyValuesArray:responseObject[@"dataResult"]];

            }else if (self.searchType == SearchJobType){
                
                tmpArray = [SearchJobModel mj_objectArrayWithKeyValuesArray:responseObject[@"dataResult"]];
            }else if (self.searchType == SearchAddressBookType){
                
                tmpArray = [AddressBookModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [weakSelf setSelectState:tmpArray];//设置选中状态
            }else{
                
                NSArray *array = [NSArray arrayWithArray:responseObject[@"businesslist"]];
                tmpArray = [CompanyInfoModel mj_objectArrayWithKeyValuesArray:array];
                [weakSelf setSelectState:tmpArray];//设置选中状态
            }
            
            [weakSelf.companyAllArr addObjectsFromArray:tmpArray];
            
            if(weakSelf.companyAllArr.count == 0 && weakSelf.currpage == 1){
                if( weakSelf.searchType == SearchBlurryType){
                    //[MobClick event:@"Search30"];//企业搜索无结果次数
                    //[[BaiduMobStat defaultStat] logEvent:@"Search30" eventLabel:@"企业搜索无结果次数"];
                    NSLog(@"搜索无结果");
                }else if( weakSelf.searchType == SearchCrackcreditType)//只有失信查询才弹出提示框
                {
                    [MBProgressHUD showError:@"没有相关数据" toView:self.view];
                }
            }
            
            if(self.searchType == SearchCrackcreditType)
            {
                BOOL ismore = [[responseObject objectForKey:@"ismore"] boolValue];
                if(!ismore){
                    [weakSelf.companySearchTableView.mj_footer endRefreshingWithNoMoreData];
                    isShowLoseFootView = YES;
                }
            }else if (self.searchType == SearchTaxCodeType||self.searchType == SearchJobType||self.searchType == SearchAddressBookType){
                
                [_reportExportBar setTipsWithNum:responseObject[@"totalCount"] type:self.searchType];//设置搜索结果数
                
                if([responseObject[@"totalCount"] intValue] == weakSelf.companyAllArr.count){
                    [weakSelf.companySearchTableView.mj_footer endRefreshingWithNoMoreData];
                }
                
            }else{
                
                [_reportExportBar setTipsWithNum:responseObject[@"count"] type:self.searchType];//设置搜索结果数
                
                if(weakSelf.companyAllArr.count == [[responseObject objectForKey:@"count"] intValue]){
                    [weakSelf.companySearchTableView.mj_footer endRefreshingWithNoMoreData];
                    if(weakSelf.companyAllArr.count == 0){
                        isShowFootView = NO;
                        searchAllWebView = [[SearchAllWebView alloc]initWithFrame: KFrame(0, 0, weakSelf.companySearchTableView.width, weakSelf.companySearchTableView.height)];
                        searchAllWebView.searchAllWeb = ^{
                            [weakSelf searchAllNetwork];
                        };
                        [weakSelf.companySearchTableView addSubview:searchAllWebView];
                    }else{
                        isShowFootView = YES;
                    }
                }
            }
            weakSelf.currpage ++;
            
        }else{
            NSString *result = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
            if(result.length>0){
                
                [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
            }else{
                if (loading) {
                    [weakSelf showNetFailViewWithFrame:weakSelf.companySearchTableView.frame];
                }
            }
        }
        [ weakSelf.companySearchTableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf endRefresh];
        [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
        if (loading) {
            [weakSelf showNetFailViewWithFrame:weakSelf.companySearchTableView.frame];
        }
        
    }];
    
}

- (void)abnormalViewReload{
    [self loadData:YES];
}

#pragma mark 全网查找
-(void)searchAllNetwork
{
    //[MobClick event:@"Search16"];
    //[[BaiduMobStat defaultStat] logEvent:@"Search16" eventLabel:@"搜索页面-全网搜索"];
    
    ProblemViewController *probelemView = [[ProblemViewController alloc] init];
    probelemView.titleName = @"企业查询";
    
    NSString *city;
    NSString *provincestr = chooseDic[@"province"];
    NSString *citystr = chooseDic[@"city"];
    if(provincestr && provincestr.length >0)
    {
        city = [NSString stringWithFormat:@"?Province=%@",provincestr];
    }
    else
    {
        if(citystr && citystr.length >0)
        {
            city = [NSString stringWithFormat:@"?Province=%@",citystr];
        }
        else
        {
            city = [NSString stringWithFormat:@"?Province=%@",@"全国"];
        }
        
    }
    
    NSString *searchCriteria = [NSString stringWithFormat:@"&text=%@",self.btnTitile];
    NSString *verson = [NSString stringWithFormat:@"&version=%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    NSString *appType = [NSString stringWithFormat:@"&appType=%@",@"1"];
    probelemView.url = [NSString stringWithFormat:@"%@%@%@%@%@%@",HOSTURL,FullWebSearch,city,searchCriteria,verson,appType];
    [self.navigationController pushViewController:probelemView animated:YES];
}



#pragma mark searchBar Delegate

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(searchBackWithClear:)])
    {
        if(searchBar.text.length == 0)
        {
            return NO;
        }
        
        [self.delegate searchBackWithClear:NO];
        
        
        [self popViewControllerWithType:PopNormal];
        
    }
    
    return NO;
}

-(void)clearBtnClick
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(searchBackWithClear:)])
    {
        [self.delegate searchBackWithClear:YES];
        [self popViewControllerWithType:PopNormal];
    }
}


-(void)hidekeyboard{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_companySearchTableView addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.companySearchBaBar resignFirstResponder];
}



#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.companyAllArr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.searchType == SearchCrackcreditType)
    {
        static NSString* cellID = @"cell";
        LoseCreditCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[LoseCreditCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.LoseCreditModel = _companyAllArr[indexPath.row];
        return cell;
        
    }else if (self.searchType == SearchTaxCodeType){
        SearchTaxCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchTaxID];
        if (!cell) {
            cell = [[SearchTaxCodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchTaxID];
        }
        cell.model = _companyAllArr[indexPath.row];
        return cell;
    }
    else if (self.searchType == SearchJobType){
        SearchJobCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchJobID];
        if (!cell) {
            cell = [[SearchJobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchJobID];
        }
        cell.model = _companyAllArr[indexPath.row];
        return cell;
    }else if (self.searchType == SearchAddressBookType){
        AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressBookID];
        if (!cell) {
            cell = [[AddressBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressBookID];
            cell.delegate = self;
        }
        [cell setModel:_companyAllArr[indexPath.row] checkboxShow:_showCheckbox];
        return cell;
    }else if (self.searchType == SearchSeekRelationType){
        ShareholderCell *cell = [tableView dequeueReusableCellWithIdentifier:ShareholderID];
        if (!cell) {
            cell = [[ShareholderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShareholderID];
            cell.delegate = self;
        }
        [cell setModel:_companyAllArr[indexPath.row] showCheckbox:_showCheckbox];
        return cell;
    }
    else if (self.searchType == SearchRiskAnalyzeType){
        RiskAnalyzeCell *cell = [tableView dequeueReusableCellWithIdentifier:ShareholderID];
        if (!cell) {
            cell = [[RiskAnalyzeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShareholderID];
           
        }
        cell.dataDic = @{};
        return cell;
    }
    else{
        SearchCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCompanyID];
        if (!cell) {
            cell = [[SearchCompanyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchCompanyID];
            cell.delegate = self;
        }
        [cell setModel:_companyAllArr[indexPath.row] showCheckbox:_showCheckbox];
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(self.searchType == SearchCrackcreditType && isShowLoseFootView &&_companyAllArr.count >0)
    {
        return 60;
    }
    else
    {
        if(isShowFootView)
        {
            return 60;
        }
        else
        {
            return 0.001f;
        }
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(self.searchType == SearchCrackcreditType && isShowLoseFootView&&_companyAllArr.count >0)
    {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KDeviceH - 60, KDeviceW, 60)];
        bottomView.backgroundColor = [UIColor clearColor];
        
        NSString * title = @"数据来源：全国法院信息公示系统，仅供参考 ";
        
        CGFloat width = [Tools getWidthWithString:title fontSize:13 maxHeight:KDeviceW];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(KDeviceW/2-width/2 + 10, 20, width, 20)];
        textLabel.textColor = KHexRGB(0x97999E);
        textLabel.font = KFont(13);
        textLabel.text = @"数据来源：全国法院信息公示系统，仅供参考 ";
        [bottomView addSubview:textLabel];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(textLabel.x - 15 - 5, 22, 15, 15)];
        imageView.image = [UIImage imageNamed:@"Bell"];
        [bottomView addSubview:imageView];
        
        
        
        return bottomView;
    }
    else
    {//石油
        if(isShowFootView)
        {
            _companySearchTableView.backgroundColor = KHexRGB(0xf8f8f8);
            
            UIView *backView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 60)];
            backView.backgroundColor = KHexRGB(0xf8f8f8);
            
            //75
            UILabel *label = [[UILabel alloc]initWithFrame:KFrame(KDeviceW/2- 5-90, 10, 90, 35)];
            label.font = KFont(12);
            label.textColor = KRGB(153, 153, 153);
            label.text = @"没有找到信息？\n试试全网查找吧";
            label.numberOfLines = 0;
            [backView addSubview:label];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = KFrame(KDeviceW/2+5, 12.5, 75, 30);
            [button setTitle:@"全网查找" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button jm_setCornerRadius:5 withBackgroundColor:KRGB(253, 119, 49)];
            [button addTarget:self action:@selector(searchAllNetwork) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = KFont(14);
            [backView addSubview:button];
            
            return backView;
        }
        else
        {
            _companySearchTableView.backgroundColor = [UIColor whiteColor];
            return nil;
        }
        
        
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1f;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.searchType == SearchCrackcreditType)
    {
        //[MobClick event:@"Search28"];//失信查询页－有结果－结果点击数
        //[[BaiduMobStat defaultStat] logEvent:@"Search28" eventLabel:@"失信查询页－有结果－结果点击数"];
        
        LoseCreditModel *creditModel = _companyAllArr[indexPath.row];
        CommonWebViewController *commonWeb = [[CommonWebViewController alloc] init];
        commonWeb.titleStr = @"失信详情";
        commonWeb.urlStr = creditModel.url;
        [self.navigationController pushViewController:commonWeb animated:YES];
    }else if (self.searchType == SearchJobType){
     
        SearchJobModel *model = self.companyAllArr[indexPath.row];
        
        CommonWebViewController *commomwevView = [[CommonWebViewController alloc] init];
        commomwevView.titleStr = @"招聘详情";
        commomwevView.urlStr = model.url;
        commomwevView.dataDic = model.mj_keyValues;
        [self.navigationController pushViewController:commomwevView animated:YES];
    }else if (self.searchType == SearchAddressBookType){
        AddressBookModel *model = self.companyAllArr[indexPath.row];
        if (_showCheckbox) {
            model.selected = !model.selected;
            [self.companySearchTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            CompanyDetailController *vc = [CompanyDetailController new];
            vc.companyId = model.companyid;
            vc.companyName = model.companyname;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (self.searchType == SearchRiskAnalyzeType){
        RiskAnalyzeController *vc = [RiskAnalyzeController new];
       
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        CompanyInfoModel *model = self.companyAllArr[indexPath.row];
        if (_showCheckbox) {
            if (self.exportModels.allKeys.count >=KReportExportNum && !model.selected) {
                return;
            }
            model.selected = !model.selected;
            [self.companySearchTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            //[MobClick event:@"Search46"];//搜索结果页－搜索结果点击数
            //[[BaiduMobStat defaultStat] logEvent:@"Search46" eventLabel:@"搜索结果页－搜索结果点击数"];
            
            CompanyDetailController *vc =[[CompanyDetailController alloc]init];
            vc.companyId = model.companyid;
            vc.companyName = model.companyname;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 选择导出
- (void)drawExportBar{
    self.exportBar = [[ExportBar alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, _sortBarH)];
    _exportBar.delegate = self;
    [self.view addSubview:_exportBar];
}
#pragma mark - 绘制排序部分
-(void)drawSortView
{

    UIView *sortBackView = [[UIView alloc]initWithFrame:CGRectMake(0, KNavigationBarHeight, KDeviceW, _sortBarH)];
    sortBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sortBackView];
    
    if(self.searchType == SearchCrackcreditType)
    {
        NSArray *titleArray = @[@"全部",@"失信人",@"失信企业"];
        for(int i = 0;i<titleArray.count;i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = KFrame(KDeviceW/3*i, 0, KDeviceW/3, 35);
            [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            button.titleLabel.font = KFont(14);
            [button setTitleColor:KRGB(102,102,102) forState:UIControlStateNormal];
            [button setTitleColor:KRGB(255,119,46) forState:UIControlStateSelected];
            [button addTarget:self action:@selector(loseCreditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if(i==0)
            {
                button.selected = YES;
            }
            button.tag = LoseCreditBtnTag + i + 1;
            [sortBackView addSubview:button];
        }
        
    }
    else
    {
        sortType = HotSortType;
        
        CGFloat y = (_sortBarH-35)/2;
        //默认排序
        defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        defaultBtn.frame = KFrame(0, y, KDeviceW/3, 35);
        [defaultBtn setTitle:@"默认排序" forState:UIControlStateNormal];
        defaultBtn.titleLabel.font = KFont(16);
        [defaultBtn setTitleColor:KHexRGB(0x666666) forState:UIControlStateNormal];
        [defaultBtn setTitleColor:KHexRGB(0x333333) forState:UIControlStateSelected];
        [defaultBtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        defaultBtn.selected = YES;
        sortType = HotSortType;
        [sortBackView addSubview:defaultBtn];
        
        
        //注册资金
        moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moneyBtn.frame = KFrame(KDeviceW/3, y, KDeviceW/3, 35);
        [moneyBtn setTitle:@"注册资金" forState:UIControlStateNormal];
        moneyBtn.titleLabel.font = KFont(14);
        [moneyBtn setTitleColor:KHexRGB(0x666666) forState:UIControlStateNormal];
        [moneyBtn setTitleColor:KHexRGB(0x333333) forState:UIControlStateSelected];
        [moneyBtn setImage:KImageName(@"botom") forState:UIControlStateNormal];
        [moneyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -defaultBtn.imageView.image.size.width-10, 0, defaultBtn.imageView.image.size.width+10)];
        [moneyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, defaultBtn.titleLabel.bounds.size.width+10 , 0, - defaultBtn.titleLabel.bounds.size.width-10 )];
        moneyBtn.tag = MoneyNormalState;
        [moneyBtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sortBackView addSubview:moneyBtn];
        
        
        //注册时间
        timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        timeBtn.frame = KFrame(KDeviceW/3*2, y, KDeviceW/3, 35);
        [timeBtn setTitle:@"注册时间" forState:UIControlStateNormal];
        timeBtn.titleLabel.font = KFont(14);
        [timeBtn setTitleColor:KHexRGB(0x666666) forState:UIControlStateNormal];
        [timeBtn setTitleColor:KHexRGB(0x333333) forState:UIControlStateSelected];
        
        [timeBtn setImage:KImageName(@"botom") forState:UIControlStateNormal];
        [timeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -defaultBtn.imageView.image.size.width-10, 0, defaultBtn.imageView.image.size.width+10)];
        [timeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, defaultBtn.titleLabel.bounds.size.width+10 , 0, - defaultBtn.titleLabel.bounds.size.width-10 )];
        timeBtn.tag =  TimeNormalState;
        [timeBtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sortBackView addSubview:timeBtn];
        
    }
}

#pragma mark - 绘制筛选按钮

- (void)drawFilterBtn{
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    //[buttonRight setTitle:@"筛选" forState:UIControlStateNormal];
    [buttonRight setImage:KImageName(@"details_icon_shaixuan") forState:UIControlStateNormal];
//    buttonRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, );
//    buttonRight.titleLabel.textAlignment = NSTextAlignmentRight;
    buttonRight.frame = CGRectMake(0, 0, 60, 44);
    [buttonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonRight.titleLabel.font = KFont(14);
    [buttonRight addTarget:self action:@selector(ScreenClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 绘制匹配企业数提示
- (void)drawTipsView{
    _tipsBarH = 30;
    _reportExportBar = [[ReportExportBar alloc]initWithFrame:KFrame(0, KNavigationBarHeight+_sortBarH, KDeviceW, _tipsBarH)];
    _reportExportBar.barType = (_searchType == SearchAddressBookType||_searchType == SearchSeekRelationType||_searchType == SearchTaxCodeType||_searchType == SearchJobType||_searchType == SearchRiskAnalyzeType)?1:0;
    _reportExportBar.delegate = self;
    [self.view addSubview:_reportExportBar];
}

#pragma mark - 排序按钮点击
-(void)sortBtnClick:(UIButton*)button
{
    
    defaultBtn.selected = NO;
    moneyBtn.selected = NO;
    timeBtn.selected = NO;
    
    button.selected = YES;
    
    [moneyBtn setImage:KImageName(@"botom") forState:UIControlStateNormal];
    [timeBtn setImage:KImageName(@"botom") forState:UIControlStateNormal];
    
  
    defaultBtn.titleLabel.font = defaultBtn.selected?KFont(16):KFont(14);
    moneyBtn.titleLabel.font = moneyBtn.selected?KFont(16):KFont(14);
    timeBtn.titleLabel.font = timeBtn.selected?KFont(16):KFont(14);

    
    if(button == defaultBtn)
    {
        sortType = HotSortType;
      
    }
    else if(button == moneyBtn)
    {
        
        timeBtn.tag = TimeNormalState;
        if(button.tag == MoneyNormalState)//从普通状态进入向下状态
        {
            [button setImage:KImageName(@"botom") forState:UIControlStateNormal];
            sortType = MoneyDownSortType;
            button.tag = MoneyDownState;
        }
        else if (button.tag == MoneyDownState)//从向下状态进入向上状态
        {
            [button setImage:KImageName(@"top") forState:UIControlStateNormal];
            sortType = MoneyUpSortType;
            button.tag = MoneyUpState;
        }
        else//从向上状态进入向下状态
        {
            [button setImage:KImageName(@"botom") forState:UIControlStateNormal];
            sortType = MoneyDownSortType;
            button.tag = MoneyDownState;
        }
        
    }
    else if (button == timeBtn)
    {
        moneyBtn.tag = MoneyNormalState;
        if(button.tag == TimeNormalState)//从普通状态进入向下状态
        {
            [button setImage:KImageName(@"botom") forState:UIControlStateNormal];
            sortType = TimeDownSortType;
            button.tag = TimeDownState;
        }
        else if (button.tag == TimeDownState)//从向下状态进入向上状态
        {
            [button setImage:KImageName(@"top") forState:UIControlStateNormal];
            sortType = TimeUpSortType;
            button.tag = TimeUpState;
        }
        else//从向上状态进入向下状态
        {
            [button setImage:KImageName(@"botom") forState:UIControlStateNormal];
            sortType = TimeDownSortType;
            button.tag = TimeDownState;
        }
        
        
    }
    
    self.currpage = 1;
    [self loadData:NO];
    
}

#pragma mark - 失信排序按钮点击
-(void)loseCreditBtnClick:(UIButton *)button
{
    for(int i = 0;i<3;i++)
    {
        UIButton *button = [self.view viewWithTag:LoseCreditBtnTag + 1 + i];
        button.selected = NO;
    }
    button.selected = YES;
    loseCreditType = button.tag - LoseCreditBtnTag;
    
    self.currpage = 1;
    [self loadData:NO];
}
#pragma mark - 筛选选择
- (void)didSelectFilterView:(NSArray *)selectArray{
    NSMutableDictionary *selectDic = [NSMutableDictionary dictionaryWithCapacity:1];
    for(FilterCellModel *model  in selectArray){
        if([model.type isEqualToString:@"1" ])//是城市时传名字
        {
            [selectDic setObject:model.name forKey:model.key];
        }else{
            [selectDic setObject:model.value forKey:model.key];
        }
    }
    chooseDic = [NSMutableDictionary dictionaryWithDictionary:selectDic];
    self.currpage = 1;
    [self.companyAllArr removeAllObjects];
    [self loadData:NO];
    
}


-(void)endRefresh{
    [self.companySearchTableView.mj_header endRefreshing];
    [self.companySearchTableView.mj_footer endRefreshing];
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
    __weak typeof(self) weakSelf = self;
    
    if (SortHistory.length == 0) {
        SortHistory  = @"2";
    }
    self.companySearchTableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currpage  = 1;
        [weakSelf loadData:NO];
    }];
    // 1.下拉刷新(进入刷新状态就会调用self的footerRereshing)
    self.companySearchTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData:NO];
    }];
    // [self.CompanySearchTableView.mj_footer endRefreshingWithNoMoreData];
    // self.companySearchTableView.mj_footer.automaticallyHidden = YES;
}



-(void)back{
    
    [self.filterView removeFromSuperview];
    self.filterView = nil;
    
    if(self.popType)
    {
        [self popViewControllerWithType:self.popType];
        return;
    }
    
    NSArray * ctrlArray = self.navigationController.viewControllers;
    
    if(self.isFromNoData)
    {
        [self.navigationController popToViewController:[ctrlArray objectAtIndex: ctrlArray.count>3?ctrlArray.count - 3:0] animated:YES];
    }
    else
    {
        
        [self.navigationController popToViewController:[ctrlArray objectAtIndex:0] animated:YES];
    }
}

-(void)popViewControllerWithType:(PopType)type
{
    NSArray * ctrlArray = self.navigationController.viewControllers;
    if(type == PopThird)
    {
        [self.navigationController popToViewController:[ctrlArray objectAtIndex: ctrlArray.count>3?ctrlArray.count - 3:0] animated:YES];
    }
    else if(type == PopTop)
    {
        
        [self.navigationController popToViewController:[ctrlArray objectAtIndex:0] animated:YES];
    }
    else if(type == PopNormal)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - lazy load

- (NSMutableDictionary *)exportModels{
    if (!_exportModels) {
        _exportModels = [NSMutableDictionary dictionary];
    }
    return _exportModels;
}

-(UIView *)searchView{
    if (_searchView == nil) {
        _searchView = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, KDeviceW - 20, 44)];
        _searchView.backgroundColor = [UIColor clearColor];
    }
    return _searchView;
}

-(UISearchBar *)companySearchBaBar{
    
    if (_companySearchBaBar == nil) {
        
        _companySearchBaBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, (44-28)/2, _searchView.frame.size.width - 105,  28)];
        [[_companySearchBaBar.subviews[0] subviews][0] removeFromSuperview];
        _companySearchBaBar.searchBarStyle         = UISearchBarStyleProminent;
        _companySearchBaBar.layer.masksToBounds    = YES;
        //    companySearchBar.layer.cornerRadius     = 15;
        _companySearchBaBar.backgroundImage        = nil;
        _companySearchBaBar.backgroundColor        = [UIColor clearColor];
        _companySearchBaBar.delegate               = self;
        _companySearchBaBar.placeholder            = @"请输入关键字";
        
        UITextField *searchTextField = [_companySearchBaBar valueForKey:@"_searchField"];
        
        searchTextField.font = KFont(14);
      
        
        [searchTextField setValue:KFont(14) forKeyPath:@"_placeholderLabel.font"];
        //searchTextField.clearButtonMode = UITextFieldViewModeNever;
        
        clearBtn = [searchTextField valueForKey:@"_clearButton"];
        [clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _companySearchBaBar.backgroundImage = nil;
        _companySearchBaBar.backgroundColor = [UIColor whiteColor];
        _companySearchBaBar.delegate = self;
        _companySearchBaBar.text = _btnTitile;
        _companySearchBaBar.layer.cornerRadius = 14.f;
        _companySearchBaBar.layer.masksToBounds = YES;
        _companySearchBaBar.layer.borderColor = KHexRGB(0xc8c8c8).CGColor;
        _companySearchBaBar.layer.borderWidth = 1.f;
        
        [_companySearchBaBar setImage:[UIImage imageNamed:@"home_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        
    }
    return _companySearchBaBar;
}


-(UITableView *)companySearchTableView{
    
    if (_companySearchTableView == nil) {
        _companySearchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KNavigationBarHeight+_sortBarH+_tipsBarH, KDeviceW, KDeviceH-(KNavigationBarHeight+_sortBarH+_tipsBarH)) style:UITableViewStyleGrouped ];
        _companySearchTableView.backgroundColor = [UIColor whiteColor];
        _companySearchTableView.delegate = self;
        _companySearchTableView.dataSource = self;
        _companySearchTableView.separatorStyle =self.searchType == SearchCrackcreditType? :UITableViewCellSeparatorStyleNone;
        _companySearchTableView.estimatedRowHeight = 200;//设置太小，导致reload时候，cell向下tiao dong
        _companySearchTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _companySearchTableView;
}

- (FilterView *)filterView{
    if (!_filterView) {
        _filterView = [[FilterView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH) isSX:self.searchType == SearchCrackcreditType];
        _filterView.delegate = self;
    }
    return _filterView;
}

-(NSMutableArray *)companyAllArr{
    if (_companyAllArr == nil) {
        _companyAllArr = [[NSMutableArray alloc]init];
    }
    return _companyAllArr;
}

- (void)dealloc{
    [_filterView removeFromSuperview];
    _filterView = nil;
}



#pragma mark - 检查报告会员类型
//股东穿透权限查询
- (void)checkPenetrationVipType{
//    [MBProgressHUD showMessag:@"" toView:self.view];
//    NSString *str = [NSString stringWithFormat:@"%@?userId=%@",KGetShareholerVipType,KUSER.userId] ;
//    [RequestManager QXBGetWithURLString:str parameters:nil success:^(id responseObject) {
//        NSLog(@"responseObject_______%@",responseObject);
//        [MBProgressHUD hideHudToView:self.view animated:YES];
//        if([[responseObject objectForKey:@"result"]intValue] == 0){
//            [self exportCompanyReport:responseObject[@"data"][@"type"]];//test
//        }else{
//            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"请求失败" toView:self.view];
//    }];
}

//企业报告权限查询
- (void)checkReportWithModel:(SearchBaseModel *)model forPreview:(BOOL)forPreview{
//    [MBProgressHUD showMessag:@"" toView:self.view];
//    NSString *str = [[NSString stringWithFormat:@"%@?entId=%@&userid=%@&entName=%@",KGetReportLink,model.companyid,KUSER.userId,model.companyname] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [RequestManager QXBGetWithURLString:str parameters:nil success:^(id responseObject) {
//        [MBProgressHUD hideHudToView:self.view animated:YES];
//        if([[responseObject objectForKey:@"result"]intValue] == 0){
//
//            if (forPreview) {//预览报告
//                [self previewReportWithModel:model data:responseObject[@"data"]];
//            }else{//导出报告
//                [self exportCompanyReport:responseObject[@"data"][@"vipType"]];
//            }
//        }else{
//            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
//        }
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"请求失败" toView:self.view];
//    }];
}
//290
//预览企业报告 30+30+100+100+100 +50+50+50+50
- (void)previewReportWithModel:(SearchBaseModel *)model data:(NSDictionary *)data{
    ReportController *vc = [[ReportController alloc]init];
    vc.url = [NSString stringWithFormat:@"%@&version=%@&apptype=1",data[@"reportUrl"],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] ;
    vc.vipType = data[@"vipType"];
    vc.companyId = model.companyid;
    vc.companyName = model.companyname;//test传类型
    [self.navigationController pushViewController:vc animated:YES];
}

//导出报告，导出股东穿透详情
- (void)exportCompanyReport:(NSString *)vipType{
    if (vipType.intValue == 1) {
        KWeakSelf
        CustomAlert *alert = [[CustomAlert alloc]initWithTitle:@"发送至" style:1 placeholder:@"请输入报告接收邮箱" cancelButtonTitle:@"取消" otherButtonTitle:@"发送" callBack:^(NSString *text) {
            [weakSelf sendReportWithEmail:text];
        }];
        [alert showInView:self.view];
    }else{//test 股东穿透web，企业报告web
//        VIPPrivilegeController *vc = [VIPPrivilegeController new];
//        vc.vipType = _searchType == PenetrationType?ShareholderPenetrationType:ReportType;
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

//发送报告（企业报告，股东穿透报告）
- (void)sendReportWithEmail:(NSString *)mail{
    
//    if (![Verification validateEmail:mail]) {
//        [MBProgressHUD showError:@"请输入正确的邮箱！" toView:nil];
//        return;
//    }
//    [KUserDefaults setObject:mail forKey:ReportEmailKey];//邮箱保存在本地
//
//    NSMutableString *idStr = [NSMutableString string];
//    NSArray *eids = [self.exportModels allKeys];
//    for (NSString *eid in eids) {
//        [idStr appendString:eid];
//        if (eid!=[eids lastObject]) {
//            [idStr appendString:@","];
//        }
//    }
//
//    NSString *method = _searchType == PenetrationType?KExportShareholer:KExportReports;
//    NSString *url = [NSString stringWithFormat:@"%@?userId=%@&entId=%@&email=%@",method,KUSER.userId,idStr,mail];
//    [MBProgressHUD showMessag:@"" toView:self.view];
//
//    [RequestManager QXBPostWithURLString:url parameters:nil success:^(id responseObject) {
//
//
//        if([[responseObject objectForKey:@"result"] intValue] == 0){
//            [MBProgressHUD showSuccess:@"导出成功！" toView:self.view];
//        }else{
//            [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
//        }
//    } failure:^(NSError *error) {
//
//        [MBProgressHUD hideHudToView:self.view animated:YES];
//    }];
}

#pragma mark - 请求数据的select状态赋值
- (void)setSelectState:(NSArray *)tempArr{
    
    for (int i= 0; i < tempArr.count; i++) {
        SearchBaseModel *model = tempArr[i];
        if (_allSelected) {
            if (self.exportModels.allValues.count >= KReportExportNum && _searchType != SearchAddressBookType) {//选中已达最大数量，则无需设置
                break;
            }
            SearchBaseModel *model = tempArr[i];
            model.selected = YES;
            [self.exportModels setObject:model forKey:model.companyid];
        }else{
            SearchBaseModel *exportModel = _exportModels[model.companyid];
            if (exportModel) {
                model.selected = exportModel.selected;
            }
        }
    }
    _reportExportBar.exportNum = self.exportModels.allValues.count;
}


#pragma mark - AddressBookExpandDelegate 展开 选中
- (void)cellExpandAction{
    [self.companySearchTableView reloadData];
}

- (void)cellSelectedWithModel:(AddressBookModel *)model{
    if (!model) {
        return;
    }
    if (model.selected) {
        [self.exportModels setObject:model forKey:model.companyid];
        
    }else{
        [self.exportModels removeObjectForKey:model.companyid];
    }
    
    if (self.exportModels.count == KReportExportNum && _searchType != SearchAddressBookType) {
        self.allSelected = YES;
    }else if (self.exportModels.count == self.companyAllArr.count){
        self.allSelected = YES;
    }else{
        self.allSelected = NO;
    }
    [self changeAllSelectBtnState];
    
    _reportExportBar.exportNum = self.exportModels.allValues.count;

}

//点击单个cell，改变全选按钮的选中状态
- (void)changeAllSelectBtnState{
    
    if (_searchType == SearchAddressBookType||_searchType == SearchSeekRelationType) {
        _exportBar.selectAllBtn.selected = _allSelected;
    }else{
        _reportExportBar.selectAllBtn.selected = _allSelected;
    }
}

//查看更多、预览
- (void)cellPreviewAction:(SearchBaseModel *)exportModel{
    if (KUSER.userId.length) {
        if (_searchType == SearchAddressBookType) {//通讯录预览（查看更多）
//            DownContactController *vc = [[DownContactController alloc]init];
//            vc.modelArray =@[(AddressBookModel *)exportModel] ;//AddressBookModel
//            [self.navigationController pushViewController:vc animated:YES];
        }else if (_searchType == SearchSeekRelationType){//股东穿透预览
            NSLog(@"股东穿透预览");
        }else{//企业报告预览
            [self checkReportWithModel:exportModel forPreview:YES];//获取权限
        }
    }else{
//        LoginController *vc = [LoginController new];
//        vc.loginSuccessBlock = ^{};
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - ExportBarDelegate 导出
//全选
- (void)exportBarSelectAllAction:(BOOL)selected{
    if (selected) {
        for (int i = 0; i < self.companyAllArr.count; i++) {
            if (self.exportModels.allValues.count == KReportExportNum && _searchType != SearchAddressBookType) {//加载更多的新数据为add，老数据的状态保存不变
                break;
            }
            SearchBaseModel *model = _companyAllArr[i];
            model.selected = YES;
            [self.exportModels setObject:model forKey:model.companyid];
        }
    }else{
        [self.companyAllArr enumerateObjectsUsingBlock:^(SearchBaseModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            model.selected = NO;
        }];
        [self.exportModels removeAllObjects];
    }
    _allSelected = selected;
    _showCheckbox = selected;
    [self.companySearchTableView reloadData];
    
    _reportExportBar.exportNum = self.exportModels.allValues.count;
}
//导出按钮
- (void)exportBarExportAction{
    
    if (!_exportModels.allValues.count) {
        [MBProgressHUD showHint:@"请选择需要导出的企业！" toView:self.view];
        return;
    }
    if (KUSER.userId.length) {
        if (_searchType == SearchAddressBookType) {
//            DownContactController *vc = [[DownContactController alloc]init];
//            vc.modelArray = [_exportModels allValues].copy;//AddressBookModel
//            [self.navigationController pushViewController:vc animated:YES];
        }
//        else if (_searchType == PenetrationType){//查看股东穿透权限
//            [self checkPenetrationVipType];
//        }
        else{//导出企业报告 test
            SearchBaseModel *model = [_exportModels allValues][0];//取第一个model就行
            [self checkReportWithModel:model forPreview:NO];
            //判断是否为付费  1、是的话弹邮箱  2、不是的话去vip特权页
        }
    }else{
    
//        LoginController *vc = [LoginController new];
//        vc.loginSuccessBlock = ^{};
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//按注册日期排序
- (void)sortByDate:(BOOL)selected{
    sortType = selected ? TimeUpSortType:TimeDownSortType;
    _currpage = 1;
    [self loadData:NO];
}



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar fs_setBackgroundColor:KNavigationBarRedColor];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

