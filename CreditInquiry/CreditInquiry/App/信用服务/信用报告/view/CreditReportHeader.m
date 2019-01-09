//
//  CreditReportHeader.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditReportHeader.h"

@implementation CreditReportHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSString *text = @"国信查支持发票开取，你可以在购买报告后开取发票";
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
        [str addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xd9082a) range:NSMakeRange(5, 4)];
        
        UILabel *tipLab = [UILabel new];
        tipLab.font = KFont(14);
        tipLab.textColor = KHexRGB(0x9b9ca1);
        tipLab.attributedText = str;
        [self addSubview:tipLab];
        [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
    }
    return self;
}

@end
