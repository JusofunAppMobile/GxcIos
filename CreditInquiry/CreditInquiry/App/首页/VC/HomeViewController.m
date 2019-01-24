//
//  HomeViewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/3.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "VipPrivilegeController.h"
#import "NewCommonWebController.h"

static NSString *HomeSetionHeaderID = @"HomeSectionHeader";
static NSString *MonitorCellID = @"MonitorCellID";
static NSString *NewsCellID = @"NewsCellID";


@interface HomeViewController ()
{
    UIButton *buttonRight;
    NSDictionary *dataDic;
}

@property (nonatomic ,strong) HomeHeaderView *headerView;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLoginObserver];
    
    [self checkUpdate];
    
    [self drawView];
    
    [self loadData];
}

#pragma mark - 网络请求
- (void)loadData{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:KUSER.userId forKey:@"userId"];
    [RequestManager postWithURLString:KGetHomeData parameters:paraDic success:^(id responseObject) {
        if ([responseObject[@"result"] integerValue] == 0) {
            
            dataDic = [responseObject objectForKey:@"data"];
            self.headerView.dataDic = dataDic;
            self.tableview.tableHeaderView = self.headerView;
            [self.tableview reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
        [self endRefreshing];
    }];
    _firstDate = [NSDate date];
}

#pragma mark - 点击搜索框
//跳转搜索界面
- (void)goSearchvc{
    SearchController *SearchVc = [[SearchController alloc]init];
    SearchVc.searchType = SearchBlurryType;
    [self.navigationController pushViewController:SearchVc animated:YES];
}

-(void)joinVIP{
    
    if (KUSER.userId.length) {
        VipPrivilegeController *vc = [VipPrivilegeController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginController *vc = [[LoginController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)adClick:(NSDictionary *)adDic{
    
    NewCommonWebController *vc = [[NewCommonWebController alloc]init];
    vc.urlStr = adDic[@"webURL"];
    vc.webType = [adDic[@"webType"] intValue];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - section 更多
-(void)sectionHeaderMoreBtnClicked:(NSString *)title
{
    if ([title isEqualToString:@"监控动态"])
    {
        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        appDelegate.tabBarController.selectedIndex = 1;
    
    }
    if ([title isEqualToString:@"行业资讯"])
    {
        NewsController *vc = [[NewsController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - 分类搜索
- (void)headerBtnClicked:(CenterButton *)button{
    
    NSDictionary *dic = button.dataDic;
    //1：股东高管 2：主营产品 3：地址电话 4：失信查询 5：查税号 6：招聘 7：企业通讯录 8：查关系(待定) 9：风险分析(待定) -1: h5跳转
    int type = [[dic objectForKey:@"menuType"] intValue];
    if(type == SearchShareholderType)//1：股东高管
    {
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchShareholderType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchOurmainType)//2：主营产品
    {
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchOurmainType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchAddressType)//：地址电话
    {
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchAddressType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchCrackcreditType)//：失信查询
    {
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchCrackcreditType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchTaxCodeType)//：查税号
    {
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchTaxCodeType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchJobType)//：招聘
    {
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchJobType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchAddressBookType)//：企业通讯录
    {
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchAddressBookType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchSeekRelationType)//：查关系(待定)
    {
        SeekRelationController *vc = [SeekRelationController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (type == SearchRiskAnalyzeType)//9：风险分析(待定)
    {
        if (KUSER.vipStatus.intValue == 1) {
            SearchController *searchVc= [SearchController new];
            searchVc.searchType = SearchRiskAnalyzeType;
            [self.navigationController pushViewController:searchVc animated:YES];
        }else{
            RiskVipController *vc = [RiskVipController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
      
    }
    else if (type == SearchBidType){//中标
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchBidType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchJudgementType){//裁判文书
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchJudgementType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchPenaltyType){//行政处罚
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchPenaltyType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == SearchBrandType){//商标查询
        SearchController *searchVc= [SearchController new];
        searchVc.searchType = SearchBrandType;
        [self.navigationController pushViewController:searchVc animated:YES];
    }
    else if (type == -1)//-1: h5跳转
    {
        NewCommonWebController *vc = [NewCommonWebController new];
        vc.urlStr = dic[@"menuUrl"];
        vc.titleStr = dic[@"menuName"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 热词搜索
-(void)hotKeySearch:(NSString *)hotKey
{
    SearchResultController *searchVc = [[SearchResultController alloc]init];
    searchVc.btnTitile = hotKey;
    searchVc.searchType = SearchBlurryType;
    [self.navigationController pushViewController:searchVc animated:YES];
}

-(void)checkUpdate
{
    [[ShowMessageView alloc]initWithType:ShowMessageCheckType action:^{
        NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",KAppleID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        
    }];
}

#pragma mark - 下拉刷新
-(void)endRefreshing{
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval secondsBetweenDates= [nowDate timeIntervalSinceDate:_firstDate];
    CGFloat time = 1.6;
    if(secondsBetweenDates>time){
        [_tableview.mj_header endRefreshing];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time-secondsBetweenDates) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableview.mj_header endRefreshing];
        });
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0)
    {
        NSArray *array = [dataDic objectForKey:@"monitor"];
        return array.count;
    }
    else
    {
       
        NSArray *array = [dataDic objectForKey:@"news"];
        return array.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        HomeMonitorCell *cell = [tableView dequeueReusableCellWithIdentifier:MonitorCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = [dataDic objectForKey:@"monitor"];
        cell.dataDic = [array objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      //  cell.newsType = indexPath.row;
        NSArray *array = [dataDic objectForKey:@"news"];
        cell.dataDic = [array objectAtIndex:indexPath.row];
        return cell;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array = @[@"监控动态",@"行业资讯"];
    HomeSectionHeader *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HomeSetionHeaderID];
    sectionHeader.titleLabel.text = array[section];
    sectionHeader.delegate = self;
    return sectionHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 1)
    {
        NSArray *array = [dataDic objectForKey:@"news"];
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        CommonWebViewController *vc = [[CommonWebViewController alloc]init];
        vc.urlStr = [dic objectForKey:@"newsURL"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 0)
    {
        NSArray *array = [dataDic objectForKey:@"monitor"];
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        MonitorDetailController *vc = [MonitorDetailController new];
        vc.companyName = [dic objectForKey:@"companyName"];
        vc.companyId = [dic objectForKey:@"companyId"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat maxWidth = KDeviceW-40;//搜索栏宽度
    CGFloat minWidth = _naviSearchView.width;
    CGFloat widthDelta = maxWidth - minWidth;
    
    CGRect orginBounds = self.headerView.searchBtnView.bounds;
    if (offsetY > 0) {
        //透明度
        CGFloat alpha = offsetY /(HomeBannerHeight - KNavigationBarHeight);
        alpha = MIN(alpha, 1);
        //宽度变化
        CGFloat scrollDistance = offsetY;
        CGFloat currentWidth = maxWidth - widthDelta*alpha;
        if (scrollDistance > 0) {//向上滑动
            orginBounds.size.width = MAX(currentWidth, minWidth);
        }else{//向下滑动
            orginBounds.size.width = MIN(currentWidth,maxWidth);//搜索栏正常宽度
        }
        self.headerView.searchBtnView.bounds = orginBounds;
        
        [self setNaviBarWithAlpha:alpha];//设置导航栏透明度
        
    }else
    {
        [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)setNaviBarWithAlpha:(CGFloat)alpha{
    
    if (alpha ==  1) {
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        self.naviSearchView.hidden = NO;
        self.headerView.searchBtnView.hidden = YES;
        
    }else{
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
        self.naviSearchView.hidden = YES;
        self.headerView.searchBtnView.hidden = NO;
    }
    
    buttonRight.alpha = 1- alpha;
    
    [self.navigationController.navigationBar fs_setBackgroundColor:[KNavigationBarRedColor colorWithAlphaComponent:alpha]];
}



#pragma mark - initView
- (void)drawView{
    
    [self drawRightBarButton];
    
    self.navigationItem.titleView = self.naviSearchView;
    
    CGFloat scrolly = 0;//Masonry布局导致控制器直接跳到个人中心页面
//        if(@available(iOS 11.0, *)){
//            scrolly = - KNavigationBarHeight;
//        }
    
    
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:CGRectMake(0, scrolly, KDeviceW, KDeviceH- KTabBarHeight-scrolly)];
        [self.view addSubview:view];
        
        view.tableHeaderView = self.headerView;
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.estimatedRowHeight = 118;
        view.rowHeight  = UITableViewAutomaticDimension;
        view.backgroundColor = [UIColor clearColor];
        view.showsVerticalScrollIndicator = NO;
        view;
    });
    
    [_tableview registerClass:[HomeSectionHeader class] forHeaderFooterViewReuseIdentifier:HomeSetionHeaderID];
    [_tableview registerClass:[NewsCell class] forCellReuseIdentifier: NewsCellID];
    [_tableview registerClass:[HomeMonitorCell class] forCellReuseIdentifier: MonitorCellID];
    
    
    //下拉刷新背景
    UIImageView *gifRefreshBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, scrolly, KDeviceW, KDeviceH-KTabBarHeight)];
    gifRefreshBg.backgroundColor = KNavigationBarRedColor;
    //gifRefreshBg.image = KImageName(@"index_topbg");
    [self.view insertSubview:gifRefreshBg atIndex:0];
    
//    KWeakSelf
//    _tableview.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [weakSelf loadData];
//    }];
}




#pragma mark - lazy load
- (HomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, KDeviceW, HomeHeadHeight)];
        _headerView.delegate = self;
        [_headerView.searchBtnView addTarget:self action:@selector(goSearchvc) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}



//导航栏搜索框
- (SearchButton *)naviSearchView{
    if (!_naviSearchView) {
        _naviSearchView = [[SearchButton alloc] initWithFrame:CGRectMake(15, 0,  KDeviceW -30 , 30) andPlaceText:KSearchPlaceholder ] ;
        _naviSearchView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        _naviSearchView.layer.cornerRadius = 15;
        _naviSearchView.hidden = YES;
        [_naviSearchView addTarget:self action:@selector(goSearchvc) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviSearchView;
}

- (void)drawRightBarButton{
    buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRight setTitle:@" 加入VIP >" forState:UIControlStateNormal];
    buttonRight.frame = CGRectMake(KDeviceW - 105, 0, 90, 40);
    [buttonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonRight.titleLabel.font = KFont(14);
    [buttonRight setImage:KImageName(@"icon_vip") forState:UIControlStateNormal];
    [buttonRight addTarget:self action:@selector(joinVIP) forControlEvents:UIControlEventTouchUpInside];
  
    [self.navigationController.navigationBar addSubview:buttonRight];

}

#pragma mark - 通知
- (void)addLoginObserver{
    [KNotificationCenter addObserver:self selector:@selector(reloadAction) name:KLoginSuccess object:nil];
    [KNotificationCenter addObserver:self selector:@selector(reloadAction) name:KLoginOut object:nil];
}

- (void)reloadAction{
    [self loadData];
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_tableview.contentOffset.y>0) {//复位导航栏样式
        CGFloat alpha = _tableview.contentOffset.y /(HomeBannerHeight - KNavigationBarHeight);
        alpha = MIN(alpha, 1);
        [self setNaviBarWithAlpha:alpha];
    }else
    {
        [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.naviSearchView.hidden = YES;
    buttonRight.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    buttonRight.hidden = NO;
    if(@available(iOS 11.0, *))
    {
        if (_tableview.contentOffset.y>0) {//复位导航栏样式
            CGFloat alpha = _tableview.contentOffset.y /(HomeBannerHeight - KNavigationBarHeight);
            alpha = MIN(alpha, 1);
            [self setNaviBarWithAlpha:alpha];
        }
        else
        {
            [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
        }
    }
}

- (void)dealloc{
    [KNotificationCenter removeObserver:self];
}


@end
