//
//  CreditReportController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditReportController.h"
#import "CreditReportCell.h"
#import "CreditProReportCell.h"
#import "CreditReportHeader.h"
#import "ConfirmOrderController.h"
#import "ReportPreviewController.h"
#import "MyOrderController.h"
#import "ShowMessageView.h"
#import "BuyVipController.h"
#import "UITableView+NoData.h"
#import "NewCommonWebController.h"
#import "CreditReportController.h"

static NSString *CellID = @"CreditReportCell";
static NSString *ProCellID = @"CreditProReportCell";

@interface CreditReportController ()<UITableViewDataSource,UITableViewDelegate,CreditReportCellDelegate>
@property (nonatomic ,strong) UITableView *tableview;
//@property (nonatomic ,strong) CreditReportHeader *header;
@property (nonatomic ,strong) NSDictionary *reportInfo;
@end

@implementation CreditReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"信用报告"];//test企业名
    [self setBlankBackButton];
    [self setRightNaviButton];
    
    [self initView];
    [self loadData];
}

#pragma mark - loadData
- (void)loadData{
    
    [self showLoadDataAnimation];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_companyName forKey:@"companyname"];

    [RequestManager postWithURLString:KGetCreditReportList parameters:params success:^(id responseObject) {
        [self hideLoadDataAnimation];
        
        if ([responseObject[@"result"] intValue] == 0) {
            _reportInfo = responseObject[@"data"];
            [_tableview nd_reloadData];
            [self updateUserInfo];//更新用户状态
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:_tableview.frame];
    }];
}

- (void)updateUserInfo{
    if (_reportInfo[@"isVIP"]) {
        KUSER.vipStatus = _reportInfo[@"isVIP"];
    }
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:view];
        view.delegate = self;
        view.dataSource = self;
        view.rowHeight = UITableViewAutomaticDimension;
        view.estimatedRowHeight = 220;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
//        view.tableHeaderView = self.header;
        view;
    });
    [_tableview registerClass:[CreditReportCell class] forCellReuseIdentifier:CellID];
    [_tableview registerClass:[CreditProReportCell class] forCellReuseIdentifier:ProCellID];
}

- (void)setRightNaviButton{
    UIButton *button = [[UIButton alloc]initWithFrame:KFrame(0, 0, 65, 40)];
    button.titleLabel.font = KFont(15);
    [button setTitle:@"我的订单" forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [barView addSubview:button];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _reportInfo?2:0;
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
    if (indexPath.section ==0) {
        CreditReportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.reportInfo = _reportInfo;
        return cell;
    }else{
        CreditProReportCell *cell = [tableView dequeueReusableCellWithIdentifier:ProCellID forIndexPath:indexPath];
        cell.reportInfo = _reportInfo;
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - 我的订单
- (void)rightAction{
    MyOrderController *vc = [MyOrderController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 预览 获取报告
- (void)didClickSendReportButton:(int)cellType{
    
    if (cellType == 0 ) {//基础报告
        ConfirmOrderController *vc = [ConfirmOrderController new];
        vc.price = _reportInfo[@"basicVersionDownloadAmount"];
        vc.reportType = 1;
        vc.companyName = _companyName;
        vc.companyId = _companyid;
        [self.navigationController pushViewController:vc animated:YES];
    }else{//专业报告
        if (KUSER.vipStatus.intValue == 1) {
            ConfirmOrderController *vc = [ConfirmOrderController new];
            vc.price = _reportInfo[@"professionVersionDownloadAmount"];
            vc.reportType =2;
            vc.companyName = _companyName;
            vc.companyId = _companyid;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            KWeakSelf
            [[ShowMessageView alloc]initWithType:ShowMessageVIPType action:^{
                BuyVipController *vc = [BuyVipController new];
                vc.target = weakSelf;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
        }
    }
}

- (void)didClickPreviewButton:(int)cellType{
    NSString *url = cellType== 0?_reportInfo[@"basicVersionSamplePreview"]:_reportInfo[@"professionVersionSamplePreview"];

    ReportPreviewController *vc = [ReportPreviewController new];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 重新加载
- (void)abnormalViewReload{
    [self loadData];
}

//#pragma mark - lazy load
//- (CreditReportHeader *)header{
//    if (!_header) {
//        _header = [[CreditReportHeader alloc]initWithFrame:KFrame(0, 0, KDeviceW, 35)];
//    }
//    return _header;
//}

@end
