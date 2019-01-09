//
//  SettingViewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingPlainCell.h"
#import "SettingAvatarCell.h"

static NSString *CellID1 = @"SettingAvatarCell";
static NSString *CellID2 = @"SettingPlainCell";

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"个人设置"];
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
        view.rowHeight = UITableViewAutomaticDimension;
        view.estimatedRowHeight = 52;
        view;
    });
    [_tableview registerClass:[SettingAvatarCell class] forCellReuseIdentifier:CellID1];
    [_tableview registerClass:[SettingPlainCell class] forCellReuseIdentifier:CellID2];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&indexPath.row == 0) {
        SettingAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID1 forIndexPath:indexPath];
        return cell;
    }else{
        SettingPlainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID2 forIndexPath:indexPath];
        return cell;
    }
}


@end
