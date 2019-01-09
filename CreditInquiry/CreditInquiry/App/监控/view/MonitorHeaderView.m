//
//  MonitorHeaderView.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/4.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorHeaderView.h"

@interface MonitorHeaderView ()
@property (nonatomic ,strong) UILabel *numbLab;
@end

@implementation MonitorHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KHexRGB(0xedeef3);
        
        UILabel *titleLab = [UILabel new];
        titleLab.font = KFont(15);
        titleLab.text = @"我的监控企业";
        [self addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(15);
        }];
        
        UIImageView *iconView = [UIImageView new];
        iconView.backgroundColor = [UIColor grayColor];
        [self addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(10);
        }];
        
        
        self.numbLab = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.right.mas_equalTo(iconView.mas_left).offset(-10);
                make.height.width.mas_equalTo(21);
                make.centerY.mas_equalTo(self);
            }];
            view.backgroundColor = KHexRGB(0xd21122);
            view.textColor = [UIColor whiteColor];
            view.text = @"3";
            view.font = KFont(11);
            view.textAlignment = NSTextAlignmentCenter;
            view.layer.cornerRadius = 10.5;
            view.layer.masksToBounds = YES;
            view;
        });
    }
    return self;
}



@end
