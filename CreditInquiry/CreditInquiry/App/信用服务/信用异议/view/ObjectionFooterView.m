//
//  ObjectionFooterView.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ObjectionFooterView.h"

@implementation ObjectionFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *footerBtn = [UIButton new];
        footerBtn.backgroundColor = KHexRGB(0xeb101e);
        footerBtn.layer.cornerRadius = 20;
        footerBtn.layer.masksToBounds = YES;
        [footerBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self addSubview:footerBtn];
        [footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(22);
            make.height.mas_equalTo(45);
        }];
        
    }
    return self;
}

@end
