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
        
        UIView *bgview = [UIView new];
        bgview.backgroundColor = [UIColor clearColor];
        [self addSubview:bgview];
        [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(200, 170));
        }];
        
        
        UIImageView *iconView = [UIImageView new];
        iconView.image = [UIImage imageNamed:@"网络不给力"];
        [self addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.mas_equalTo(bgview);
        }];
        
        UILabel *tipLab = [UILabel new];
        tipLab.text = @"网络不给力，点击刷新试试";
        tipLab.textColor = KHexRGB(0xcccccc);
        tipLab.font = [UIFont systemFontOfSize:15];
        [self addSubview:tipLab];
        [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgview);
            make.top.mas_equalTo(iconView.mas_bottom);
        }];
        
        UIButton *reloadBtn = [UIButton new];
        [reloadBtn setTitle:@"点击刷新" forState: UIControlStateNormal];
        [reloadBtn setTitleColor:[UIColor colorWithRed:248.f/255 green:101.f/255 blue:34.f/255 alpha:1] forState:UIControlStateNormal];
        reloadBtn.layer.cornerRadius = 16;
        reloadBtn.layer.borderColor = [UIColor colorWithRed:248.f/255 green:101.f/255 blue:34.f/255 alpha:1].CGColor;
        reloadBtn.layer.borderWidth = .5f;
        reloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [reloadBtn addTarget:self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reloadBtn];
        [reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgview);
            make.top.mas_equalTo(tipLab.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(100, 32));
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
