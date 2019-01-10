//
//  HomeViewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/3.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "HomeViewController.h"


static NSString *HomeSetionHeaderID = @"HomeSectionHeader";
static NSString *MonitorCellID = @"MonitorCellID";
static NSString *NewsCellID = @"NewsCellID";


@interface HomeViewController ()
{
    UIButton *buttonRight;
}

@property (nonatomic ,strong) HomeHeaderView *headerView;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self drawView];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.2];
    
}




#pragma mark - 网络请求
- (void)loadData{
    
   
    _firstDate = [NSDate date];
    
    [self.headerView reloadData];
    self.tableview.tableHeaderView = self.headerView;
   
}

#pragma mark - 点击搜索框
//跳转搜索界面
- (void)goSearchvc{
    
    //[MobClick event:@"Home01"];//首页－名称搜索框点击数,0
    //[[BaiduMobStat defaultStat] logEvent:@"Home01" eventLabel:@"首页－名称搜索框点击数"];
    SearchController *SearchVc = [[SearchController alloc]init];
    SearchVc.searchType = BlurryType;
    [self.navigationController pushViewController:SearchVc animated:YES];
}

-(void)joinVIP
{
    BuyVipController*vc = [[BuyVipController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - section 更多
-(void)sectionHeaderMoreBtnClicked:(NSString *)title
{
    if ([title isEqualToString:@"监控动态"]) {
    
        
    }
    if ([title isEqualToString:@"行业资讯"]) {
    
    }
    
}

#pragma mark - 分类搜索
- (void)headerBtnClicked:(UIButton *)button{
    
    SearchController *searchVc= [[SearchController alloc]init];
    switch (button.tag) {
            //        case 100:{
            //
            //            return;
            //            NSLog(@"附近公司");
            //            NearController *vc = [NearController new];
            //            [self.navigationController pushViewController:vc animated:YES];
            //        }
                        break;
        case 100:
            
            //[MobClick event:@"Home03"];//首页－股东高管点击数
            //[[BaiduMobStat defaultStat] logEvent:@"Home03" eventLabel:@"首页－股东高管点击数"];
            NSLog(@"股东高管");
            searchVc.searchType = ShareholderType;
            [self.navigationController pushViewController:searchVc animated:YES];
            break;
        case 101:
            
            NSLog(@"主营产品");
            //[MobClick event:@"Home02"];//首页－主营产品点击数
            //[[BaiduMobStat defaultStat] logEvent:@"Home02" eventLabel:@"首页－主营产品点击数"];
            
            searchVc.searchType = OurmainType;
            [self.navigationController pushViewController:searchVc animated:YES];
            break;
        case 102:
            
            
            //return;
            
            NSLog(@"地址电话");
            //[MobClick event:@"Home04"];//首页－地址电话点击数
            //[[BaiduMobStat defaultStat] logEvent:@"Home04" eventLabel:@"首页－地址电话点击数"];
            
            searchVc.searchType = AddressType;
            [self.navigationController pushViewController:searchVc animated:YES];
            break;
        case 103:
            NSLog(@"失信查询");
            
            //[MobClick event:@"Home06"];//首页－失信查询点击数
            //[[BaiduMobStat defaultStat] logEvent:@"Home06" eventLabel:@"首页－失信查询点击数"];
            searchVc.searchType = CrackcreditType;
            [self.navigationController pushViewController:searchVc animated:YES];
            break;
        case 104:
            
            searchVc.searchType = TaxCodeType;
            [self.navigationController pushViewController:searchVc animated:YES];
            break;
        case 105:
            
            searchVc.searchType = JobType;
            [self.navigationController pushViewController:searchVc animated:YES];
            break;
        case 106:
            NSLog(@"企业通讯录");
            searchVc.searchType = AddressBookType;
            [self.navigationController pushViewController:searchVc animated:YES];
            break;
        case 107:
            NSLog(@"股东穿透");
            searchVc.searchType = PenetrationType;//test
            [self.navigationController pushViewController:searchVc animated:YES];
            
            break;
        case 108:
            //查关系
        {
            SeekRelationController *vc = [SeekRelationController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 109:
           //风险分析
            
        {
            RiskVipController *vc = [RiskVipController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
//            searchVc.searchType = RiskAnalyze;//test
//            [self.navigationController pushViewController:searchVc animated:YES];
//
//            break;
       
        default:
            break;
    }
    
    
    
}

#pragma mark 热词搜索
-(void)hotKeySearch:(NSString *)hotKey
{
    SearchResultController *searchVc = [[SearchResultController alloc]init];
    searchVc.btnTitile = hotKey;
    searchVc.searchType = BlurryType;
    [self.navigationController pushViewController:searchVc animated:YES];
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
   
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)
    {
        HomeMonitorCell *cell = [tableView dequeueReusableCellWithIdentifier:MonitorCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.newsType = indexPath.row;
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
    UIImageView *gifRefreshBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, scrolly, KDeviceW, self.headerView.height)];
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
    buttonRight.frame = CGRectMake(KDeviceW - 95, 0, 80, 40);
    [buttonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonRight.titleLabel.font = KFont(14);
    [buttonRight setImage:KImageName(@"icon_vip") forState:UIControlStateNormal];
    [buttonRight addTarget:self action:@selector(joinVIP) forControlEvents:UIControlEventTouchUpInside];
  
    [self.navigationController.navigationBar addSubview:buttonRight];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
