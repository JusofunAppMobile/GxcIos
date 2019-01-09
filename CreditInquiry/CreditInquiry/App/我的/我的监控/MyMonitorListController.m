//
//  MyMonitorListController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyMonitorListController.h"
#import "MyMonitorCell.h"

static NSString *CellID = @"MyMonitorCell";

@interface MyMonitorListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) UIView *header;
@property (nonatomic ,strong) UILabel *numLab;
@end

@implementation MyMonitorListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"我的监控"];
    [self setBackBtn:nil];
    
    [self initView];
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];;
        [self.view addSubview:view];
        view.delegate = self;
        view.dataSource = self;
        view.tableHeaderView = self.header;
        view;
    });
    [_tableview registerClass:[MyMonitorCell class] forCellReuseIdentifier:CellID];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
        _numLab.attributedText = [self getAttibuteForText:@"数量：2条"];
    }
    return _header;
}

- (NSAttributedString *)getAttibuteForText:(NSString *)str{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xe00018) range:NSMakeRange(3, str.length-4)];
    return attr;
}

@end
