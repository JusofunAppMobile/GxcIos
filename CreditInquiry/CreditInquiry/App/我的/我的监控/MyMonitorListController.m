//
//  MyMonitorListController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyMonitorListController.h"
#import "MyMonitorCell.h"
#import "MyMonitorListModel.h"

static NSString *CellID = @"MyMonitorCell";

@interface MyMonitorListController ()<UITableViewDelegate,UITableViewDataSource,MyMonitorCellDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) UIView *header;
@property (nonatomic ,strong) UILabel *numLab;
@property (nonatomic ,strong) NSMutableArray *datalist;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic ,assign) BOOL moreData;
@end

@implementation MyMonitorListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:_listType == ListTypeMyMonitor? @"我的监控":@"我的收藏"];
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
        view.tableHeaderView = self.header;
        view.rowHeight = 60;
        view;
    });
    [_tableview registerClass:[MyMonitorCell class] forCellReuseIdentifier:CellID];
    
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
        [MBProgressHUD showMessag:@"" toView:self.view];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@(_page) forKey:@"pageIndex"];
    [params setObject:@(20) forKey:@"pageSize"];

    NSString *urlStr = _listType == ListTypeMyMonitor?KMyMonitorList:KMyCollectionList;
    
    [RequestManager postWithURLString:urlStr parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            if (_page == 1) {
                [_datalist removeAllObjects];
            }
            NSArray *arr =[MyMonitorListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [self.datalist addObjectsFromArray: arr];
            [_tableview reloadData];
            _numLab.attributedText = [self getAttibuteForText:[NSString stringWithFormat:@"数量：%li条",_datalist.count]];//更新条数
            _page++;
            _moreData = arr.count >= 20;
            [self endRefresh];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
        [self endRefresh];
    }];
    
}

#pragma mark -
- (void)didClickMonitorButton:(MyMonitorListModel *)model cell:(UITableViewCell *)cell{
    MyMonitorCell* cell1 = (MyMonitorCell*)cell;
    
    //（0:取消监控  1：添加监控）
    NSString * type = cell1.monitorBtn.selected?@"0":@"1";
   
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datalist.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMonitorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = _datalist[indexPath.section];
    return cell;
}

#pragma mark - lazy load
- (UIView *)header{
    if (!_header) {
        _header = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 38)];
        
        _numLab = [UILabel new];
        _numLab.font = KFont(12);
        _numLab.textColor = KHexRGB(0x878787);
        [_header addSubview:_numLab];
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_header);
            make.left.mas_equalTo(_header).offset(15);
        }];
        _numLab.attributedText = [self getAttibuteForText:@"数量：0条"];
    }
    return _header;
}

- (NSMutableArray *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (NSAttributedString *)getAttibuteForText:(NSString *)str{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xe00018) range:NSMakeRange(3, str.length-4)];
    return attr;
}



@end
