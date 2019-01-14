//
//  ObjectionAppealController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ObjectionAppealController.h"
#import "ObjectionInfoCell.h"
#import "ObjectionEntCell.h"
#import "ObjectionTypeCell.h"
#import "ObjectionFooterView.h"

static NSString *CellID1 = @"ObjectionEntCell";
static NSString *CellID2 = @"ObjectionTypeCell";
static NSString *CellID3 = @"ObjectionInfoCell";

@interface ObjectionAppealController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) ObjectionFooterView *footer;
@end

@implementation ObjectionAppealController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"信用异议"];
    [self setBlankBackButton];
    
    [self initView];
}

- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:view];
        view.delegate = self;
        view.dataSource = self;
        view.estimatedRowHeight = 90;
        view.rowHeight = UITableViewAutomaticDimension;
        view.tableFooterView = self.footer;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view;
    });
    [_tableview registerClass:[ObjectionEntCell class] forCellReuseIdentifier:CellID1];
    [_tableview registerClass:[ObjectionTypeCell class] forCellReuseIdentifier:CellID2];
    [_tableview registerClass:[ObjectionInfoCell class] forCellReuseIdentifier:CellID3];
}

#pragma mark - initView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ObjectionEntCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID1 forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 1){
        ObjectionTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID2 forIndexPath:indexPath];
        cell.titles = @[@"企业背景",@"风险信息",@"经营信息",@"分支结构",@"对外投资",@"企业变更",@"清算信息"];
        return cell;
    }else{
        NSArray *titles = @[@"基本信息",@"股东信息",@"主要成员",@"分支结构",@"对外投资",@"企业变更",@"清算信息",@"企业年报",@"行政许可",@"企业图谱",@"大事纪"];
        ObjectionInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID3 forIndexPath:indexPath];
        [cell setTitles:titles type:0];
        return cell;
    }
}

#pragma mark -lazy load
- (ObjectionFooterView *)footer{
    if (!_footer) {
        _footer = [[ObjectionFooterView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 120)];
    }
    return _footer;
}


@end
