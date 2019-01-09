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
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(KDeviceW);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.font = KFont(14);
    label.text = @"实付金额:";
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(backView);
    }];
    
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.font = KFont(14);
    moneyLabel.text = @"实付金额:";
    [backView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(backView);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:KRGB(238, 37, 32)];
    [button setTitle:@"提交认证" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(KDeviceW-30);
        make.left.mas_equalTo(15);
        
    }];
    [button addTarget:self action:@selector(certification) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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
        make.bottom.mas_equalTo(button.mas_top).offset(-10);
    }];
    
}
@end
