//
//  MyOrderController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyOrderController.h"
#import "MyOrderReportCell.h"
#import "MyOrderModel.h"
#import "UITableView+NoData.h"

static NSString *CellID1 = @"MyOrderReportCell";

@interface MyOrderController ()<UITableViewDelegate,UITableViewDataSource,MyOrderReportCellDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) NSMutableArray *datalist;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic ,assign) BOOL moreData;
@property (nonatomic ,assign) NSInteger remainTime;//test作用？
@end

@implementation MyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"我的订单"];
    [self setBlankBackButton];

    _page = 1;
    [self initView];
    [self loadData:YES];
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];;
        [self.view addSubview:view];
        view.delegate = self;
        view.dataSource = self;
        view.estimatedRowHeight = 210;
        view.rowHeight = UITableViewAutomaticDimension;
        view;
    });
    [_tableview registerClass:[MyOrderReportCell class] forCellReuseIdentifier:CellID1];
    
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

#pragma mark - loadData
- (void)loadData:(BOOL)loading{
    if (loading) {
        [self showLoadDataAnimation];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@"1" forKey:@"type"];
    [params setObject:@(_page) forKey:@"pageIndex"];
    [params setObject:@(10) forKey:@"pageSize"];

    [RequestManager postWithURLString:KMyOrderList parameters:params success:^(id responseObject) {
        [self hideLoadDataAnimation];
        [self endRefresh];
        if ([responseObject[@"result"] intValue] == 0) {
            if (_page == 1) {
                [_datalist removeAllObjects];
            }
            self.remainTime = [responseObject[@"data"][@"remainTime"] intValue];
            [self.datalist addObjectsFromArray: [MyOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]]];
            [_tableview nd_reloadData];
            _page++;
            _moreData = _datalist.count< [responseObject[@"data"][@"totalCount"] intValue];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:_tableview.frame];
        [self endRefresh];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datalist.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderReportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID1 forIndexPath:indexPath];
    cell.model = _datalist[indexPath.section];
    cell.delegate = self;
    return cell;
}

#pragma mark - MyOrderReportCellDelegate
- (void)didClickSendReportButton:(MyOrderModel *)model{//重新发送
    
}

- (void)didClickCheckReportButton:(MyOrderModel *)model{
    
}

#pragma mark - 网络异常
- (void)abnormalViewReload{
    [self loadData:YES];
}

#pragma mark - lazy load
- (NSMutableArray *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}


@end
