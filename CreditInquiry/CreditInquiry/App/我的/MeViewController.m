//
//  MeViewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/3.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MeViewController.h"
#import "MeInfoCell.h"
#import "MeItemCell.h"
#import "MePlainCell.h"
#import "MyOrderController.h"
#import "MyMonitorListController.h"
#import "SettingViewController.h"
#import "PersonalSettingController.h"
#import "FogotPwdController.h"
#import "LoginController.h"
#import "ComCertificationController.h"

static NSString *InfoID = @"MeInfoCell";
static NSString *ItemID = @"MeItemCell";
static NSString *PlainID = @"MePlainCell";

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,MeItemCellDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
#pragma mark - initView
- (void)initView{
    self.view.backgroundColor = KHexRGB(0xecedf2);
    
    UIImageView *redBg = [UIImageView new];
    redBg.image = KImageName(@"mine_topbg");
    [self.view addSubview:redBg];
    [redBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view);//test高度
        make.height.mas_equalTo((444.f/750)*KDeviceW);
    }];
    
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(-KTabBarHeight);
        }];
        view.backgroundColor = [UIColor clearColor];
        view.delegate = self;
        view.dataSource = self;
        view;
    });
    [_tableview registerClass:[MeInfoCell class] forCellReuseIdentifier:InfoID];
    [_tableview registerClass:[MeItemCell class] forCellReuseIdentifier:ItemID];
    [_tableview registerClass:[MePlainCell class] forCellReuseIdentifier:PlainID];
}

#pragma mark - initView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 45;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 95;
    }else if (indexPath.section == 1){
        return 154;
    }else{
        return 54;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoID forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        MeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemID forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else{
        MePlainCell *cell = [tableView dequeueReusableCellWithIdentifier:PlainID forIndexPath:indexPath];
        cell.row = indexPath.row;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (KUSER.userId.length) {
            PersonalSettingController *vc = [PersonalSettingController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            LoginController *vc = [LoginController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 3) {
            SettingViewController *vc = [SettingViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 0) {
            
            
            BrowseController *vc = [BrowseController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            FogotPwdController *vc = [FogotPwdController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cornerRadius = 8.0;
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    UIBezierPath *bezierPath = nil;
    if (indexPath.row == 0 && numberOfRows == 1) {//一个为一组时,四个角都为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else if (indexPath.row == 0) {//为组的第一行时,左上、右上角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else if (indexPath.row == numberOfRows - 1) {//为组的最后一行,左下、右下角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else {
        //中间的都为矩形
        bezierPath = [UIBezierPath bezierPathWithRect:cell.bounds];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor clearColor].CGColor;
    [cell.layer insertSublayer:layer atIndex:0];
}

//plain下 header默认为灰色，此处需要设置为透明
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - MeItemCellDelegate
- (void)didClickItemAtIndex:(NSInteger)index{
    if (index == 0) {
        MyOrderController *vc = [MyOrderController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index ==1||index==2){
        MyMonitorListController *vc = [MyMonitorListController new];
        vc.listType = index ==1? ListTypeMyMonitor:ListTypeMyCollection;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 3){
        ComCertificationController *vc = [ComCertificationController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (index == 5)
    {
       BuyVipController*vc = [BuyVipController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
