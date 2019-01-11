//
//  BuyVipController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BuyVipController.h"

@implementation BuyVipController
{
    
    UITableView *backTableView;
    
    NSMutableArray *dataArray;
    
    NSInteger chooseIndex;
    
    UILabel *moneyLabel;
    UIButton *buyBtn;
    
    NSInteger chooseRow1;
    NSInteger chooseRow2;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawRightBarButton];
    
    [self setNavigationBarTitle:@"成为VIP"];
    [self setBlankBackButton];
    [self drawTableView];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1];
}

-(void)loadData
{
    [backTableView reloadData];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:backTableView didSelectRowAtIndexPath:indexPath1];
    
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:1];
    [self tableView:backTableView didSelectRowAtIndexPath:indexPath2];
}

-(void)buy
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chooseRow1  inSection:0];
    BuyVipCell *cell = [backTableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@%@元",chooseRow2==0?@"支付宝":@"微信支付",cell.curPriceLabel.text.length>2?[cell.curPriceLabel.text substringFromIndex:1]:@"");
}

-(void)VIPIntroduce
{
    
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        chooseRow1 = indexPath.row;
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0  inSection:0];
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:1  inSection:0];
        NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:2  inSection:0];
        BuyVipCell *cell1 = [tableView cellForRowAtIndexPath:indexPath1];
        BuyVipCell *cell2 = [tableView cellForRowAtIndexPath:indexPath2];
        BuyVipCell *cell3 = [tableView cellForRowAtIndexPath:indexPath3];
        BuyVipCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell1.choose = NO;
        cell2.choose = NO;
        cell3.choose = NO;
        cell.choose = YES;
        
        moneyLabel.text = cell.curPriceLabel.text;
        
    }
    else
    {
        chooseRow2 = indexPath.row;
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0  inSection:1];
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:1  inSection:1];
        
        BuyVipCell *cell1 = [tableView cellForRowAtIndexPath:indexPath1];
        BuyVipCell *cell2 = [tableView cellForRowAtIndexPath:indexPath2];
        
        BuyVipCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell1.choose = NO;
        cell2.choose = NO;
        
        cell.choose = YES;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 3;
    }
    else
    {
        return 2;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    BuyVipCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        cell = [[BuyVipCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir section:indexPath.section];
    }
    cell.row = indexPath.row;
    cell.dataDic = @{};
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *backView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 10+45)];;
    backView.backgroundColor = [UIColor whiteColor];
    
    UIView *kongView = [[UIView alloc]init];
    kongView.backgroundColor = KRGB(243, 242, 242);
    [backView addSubview:kongView];
    [kongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(backView);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(15, 10, KDeviceW-30, 45)];
    label.textColor = [UIColor blackColor];
    label.font = KBlodFont(16);
    label.text = section == 0?@"VIP会员":@"支付方式";
    [backView addSubview:label];
    return backView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


-(void)drawTableView
{
    
    UIView*backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50+KBottomHeight);
        make.width.mas_equalTo(KDeviceW);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.font = KFont(14);
    label.text = @"实付金额:";
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(50);
    }];
    
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setBackgroundColor:KHexRGB(0xEA1F19)];
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:buyBtn];
    
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(250/750.0*KDeviceW);
        make.right.mas_equalTo(backView);
        
    }];
    
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.textColor = KRGB(238, 37, 32);
    moneyLabel.font = KFont(18);
    moneyLabel.text = @"";
    [backView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(label.mas_right).offset(5);
        make.right.mas_equalTo(buyBtn.mas_left);
        make.height.mas_equalTo(50);
    }];
    [moneyLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

    
    backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    backTableView.delegate = self;
    backTableView.dataSource = self;
    backTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    backTableView.estimatedRowHeight = 50;
    backTableView.rowHeight  = UITableViewAutomaticDimension;
    backTableView.estimatedSectionHeaderHeight = 0;
    backTableView.estimatedSectionFooterHeight = 0;
    backTableView.tableHeaderView = [self tableHeadView];
    [self.view addSubview:backTableView];
    [backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(KDeviceW);
        make.bottom.mas_equalTo(backView.mas_top);
    }];
    
}

-(UIView*)tableHeadView
{
    
    UIView *backView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 10+15+50+15)];;
    backView.backgroundColor = [UIColor whiteColor];
    
    UIView *kongView = [[UIView alloc]init];
    kongView.backgroundColor = KRGB(243, 242, 242);
    [backView addSubview:kongView];
    [kongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(backView);
        make.height.mas_equalTo(10);
    }];
    
    UIImageView *headImageView = [[UIImageView alloc]init];
    headImageView.image = KImageName(@"me_head_h");
    headImageView.clipsToBounds = YES;
    headImageView.layer.cornerRadius = 25;
    [backView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(kongView.mas_bottom).offset(15);
        make.height.width.mas_equalTo(50);
        //make.bottom.mas_equalTo(backView.mas_bottom).offset(-15);
    }];
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = KFont(16);
    nameLabel.text = @"13744811567";
    [backView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kongView.mas_bottom).offset(20);
        make.left.mas_equalTo(headImageView.mas_right).offset(10);
        make.right.mas_equalTo(backView).offset(-15).priorityHigh();
        make.height.mas_equalTo(15);
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.textColor = KRGB(153, 153, 153);
    label2.font = KFont(14);
    label2.text = [NSString stringWithFormat:@"VIP剩余天数：%d天",90];
    [backView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(headImageView.mas_right).offset(10);
        make.right.mas_equalTo(nameLabel);
        make.height.mas_equalTo(15);
    }];
    
    return backView;
    
}


- (void)drawRightBarButton{
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60+10, 40)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.titleLabel.font = KFont(16);
    [button setTitle:@"VIP介绍" forState:UIControlStateNormal];
    [button setTitleColor:KRGB(51, 51, 51) forState:UIControlStateNormal];
    //[self.errorBtn setImage:KImageName(@"纠错") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(VIPIntroduce) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:button];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barView];
    
}



@end
