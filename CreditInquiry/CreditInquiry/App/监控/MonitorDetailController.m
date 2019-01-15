//
//  MonitorDetailController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorDetailController.h"
#import "MonitorDetailCell.h"
#import "MonitorDetailHeader.h"
#import "MonitorMoreController.h"
#import "MonitorFilterView.h"
#import "MDSectionModel.h"

static NSString *CellID = @"MonitorDetailCell";
static NSString *HeadID = @"MonitorDetailHeader";


@interface MonitorDetailController ()<UITableViewDelegate,UITableViewDataSource,MonitorDetailHeaderDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) MonitorFilterView *filterView;
@property (nonatomic ,strong) NSArray *datalist;
@end

@implementation MonitorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"动态详情" andTextColor:[UIColor whiteColor]];
    [self setBackBtn:nil];
    [self setRightNaviButton];
    
    [self initView];
    [self loadData];
}

#pragma mark - loadData
- (void)loadData{
    return;
    [MBProgressHUD showMessag:@"" toView:nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@"userId"];
    [params setObject:@"" forKey:@"companyid"];
    [params setObject:@"" forKey:@"companyName"];
    [params setObject:@"" forKey:@"filterId"];
    
    [RequestManager postWithURLString:nil parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            self.datalist = [MDSectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            [_tableview reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(KNavigationBarHeight);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
        view.delegate = self;
        view.dataSource = self;
        view.rowHeight = UITableViewAutomaticDimension;
        view.estimatedRowHeight = 90;
        view;
    });
    
    [_tableview registerClass:[MonitorDetailCell class] forCellReuseIdentifier:CellID];
    [_tableview registerClass:[MonitorDetailHeader class] forHeaderFooterViewReuseIdentifier:HeadID];
}

- (void)setRightNaviButton{
    UIButton *button = [[UIButton alloc]initWithFrame:KFrame(0, 0, 35, 40)];
    button.titleLabel.font = KFont(15);
    [button setImage:KImageName(@"shaixuan") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [barView addSubview:button];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 53;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MonitorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MonitorDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
    header.section = section;
    header.delegate = self;
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 筛选
- (void)rightAction{
    [self.filterView showChooseView];
}

- (void)didClickMoreButton:(NSInteger)section{
    MonitorMoreController *vc = [MonitorMoreController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy load
- (MonitorFilterView *)filterView{
    if (!_filterView) {
        _filterView = [[MonitorFilterView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH)];
        _filterView.dataArray = @[@"裁判文书",@"被执行人",@"开庭公告",@"法院公告",@"失信信息",@"动产抵押",@"欠税信息",@"非正常户",@"税务重大违法",@"司法拍卖",@"股权出质",@"经营异常",@"行政处罚",@"股权冻结",@"司法协助",@"立案信息",@"商标信息",@"专利信息",@"作品著作权",@"软件著作权",@"资质认证",@"工商变更",@"域名信息",@"新闻舆情"];
    }
    return _filterView;
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar fs_setBackgroundColor:KHexRGB(0xd51424)];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


@end
