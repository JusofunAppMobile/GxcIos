//
//  NewsController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "NewsController.h"

@interface NewsController ()
{
    UITableView* backTableView;
    int pageIndex;
    SDCycleScrollView *cycleView;
    NSArray *rollNewsArray;
    NSMutableArray *dataArray;
}

@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dataArray = [NSMutableArray array];
    
    
    [self drawTableView];
    
    
}

-(void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@"20" forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"pageIndex"];
    [self showLoadDataAnimation];
    [RequestManager postWithURLString:KIndustryInformation parameters:params  success:^(id responseObject) {
        [self hideLoadDataAnimation];
        [self endRefresh];
        if ([responseObject[@"result"] integerValue] == 0) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            if (pageIndex == 1) {
                [dataArray removeAllObjects];
                dataArray = [NSMutableArray array];
            }
            
            [dataArray addObjectsFromArray:[dataDic objectForKey:@"news"]];
            rollNewsArray = [dataDic objectForKey:@"rollNews"];
            
            [backTableView reloadData];
            
            int count = [[dataDic objectForKey:@"totalCount"] intValue];
            if(dataArray.count>=count)
            {
                [backTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            pageIndex++;
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:backTableView.frame];
        [self endRefresh];
    }];
}


-(void)endRefresh
{
    [backTableView.mj_header endRefreshing];
    [backTableView.mj_footer endRefreshing];
}





-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    if(rollNewsArray.count >index)
    {
        NSDictionary *dic = rollNewsArray[index];
        
        CommonWebViewController *vc = [[CommonWebViewController alloc]init];
        vc.urlStr = [dic objectForKey:@"newsURL"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    CommonWebViewController *vc = [[CommonWebViewController alloc]init];
    vc.urlStr = [dic objectForKey:@"newsURL"];;
    [self.navigationController pushViewController:vc animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.newsType = indexPath.row;
//    NSArray *array = [dataDic objectForKey:@"news"];
    cell.dataDic = [dataArray objectAtIndex:indexPath.row];
    return cell;
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *dic in rollNewsArray)
    {
        [imageArray addObject:[dic objectForKey:@"newsImage"]];
        [titleArray addObject:[dic objectForKey:@"newsName"]];
    }
    
    UIView *view = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceW*165/345.0+10+10)];
    view.backgroundColor = KHexRGB(0xF8F8FA);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceW*165/345.0/2.0)];
    imageView.image = KImageName(@"bg2");
    [view addSubview:imageView];
    
    
    cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(15, 10, KDeviceW-30, KDeviceW*165/345.0) delegate:self placeholderImage:[UIImage imageNamed:@"home_LoadingBanner"]];
    cycleView.delegate = self;
    //cycleView.imageURLStringsGroup = imageUrlArray;
    cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleView.titleLabelBackgroundColor = [UIColor clearColor];
    cycleView.imageURLStringsGroup = imageArray;
    cycleView.titleLabelTextAlignment = NSTextAlignmentCenter;
    cycleView.titlesGroup = titleArray;
    
    [view addSubview:cycleView];
    
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KDeviceW*90/375 + 10;
}


-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(void)drawTableView
{
    backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    backTableView.backgroundColor = [UIColor clearColor];
    backTableView.delegate = self;
    backTableView.dataSource = self;
    backTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    backTableView.estimatedRowHeight = 50;
    backTableView.showsVerticalScrollIndicator = NO;
    backTableView.rowHeight = UITableViewAutomaticDimension;
    backTableView.estimatedSectionHeaderHeight = 0;
    backTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:backTableView];
    [backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    backTableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageIndex = 1;
        [self loadData];
    }];
    [backTableView.mj_header beginRefreshing];
    backTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    
  
}

#pragma mark - 网络异常
- (void)abnormalViewReload{
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar fs_setBackgroundColor:KHexRGB(0xE43433)];
    [self setNavigationBarTitle:@"行业资讯" andTextColor:[UIColor whiteColor]];
    [self setWhiteBackButton];
}


@end
