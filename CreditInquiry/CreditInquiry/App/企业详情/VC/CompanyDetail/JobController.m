//
//  JobController.m
//  EnterpriseInquiry
//
//  Created by WangZhipeng on 17/9/8.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import "JobController.h"
#import "UITableView+NoData.h"

@interface JobController ()
{
    UITableView *backTableView;
    int pageIndex;
    NSMutableArray *dataArray;
}

@end

@implementation JobController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawTableView];
   
}


-(void)loadData:(BOOL)loading
{
    if (loading) {
        [self showLoadDataAnimation];
    }
    KWeakSelf;
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:self.companyId forKey:@"companyid"];
    [paraDic setObject:self.companyName forKey:@"companyname"];
    [paraDic setObject:KUSER.userId forKey:@"userid"];
    [paraDic setObject:self.companyName forKey:@"entname"];
    [paraDic setObject:@"20" forKey:@"pageSize"];
    [paraDic setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [RequestManager QXBGetWithURLString:KGetJob parameters:paraDic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [weakSelf endRefresh];
        [weakSelf hideLoadDataAnimation];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            
            if(pageIndex == 1)
            {
                dataArray = [NSMutableArray arrayWithCapacity:1];
            }
            [dataArray addObjectsFromArray:[responseObject objectForKey:@"dataResult"]];
            [backTableView nd_reloadData];
            if(dataArray.count >= [[responseObject objectForKey:@"totalCount"] intValue])
            {
                [backTableView.mj_footer endRefreshingWithNoMoreData];
            }
            pageIndex ++;
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        if (loading) {
            [weakSelf showNetFailViewWithFrame:backTableView.frame];
        }
        [weakSelf endRefresh];
    }];
}

- (void)abnormalViewReload{
    [self loadData:YES];
}

-(void)endRefresh
{
    [backTableView.mj_header endRefreshing];
    [backTableView.mj_footer endRefreshing];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    
    CommonWebViewController *commomwevView = [[CommonWebViewController alloc] init];
    commomwevView.titleStr = [dic objectForKey:@"job"];;
    commomwevView.urlStr = [dic objectForKey:@"url"];
    commomwevView.dataDic = dic;
    [self.navigationController pushViewController:commomwevView animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        cell = [[JobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [dic objectForKey:@"job"];
    cell.areaLabel.text = [dic objectForKey:@"workPlace"];
    cell.timeLabel.text = [dic objectForKey:@"createTime"];
    cell.moneyLabel.text = [dic objectForKey:@"salary"];
    cell.experienceLabel.text = [dic objectForKey:@"jobExperience"];
    cell.educationLabel.text = [dic objectForKey:@"lowEducationBackgroud"];
    return cell;
}


-(void)drawTableView
{
    backTableView = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStylePlain];
    backTableView.delegate = self;
    backTableView.dataSource = self;
    backTableView.rowHeight = 140;
    backTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    backTableView.estimatedRowHeight = 0;
    backTableView.estimatedSectionHeaderHeight = 0;
    backTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:backTableView];
    
    KWeakSelf;
    backTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageIndex = 1;
        [weakSelf loadData:NO];
    }];
    backTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData:NO];
    }];
    
    pageIndex = 1;
    [self loadData:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
