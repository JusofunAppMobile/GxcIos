//
//  SettingFooterView.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SettingFooterView.h"

@implementation SettingFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *footerBtn = [UIButton new];
        footerBtn.backgroundColor = KHexRGB(0xeb101e);
        footerBtn.layer.cornerRadius = 20;
        footerBtn.layer.masksToBounds = YES;
        [footerBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [footerBtn addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:footerBtn];
        [footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(25);
            make.height.mas_equalTo(45);
        }];
    }
    return self;
}

- (void)loginOutAction{
    if ([self.delegate respondsToSelector:@selector(didClickLoginout)]) {
        [self.delegate didClickLoginout];
    }
}

@end
