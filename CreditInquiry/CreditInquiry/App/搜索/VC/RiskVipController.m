//
//  RiskVipController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "RiskVipController.h"

@interface RiskVipController ()

@end

@implementation RiskVipController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"企业风险分析"];
    [self setBlankBackButton];
    
    [self drawView];
    
}

-(void)openVIP
{
    RiskAnalyzeController *vc = [RiskAnalyzeController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)drawView
{
  
    UILabel *label = [[UILabel alloc]init];
    label.textColor = KRGB(153, 153, 153);
    label.font = KFont(16);
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"对企业及关联企业全方位风险监控\n可实时或定时推送至邮箱、手机";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight+45);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIImageView *bgView = [UIImageView new];
    bgView.image = KImageName(@"riskVip");
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(label.mas_bottom).offset(30);
    }];
    

    UIButton *bigBtn = [[UIButton alloc]init];
    [bigBtn setTitle:@"开通VIP" forState:UIControlStateNormal];
    [bigBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bigBtn.backgroundColor = KRGB(238, 37, 32);
    bigBtn.titleLabel.font = KFont(16);
    bigBtn.layer.cornerRadius = 5;
    bigBtn.clipsToBounds = YES;
    [bigBtn addTarget:self action:@selector(openVIP) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bigBtn];
    
    [bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(bgView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
}






@end
