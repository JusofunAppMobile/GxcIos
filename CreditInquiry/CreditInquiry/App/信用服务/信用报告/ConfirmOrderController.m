//
//  ConfirmOrderController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ConfirmOrderController.h"
#import "MyTextField.h"
@interface ConfirmOrderController ()

@end

@implementation ConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"确认订单"];
    [self setBlankBackButton];
    [self initView];
}

#pragma mark - initView
- (void)initView{
    
    UIImageView *iconBg1 = [UIImageView new];
    iconBg1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:iconBg1];
    [iconBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(KNavigationBarHeight+20);
    }];
    
    UILabel *typeTitle = [UILabel new];
    typeTitle.text = @"报告类型：";
    typeTitle.font = KFont(15);
    typeTitle.textColor = KHexRGB(0x858687);
    [iconBg1 addSubview:typeTitle];
    [typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconBg1).offset(20);
        make.top.mas_equalTo(iconBg1).offset(35);
    }];
    
    UILabel *typeLab = [UILabel new];
    typeLab.text = @"企业信用报告-标准版";
    typeLab.font = KFont(15);
    [iconBg1 addSubview:typeLab];
    [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(typeTitle.mas_right);
        make.top.mas_equalTo(typeTitle);
        make.right.mas_equalTo(iconBg1).offset(-20);
    }];
    
    UILabel *goalTitle = [UILabel new];
    goalTitle.text = @"报告目标：";
    goalTitle.font = KFont(15);
    goalTitle.textColor = KHexRGB(0x858687);
    [iconBg1 addSubview:goalTitle];
    [goalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(typeTitle);
        make.top.mas_equalTo(typeTitle.mas_bottom).offset(21);
    }];
    
    
    UILabel *goalLab = [UILabel new];
    goalLab.text = @"小米科技责任有限公司";
    goalLab.font = KFont(15);
    goalLab.numberOfLines = 0;
    [iconBg1 addSubview:goalLab];
    [goalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goalTitle.mas_right);
        make.top.mas_equalTo(goalTitle);
        make.right.mas_equalTo(iconBg1).offset(-20);
        make.bottom.mas_equalTo(iconBg1.mas_bottom).offset(-12);
    }];
    
    UIImageView *iconBg2 = [UIImageView new];
    iconBg2.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:iconBg2];
    [iconBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(iconBg1);
        make.top.mas_equalTo(iconBg1.mas_bottom);
        make.height.mas_equalTo((20/345)*(KDeviceW-15*2));
    }];
    
    UIImageView *iconBg3 = [UIImageView new];
    iconBg3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:iconBg3];
    [iconBg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(iconBg1);
        make.top.mas_equalTo(iconBg2.mas_bottom);
    }];
    
    MyTextField *textField = [MyTextField new];
    textField.placeholder = @"请输入接收报告的邮箱地址";
    textField.layer.borderWidth = .5f;
    textField.layer.borderColor = KHexRGB(0xe49192).CGColor;
    textField.layer.cornerRadius = 2;
    textField.layer.masksToBounds = YES;
    [iconBg3 addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconBg3).offset(20);
        make.left.mas_equalTo(iconBg3).offset(20);
        make.right.mas_equalTo(iconBg3).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *formatLab = [UILabel new];
    formatLab.text = @"报告格式：";
    formatLab.font = KFont(15);
    formatLab.textColor = KHexRGB(0x858687);
    [iconBg3 addSubview:formatLab];
    [formatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textField);
        make.top.mas_equalTo(textField.mas_bottom).offset(23);
    }];
    
    UIButton *leftBtn = [UIButton new];
    leftBtn.backgroundColor = KHexRGB(0xf1f2f4);
    leftBtn.titleLabel.font = KFont(10);
    leftBtn.layer.cornerRadius = 2;
    [leftBtn setTitle:@"PDF" forState:UIControlStateNormal];
    [iconBg3 addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(formatLab);
        make.top.mas_equalTo(formatLab.mas_bottom).offset(18);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(32);
    }];
    
    UIButton *rightBtn = [UIButton new];
    rightBtn.backgroundColor = KHexRGB(0xffefe9);
    rightBtn.titleLabel.font = KFont(10);
    rightBtn.layer.cornerRadius = 2;
    rightBtn.layer.borderWidth = .5f;
    rightBtn.layer.borderColor = KHexRGB(0xd31023).CGColor;
    rightBtn.layer.masksToBounds = YES;
    [rightBtn setTitle:@"PDF+word" forState:UIControlStateNormal];
    [rightBtn setTitleColor:KHexRGB(0xd41124) forState:UIControlStateNormal];
    [iconBg3 addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(formatLab);
        make.top.mas_equalTo(formatLab.mas_bottom).offset(18);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(32);
        make.bottom.mas_equalTo(iconBg3.mas_bottom).offset(-35);
    }];
    
}

@end
