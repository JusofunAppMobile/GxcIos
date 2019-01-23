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
#import "UITableView+NoData.h"

static NSString *CellID = @"MonitorDetailCell";
static NSString *HeadID = @"MonitorDetailHeader";


@interface MonitorDetailController ()<UITableViewDelegate,UITableViewDataSource,MonitorDetailHeaderDelegate,MonitorViewDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) MonitorFilterView *filterView;
@property (nonatomic ,strong) NSArray *datalist;
@property (nonatomic ,copy) NSString *filterIdStr;

@end

@implementation MonitorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"动态详情" andTextColor:[UIColor whiteColor]];
    self.filterIdStr = @"";
    [self setBackBtn:nil];
    [self setRightNaviButton];
    
    [self initView];
    [self loadData];
    [self loadFilterData:NO];
}

#pragma mark - loadData
- (void)loadData{
    
    [self showLoadDataAnimation];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:self.companyId forKey:@"companyid"];
    [params setObject:self.companyName forKey:@"companyName"];
    [params setObject:self.filterIdStr forKey:@"filterId"];
    [RequestManager postWithURLString:KDynamicDetail parameters:params success:^(id responseObject) {
        [self hideLoadDataAnimation];
        if ([responseObject[@"result"] intValue] == 0) {
            self.datalist = [MDSectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"details"]];
            [_tableview nd_reloadData];
        }
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:_tableview.frame];
    }];
}

- (void)loadFilterData:(BOOL)loading{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    if (loading) {
        [MBProgressHUD showMessag:@"" toView:self.view];
    }
    [RequestManager postWithURLString:KDynamicFilter parameters:params success:^(id responseObject) {
        if (loading) {
            [MBProgressHUD hideHudToView:self.view animated:YES];
        }
        
        if ([responseObject[@"result"] intValue] == 0) {
           
            NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"filter"];
            self.filterView.dataArray = array;
            if(loading)
            {
                 [self.filterView showChooseView];
            }
        }
        else
        {
            if (loading) {
                [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
            }
        }
    } failure:^(NSError *error) {
        if (loading) {
            [MBProgressHUD hideHudToView:self.view animated:YES];
        }
    }];
}



#pragma mark - 筛选
- (void)rightAction{
   if(self.filterView.dataArray.count == 0)
    {
        [self loadFilterData:YES];
    }
    else
    {
        [self.filterView showChooseView];
    }
}

-(void)didSelectFilterView:(NSMutableArray *)selectArray//test单选还是多选
{
    for(NSDictionary*dic in selectArray)
    {
        NSString *idStr = [dic objectForKey:@"monitor_condition_id"];
       
        self.filterIdStr = [NSString stringWithFormat:@"%@,%@",self.filterIdStr,idStr];
    }
    
    [self loadData];
}


- (void)didClickMoreButton:(MDSectionModel *)model{
//    MonitorMoreController *vc = [MonitorMoreController new];
//    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datalist.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   MDSectionModel *model = [self.datalist objectAtIndex:section];
    
    return model.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 53;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MonitorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    MDSectionModel *model = [self.datalist objectAtIndex:indexPath.section];
    MonitorDetailModel *detailModel = [model.data objectAtIndex:indexPath.row];
    cell.model = detailModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MonitorDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
    header.model = [self.datalist objectAtIndex:section];
    header.delegate = self;
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//test点击跳转吗
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark - 网络异常
- (void)abnormalViewReload{
    [self loadData];
}

#pragma mark - lazy load
- (MonitorFilterView *)filterView{
    if (!_filterView) {
        _filterView = [[MonitorFilterView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH)];
        _filterView.delegate = self;
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
