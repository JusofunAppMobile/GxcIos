//
//  MonitorFilterHeader.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorFilterHeader.h"

@implementation MonitorFilterHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *view = [UILabel new];
        view.textColor = KHexRGB(0x999A9B);
        view.font = KFont(14);
        view.text = @"筛选";
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
        
        
        
        UILabel *view2 = [UILabel new];
        view2.text = @"动态维度";
        [self addSubview:view2];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view.mas_bottom).offset(25);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}
@end
