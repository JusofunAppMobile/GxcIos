//
//  NetworkFailedView.m
//  NoDataTest
//
//  Created by JUSFOUN on 2018/3/12.
//  Copyright © 2018年 JUSFOUN. All rights reserved.
//

#import "NetworkFailedView.h"
#import <Masonry.h>


@implementation NetworkFailedView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *iconView = [UIImageView new];
        iconView.image = [UIImage imageNamed:@"netFailed"];
        [self addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(100);
            make.centerX.mas_equalTo(self);
        }];
        
        UILabel *tipLab = [UILabel new];
        tipLab.text = @"网络崩溃了";
        tipLab.font = [UIFont systemFontOfSize:17];
        [self addSubview:tipLab];
        [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(iconView.mas_bottom).offset(28);
        }];
        
        UILabel *subLab = [UILabel new];
        subLab.text = @"刷新试试吧～";
        subLab.textColor = KHexRGB(0x909090);
        subLab.font = KFont(14);
        [self addSubview:subLab];
        [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(tipLab.mas_bottom).offset(20);
        }];
        
        UIButton *reloadBtn = [UIButton new];
        [reloadBtn setTitle:@"重新加载" forState: UIControlStateNormal];
        [reloadBtn setTitleColor:KHexRGB(0xd21c28) forState:UIControlStateNormal];
        reloadBtn.layer.cornerRadius = 2;
        reloadBtn.layer.borderColor = KHexRGB(0xd21c28).CGColor;
        reloadBtn.layer.borderWidth = .5f;
        reloadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [reloadBtn addTarget:self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reloadBtn];
        [reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(subLab.mas_bottom).offset(20);
            make.size.mas_equalTo(CGSizeMake(100, 28));
        }];
        
    }
    return self;
}

- (void)reloadAction{
    if ([_delegate respondsToSelector:@selector(networkReload)]) {
        [_delegate networkReload];
    }
}



@end
