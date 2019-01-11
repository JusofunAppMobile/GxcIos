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
#import "MonitorDynamicCell.h"

static NSString *CELLID = @"MonitorDynamicCell";

@interface MonitorViewController ()<UITableViewDelegate,UITableViewDataSource,MonitorTableHeaderDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) MonitorTableHeader *tableHeader;
@property (nonatomic ,strong) MonitorFilterView *filterView;
@end

@implementation MonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

#pragma mark - initView
- (void)initView{
    
//    MonitorHeaderView *monitorHeader = [[MonitorHeaderView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, 48)];
//    [self.view addSubview:monitorHeader];
    
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
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MonitorDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    return cell;
}

#pragma mark - 筛选
- (void)didClickFilterButton{
    NSLog(@"筛选");
    [self.filterView showChooseView];
}

#pragma mark - lazy load
- (MonitorTableHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[MonitorTableHeader alloc]initWithFrame:KFrame(0, 0, KDeviceW, 47)];
        _tableHeader.delegate = self;
    }
    return _tableHeader;
}

- (MonitorFilterView *)filterView{
    if (!_filterView) {
        _filterView = [[MonitorFilterView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH)];
        _filterView.dataArray = @[@"裁判文书",@"被执行人",@"开庭公告",@"法院公告",@"失信信息",@"动产抵押",@"欠税信息",@"非正常户",@"税务重大违法",@"司法拍卖",@"股权出质",@"经营异常",@"行政处罚",@"股权冻结",@"司法协助",@"立案信息",@"商标信息",@"专利信息",@"作品著作权",@"软件著作权",@"资质认证",@"工商变更",@"域名信息",@"新闻舆情"];
    }
    return _filterView;
}

@end
