//
//  ReportSendSuccessController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ReportSendSuccessController.h"
#import "MyOrderController.h"

@interface ReportSendSuccessController ()

@end

@implementation ReportSendSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"提交成功"];
    [self setBlankBackButton];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    
    UIImageView *iconView = [UIImageView new];
    iconView.image = KImageName(@"icon_success");
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(KNavigationBarHeight+60);
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.font = KFont(17);
    titleLab.text = @"报告已发送";
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    UILabel *subLab = [UILabel new];
    subLab.font = KFont(14);
    subLab.text = @"报告已发送至您的接收邮箱，可以前往查看啦";
    subLab.textColor = KHexRGB(0x909090);
    subLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:subLab];
    [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).offset(30);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    
    UIButton *doneBtn = [UIButton new];
    doneBtn.layer.borderWidth = 1;
    doneBtn.layer.borderColor = KHexRGB(0xc0c1c2).CGColor;
    doneBtn.layer.cornerRadius = 2;
    doneBtn.layer.masksToBounds = YES;
    doneBtn.titleLabel.font = KFont(15);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:KHexRGB(0x8e8f90) forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(67);
        make.right.mas_equalTo(-67);
        make.bottom.mas_equalTo(-107);
        make.height.mas_equalTo(45);
    }];
    
    
    UIButton *checkBtn = [UIButton new];
    checkBtn.layer.cornerRadius = 2;
    checkBtn.layer.masksToBounds = YES;
    checkBtn.backgroundColor = KHexRGB(0xd31023);
    checkBtn.titleLabel.font = KFont(15);
    [checkBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(doneBtn);
        make.bottom.mas_equalTo(doneBtn.mas_top).offset(-30);
        make.height.mas_equalTo(45);
    }];
}

- (void)doneAction{
    NSArray *vcs = self.navigationController.viewControllers;
    [self.navigationController popToViewController:vcs[vcs.count -3] animated:YES];
}

- (void)checkAction{
    MyOrderController *vc = [MyOrderController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
