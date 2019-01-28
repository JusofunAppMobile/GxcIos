//
//  CreditInfoInputController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditInfoInputController.h"
#import "CreditInfoInputCell.h"
#import "CreditInfoInputHeader.h"
#import "EditCompanyInfoController.h"
#import "EditProductController.h"
#import "EditHonorController.h"
#import "EditPartnerController.h"
#import "EditMemberController.h"



static NSString *CellID = @"CreditInfoInputCell";

@interface CreditInfoInputController ()<UITableViewDelegate,UITableViewDataSource,CreditInfoIuputCellDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) CreditInfoInputHeader *tableHeader;
@end

@implementation CreditInfoInputController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"自主信息填报"];
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
        view.tableHeaderView = self.tableHeader;
        view;
    });
    [_tableview registerClass:[CreditInfoInputCell class] forCellReuseIdentifier:CellID];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CreditInfoInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.section = indexPath.section;
    return cell;
}


#pragma mark -
- (void)didClickEditButton:(NSInteger)section{
    if (section == 0) {
        EditCompanyInfoController *vc = [EditCompanyInfoController new];
        vc.companyName = @"";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (section == 1){
        EditProductController *vc = [EditProductController new];
        vc.companyName = @"";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (section == 2){
        EditHonorController *vc = [EditHonorController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (section == 3){
        EditPartnerController *vc = [EditPartnerController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        EditMemberController *vc = [EditMemberController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - lazy load
- (CreditInfoInputHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[CreditInfoInputHeader alloc]initWithFrame:KFrame(0, 0, KDeviceW, 103)];
    }
    return _tableHeader;
}

@end
