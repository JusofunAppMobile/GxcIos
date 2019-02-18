//
//  MonitorTableHeader.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorTableHeader.h"

@implementation MonitorTableHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView *vectorLine = [UIView new];
        vectorLine.backgroundColor = KHexRGB(0xda2632);
        vectorLine.layer.cornerRadius = 2;
        vectorLine.layer.masksToBounds = YES;
        [self addSubview:vectorLine];
        [vectorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(17);
            make.width.mas_equalTo(4);
            make.left.mas_equalTo(15);
        }];
        
        
        UILabel *titleLab = [UILabel new];
        [self addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(vectorLine.mas_right).offset(5);
        }];
        titleLab.font = KFont(15);
        titleLab.text = @"企业动态";
        
//        UILabel *vipLab = [UILabel new];//test隐藏
//        [self addSubview:vipLab];
//        [vipLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(titleLab.mas_right).offset(10);
//            make.centerY.mas_equalTo(self);
//        }];
//        vipLab.text = @"成为VIP掌握企业风险动态";
//        vipLab.font = KFont(12);
//        vipLab.textColor = KHexRGB(0xe26062);
        
        
//        UIButton *filterBtn = [UIButton new];
//        [filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
//        [filterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [filterBtn addTarget:self action:@selector(filterAction) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:filterBtn];
//        [filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self);
//            make.right.mas_equalTo(-15);
//        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexRGB(0xd7d7d7);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(.5);
            make.bottom.left.right.mas_equalTo(self);
        }];
        
    }
    return self;
}

- (void)filterAction{
    if ([self.delegate respondsToSelector:@selector(didClickFilterButton)]) {
        [self.delegate didClickFilterButton];
    }
}


@end
