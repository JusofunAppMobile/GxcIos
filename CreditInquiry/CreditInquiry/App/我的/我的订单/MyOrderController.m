//
//  MyOrderController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyOrderController.h"
#import "MyOrderReportCell.h"

static NSString *CellID1 = @"MyOrderReportCell";

@interface MyOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;
@end

@implementation MyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"我的订单"];
    [self setBlankBackButton];

    [self initView];
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
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderReportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID1 forIndexPath:indexPath];
    cell.type = indexPath.section;
    return cell;
}



@end
