//
//  MonitorViewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/3.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorViewController.h"
#import "MonitorListModel.h"
#import "MonitorHeaderView.h"
#import "MonitorTableHeader.h"
#import "MonitorFilterView.h"

#import "MonitorDetailController.h"

static NSString *CELLID = @"MonitorDynamicCell";

@interface MonitorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) MonitorTableHeader *tableHeader;
@property (nonatomic ,strong) MonitorFilterView *filterView;
@property (nonatomic ,strong) NSMutableArray *datalist;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic ,assign) BOOL moreData;
@end

@implementation MonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    [self initView];
    [self loadData:YES];
}

#pragma mark - loadData
- (void)loadData:(BOOL)loading{
    if (loading) {
        [self showLoadDataAnimation];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@(_page) forKey:@"pageIndex"];
    [params setObject:@(20) forKey:@"pageSize"];
    [RequestManager postWithURLString:KGetMonitorDynamic parameters:params success:^(id responseObject) {
        [self hideLoadDataAnimation];
        if ([responseObject[@"result"] intValue] == 0) {
            if (_page == 1) {
                [_datalist removeAllObjects];
            }
            [self.datalist addObjectsFromArray: [MonitorListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"monitor"]]];
            [_tableview reloadData];
            _page++;
            _moreData = _datalist.count< [responseObject[@"total"] intValue];
            [self endRefresh];
        }
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:_tableview.frame];
        [self endRefresh];
    }];
}

#pragma mark - 添加监控
-(void)didClickMonitorButton:(MonitorListModel *)model cell:(UITableViewCell*)cell
{
    MonitorDynamicCell* cell1 = (MonitorDynamicCell*)cell;
    
    //（0:取消监控  1：添加监控）
    NSString * type = @"1";
    KBolckSelf;
    if(!cell1.monitorBtn.selected)
    {
        if(KUSER.userId.length>0)
        {
            type = @"1";
        }
        else
        {
            LoginController *view = [[LoginController alloc]init];
            view.loginSuccessBlock = ^{
                [blockSelf didClickMonitorButton:model cell:cell];
            };
            [self.navigationController pushViewController:view animated:YES];
            return;
        }
    }
    else
    {
        if (KUSER.userId.length>0) {
            type = @"0";
        }else
        {
            LoginController *view = [[LoginController alloc]init];
            view.loginSuccessBlock = ^{
                 [blockSelf didClickMonitorButton:model cell:cell];
            };
            [self.navigationController pushViewController:view animated:YES];
            return;
        }
        
    }
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:model.companyId forKey:@"companyid"];
    [paraDic setObject:type forKey:@"monitorType"];
    [paraDic setObject:KUSER.userId forKey:@"userId"];
    [paraDic setObject:model.companyName forKey:@"companyname"];
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSString* urlstr = [KMonitor stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [RequestManager postWithURLString:urlstr parameters:paraDic success:^(id responseObject) {
        
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            [cell1 setMonitorButtonState:!cell1.monitorBtn.selected];
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
        
    }];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MonitorListModel *model = [self.datalist objectAtIndex:indexPath.row];
    MonitorDetailController *vc = [MonitorDetailController new];
    vc.companyName = model.companyName;
    vc.companyId = model.companyId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MonitorDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.delegate = self;
    MonitorListModel *model = [self.datalist objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [UITableView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(KNavigationBarHeight);
            make.bottom.mas_equalTo(self.view).offset(-KTabBarHeight);
            make.left.right.mas_equalTo(self.view);
        }];
        view.delegate = self;
        view.dataSource = self;
        view.rowHeight = 75;
        view.tableHeaderView = self.tableHeader;
        view;
    });
    [_tableview registerClass:[MonitorDynamicCell class] forCellReuseIdentifier:CELLID];
    
    [self addRefreshView];
}

- (void)addRefreshView{
    KWeakSelf
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadData:NO];
    }];
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData:NO];
    }];
}

- (void)endRefresh{
    [_tableview.mj_header endRefreshing];
    if (_moreData) {
        [_tableview.mj_footer endRefreshing];
    }else{
        [_tableview.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - 网络异常
- (void)abnormalViewReload{
    [self loadData:YES];
}
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarTitle:@"监控动态" andTextColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar fs_setBackgroundColor:KHexRGB(0xd91526)];
}

#pragma mark - lazy load
- (MonitorTableHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[MonitorTableHeader alloc]initWithFrame:KFrame(0, 0, KDeviceW, 47)];
    }
    return _tableHeader;
}

- (NSMutableArray *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

@end
