//
//  ModifyInfoController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ModifyInfoController.h"
#import "ModifyInfoCell.h"

static NSString *CellID = @"ModifyInfoCell";

@interface ModifyInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;

@end

@implementation ModifyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlankBackButton];
    [self setRightNaviButton];
    
    [self initView];
}
#pragma mark - unit
- (void)setTypeStr:(NSString *)typeStr{
    _typeStr = typeStr;
    [self setNavigationBarTitle:[NSString stringWithFormat:@"修改%@",typeStr]];
    [_tableview reloadData];
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:view];
        view.delegate =self;
        view.dataSource = self;
        view.rowHeight = 55;
        view;
    });
    [_tableview registerClass:[ModifyInfoCell class] forCellReuseIdentifier:CellID];
}

- (void)setRightNaviButton{
    UIButton *button = [[UIButton alloc]initWithFrame:KFrame(0, 0, 35, 40)];
    button.titleLabel.font = KFont(15);
    [button setTitle:@"保存" forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [barView addSubview:button];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - UITableViewDataSource
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
    ModifyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.typeStr = _typeStr;
    return cell;
}

#pragma mark -
- (void)rightAction{
    
    
}

@end
