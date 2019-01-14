//
//  CreditInfoInputHeader.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditInfoInputHeader.h"

@interface CreditInfoInputHeader ()

@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) UILabel *typeLab;
@end
@implementation CreditInfoInputHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(15);
                make.right.mas_equalTo(-15);
            }];
            view.text = @"滴滴出行科技发展有限公司深圳分公司";
            view.font = KFont(17);
            view;
        });
        
        UILabel *codeTitle = [UILabel new];
        [self addSubview:codeTitle];
        [codeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab);
            make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);
        }];
        codeTitle.text = @"统一社会信用代码：";
        codeTitle.font = KFont(12);
        codeTitle.textColor = KHexRGB(0x909090);
        
        self.codeLab = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(codeTitle);
                make.left.mas_equalTo(codeTitle.mas_right);
                make.right.mas_lessThanOrEqualTo(self).offset(-15);
            }];
            view.text = @"9391293921931929MSKKL";
            view.font = KFont(12);
            view;
        });
        
        UILabel *typeTitle = [UILabel new];
        [self addSubview:typeTitle];
        [typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(codeTitle.mas_bottom).offset(15);
            make.left.mas_equalTo(codeTitle);
        }];
        typeTitle.text = @"企业类型：";
        typeTitle.font = KFont(12);
        typeTitle.textColor = KHexRGB(0x909090);
        
        
        self.typeLab = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(typeTitle);
                make.left.mas_equalTo(typeTitle.mas_right);
                make.right.mas_lessThanOrEqualTo(self).offset(-15);
            }];
            view.text = @"非上市、自然人或投资控股";
            view.font = KFont(12);
            view;
        });
        
    }
    return self;
}

@end
