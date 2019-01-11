//
//  MsgSettingController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MsgSettingController.h"

@interface MsgSettingController ()

@end

@implementation MsgSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"推送消息设置"];
    [self setBlankBackButton];
    
    [self initView];
}

- (void)initView{

    UILabel *titleLab = [UILabel new];
    titleLab.text = @"推送消息设置";
    titleLab.font = KFont(15);
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight +20);
        make.left.mas_equalTo(self.view).offset(15);
    }];
    
    
    UISwitch *mySwitch = [UISwitch new];
    mySwitch.on = YES;
    [mySwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:mySwitch];
    [mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.right.mas_equalTo(self.view).offset(-15);
    }];
}

- (void)valueChanged:(UISwitch *)sender{//加接口
    
}

@end
