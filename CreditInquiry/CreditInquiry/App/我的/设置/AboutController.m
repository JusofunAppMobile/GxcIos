//
//  AboutController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/16.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()
{
    UITableView *backTableView;
}

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KHexRGB(0xF5F5F5);
    
    [self setNavigationBarTitle:@"关于我们"];
    [self setBlankBackButton];
    
    [self drawTableView];
    
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideterfir ];
    }
    
    
    NSArray *array = @[@"地址：北京市海淀区中关村东升国际创业园6号楼",@"邮编：100089",@"邮箱：ztgx@sic-credit.cn",@"官网：http://sic-credit.cn"];
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW,300/1334.0*KDeviceH )];
    
    
    UIImageView*imageView = [UIImageView new];
    imageView.image = KImageName(@"logo");
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.centerY.mas_equalTo(backView).offset(-15);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.font = KFont(14);
    label.text = [NSString stringWithFormat:@"版本号：%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    label.textColor = KHexRGB(0x666666);
    label.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView);
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
    }];
    
    return backView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 300/1334.0*KDeviceH;
}

-(void)drawTableView
{

    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.font = KFont(14);
    label.textColor = KHexRGB(0x666666);
    label.text = @"版本由中投国信（北京）科技发展有限公司提供";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    backTableView.backgroundColor = [UIColor clearColor];
    backTableView.delegate = self;
    backTableView.dataSource = self;
    backTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    backTableView.estimatedRowHeight = 50;
    backTableView.showsVerticalScrollIndicator = NO;
    backTableView.rowHeight  = UITableViewAutomaticDimension;
    backTableView.estimatedSectionHeaderHeight = 0;
    backTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:backTableView];
    [backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(label.mas_top);
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
