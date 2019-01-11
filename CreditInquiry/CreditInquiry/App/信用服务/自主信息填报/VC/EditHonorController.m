//
//  EditHonorController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "EditHonorController.h"
#import "CreditEditLabelCell.h"
#import "CreditEditTextCell.h"
#import "CreditEditImageCell.h"

static NSString *LabelCellID = @"CreditEditLabelCell";
static NSString *ImageCellID = @"CreditEditImageCell";
static NSString *TextCellID = @"CreditEditTextCell";

@interface EditHonorController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UITableView *tableview;
@end

@implementation EditHonorController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"企业产品"];
    [self setBlankBackButton];
    [self setRightNaviButton];
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
        view.estimatedRowHeight = 50;
        view;
    });
    [_tableview registerClass:[CreditEditLabelCell class] forCellReuseIdentifier:LabelCellID];
    [_tableview registerClass:[CreditEditImageCell class] forCellReuseIdentifier:ImageCellID];
    [_tableview registerClass:[CreditEditTextCell class] forCellReuseIdentifier:TextCellID];
    
}

- (void)setRightNaviButton{
    _rightBtn = [[UIButton alloc]initWithFrame:KFrame(0, 0, 35, 40)];
    _rightBtn.titleLabel.font = KFont(15);
    [_rightBtn setTitle:@"完成" forState: UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [barView addSubview:_rightBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CreditEditLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:LabelCellID forIndexPath:indexPath];
            return cell;
        }else{
            CreditEditImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCellID forIndexPath:indexPath];
            return cell;
        }
    }else{
        CreditEditTextCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellID forIndexPath:indexPath];
        return cell;
    }
}

- (void)rightAction{
    NSLog(@"完成");
}
@end
