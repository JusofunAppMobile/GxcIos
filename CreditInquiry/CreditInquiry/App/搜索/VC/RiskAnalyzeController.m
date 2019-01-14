//
//  RiskAnalyzeController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "RiskAnalyzeController.h"

@interface RiskAnalyzeController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *backScrollView;
    UITableView *tableView1;
    UITableView *tableView2;
    NSMutableArray *dataArray;
    
    UILabel *nameLabel;
    
    UIButton *ownBtn;
    UIButton *relateBtn;
    UIImageView *lineImageView;
    
}
@end

@implementation RiskAnalyzeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"企业风险分析"];
    [self setBlankBackButton];
    [self drawTableView];
}


-(void)loadData
{
   
    KWeakSelf;
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
   // [paraDic setObject:self.companyId forKey:@"companyid"];
    //[paraDic setObject:self.companyName forKey:@"companyname"];
    
    [RequestManager QXBGetWithURLString:KGetGuQuan parameters:paraDic success:^(id responseObject) {
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


-(void)change:(UIButton*)button
{
    ownBtn.selected = NO;
    relateBtn.selected = NO;
    button.selected = YES;
    
    [lineImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(button.mas_bottom).offset(4);
        make.centerX.mas_equalTo(button.mas_centerX);
    }];
    
    [backScrollView setContentOffset:CGPointMake(button==ownBtn?0:KDeviceW, 0) animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    RiskDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        cell = [[RiskDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.dataDic = @{};
   // NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    
//    cell.numLabel.text = [dic objectForKey:@"registrationNo"];
//    cell.chuZhiLabel.text = [dic objectForKey:@"pledgor"];
//    cell.zhiQuanLabel.text = [dic objectForKey:@"pledgee"];
    
    return cell;
}


-(void)drawTableView
{

    nameLabel = [UILabel new];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = KFont(14);
    nameLabel.text = @"北京小米科技有限责任公司成立于2010年3月3日，是一家专注于智能硬件和电子产品研发的移动互联网公司";
    nameLabel.numberOfLines = 0;
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(85);
        make.top.mas_equalTo(15+KNavigationBarHeight);
        make.right.mas_equalTo(self.view).offset(-15);
        
    }];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = KImageName(@"icon_vip");
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(nameLabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(nameLabel);
        
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = KRGB(227, 227, 227);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(15);
        make.left.width.mas_equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    
    NSArray *array = @[@"自身风险",@"关联风险"];
    for(int i= 0;i<array.count;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = KFont(14);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:KRGB(102, 102, 102) forState:UIControlStateNormal];
        [button setTitleColor:KRGB(241, 0, 21) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        if(i == 0)
        {
            ownBtn = button;
            button.selected = YES;
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView.mas_bottom).offset(10);
                make.left.mas_equalTo(self.view);
                make.height.mas_equalTo(32);
                make.width.mas_equalTo(KDeviceW/2);
            }];
        }
        else
        {
            relateBtn = button;
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView.mas_bottom).offset(10);
                make.left.mas_equalTo(ownBtn.mas_right);
                make.height.mas_equalTo(32);
                make.width.mas_equalTo(KDeviceW/2);
            }];
        }
    }
    
    lineImageView = [[UIImageView alloc]init];
    lineImageView.image = KImageName(@"hengRed");
    [self.view addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(relateBtn.mas_bottom).offset(4);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(ownBtn);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = KRGB(227, 227, 227);
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(relateBtn.mas_bottom).offset(5);;
        make.left.width.mas_equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *kongView = [[UIView alloc]init];
    kongView.backgroundColor = KRGB(240, 242, 245);
    [self.view addSubview:kongView];
    [kongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(lineView2.mas_bottom);
    }];
    
    backScrollView = [UIScrollView new];
    [self.view addSubview:backScrollView];
    backScrollView.contentSize = CGSizeMake(KDeviceW*2, 0);
    backScrollView.scrollEnabled = NO;
    backScrollView.pagingEnabled = YES;
    [backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kongView.mas_bottom);
        make.left.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    
    
    tableView1 = [[UITableView alloc]initWithFrame:CGRectZero];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView1.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView1.estimatedRowHeight = 135;
    tableView1.rowHeight  = UITableViewAutomaticDimension;
    tableView1.estimatedSectionHeaderHeight = 0;
    tableView1.estimatedSectionFooterHeight = 0;
    [backScrollView addSubview:tableView1];
    [tableView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(KDeviceW);
        make.height.mas_equalTo(backScrollView);
    }];
    
    tableView2 = [[UITableView alloc]init];
    tableView2.delegate = self;
    tableView2.dataSource = self;
    tableView2.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView2.estimatedRowHeight = 135;
    tableView2.rowHeight  = UITableViewAutomaticDimension;
    tableView2.estimatedSectionHeaderHeight = 0;
    tableView2.estimatedSectionFooterHeight = 0;
    [backScrollView addSubview:tableView2];
    [tableView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(KDeviceW);
        make.width.mas_equalTo(KDeviceW);
        make.height.mas_equalTo(backScrollView);
    }];
    
}


@end
