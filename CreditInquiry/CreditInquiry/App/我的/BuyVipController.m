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
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"成为VIP"];
    [self setBlankBackButton];
    [self drawTableView];
}

-(void)loadData
{
    
    KWeakSelf;
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    // [paraDic setObject:self.companyId forKey:@"companyid"];
    //[paraDic setObject:self.companyName forKey:@"companyname"];
    
    [RequestManager getWithURLString:KGetGuQuan parameters:paraDic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showNetFailViewWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight)];
    }];
    
}

-(void)buy
{
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir ];
        
    }
   // cell.index = indexPath.row;
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(0, 0, KDeviceW, 45)];
    label.backgroundColor = KRGB(252, 244, 244);
    label.textColor = KRGB(238, 37, 32);
    label.font = KFont(14);
    label.text = @"     填写身份证信息，快速认证企业";
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
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
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(50);
    }];
    
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setBackgroundColor:KRGB(238, 37, 32)];
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:buyBtn];
    
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(backView);
        make.height.mas_equalTo(backView);
        make.width.mas_equalTo(250/750.0*KDeviceW);
        make.right.mas_equalTo(backView);
        
    }];
    
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.textColor = KRGB(238, 37, 32);
    moneyLabel.font = KFont(16);
    moneyLabel.text = @"¥4353";
    [backView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).offset(5);
        make.right.mas_equalTo(buyBtn.mas_left);
        make.height.mas_equalTo(50);
    }];
    
    
    backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    backTableView.delegate = self;
    backTableView.dataSource = self;
    backTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    backTableView.estimatedRowHeight = 50;
    backTableView.rowHeight  = UITableViewAutomaticDimension;
    backTableView.estimatedSectionHeaderHeight = 0;
    backTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:backTableView];
    [backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(KDeviceW);
        make.bottom.mas_equalTo(backView.mas_top);
    }];
    
}
@end
