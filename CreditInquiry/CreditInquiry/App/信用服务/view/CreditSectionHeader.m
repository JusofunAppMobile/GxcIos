//
//  CreditSectionHeader.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditSectionHeader.h"

@interface CreditSectionHeader ()
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIView *line;
@end

@implementation CreditSectionHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        _bgView = [[UIView alloc]initWithFrame:KFrame(0, self.height -50, self.width, 50)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        UIView *vectorLine = [UIView new];
        vectorLine.backgroundColor = KHexRGB(0xda2632);
        vectorLine.layer.cornerRadius = 2;
        vectorLine.layer.masksToBounds = YES;
        [_bgView addSubview:vectorLine];
        [vectorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bgView);
            make.height.mas_equalTo(17);
            make.width.mas_equalTo(4);
            make.left.mas_equalTo(15);
        }];
        
        self.titleLab = ({
            UILabel *titleLab = [UILabel new];
            titleLab.font = KFont(15);
            titleLab.text = @"企业服务";
            [_bgView addSubview:titleLab];
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_bgView);
                make.left.mas_equalTo(vectorLine.mas_right).offset(5);
            }];
            titleLab;
        });
       
        self.line = ({
            UIView *line = [UIView new];
            line.backgroundColor = KHexRGB(0xdadada);
            [_bgView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(_bgView);
                make.height.mas_equalTo(1);
            }];
            line;
        });
        
    }
    return self;
}

- (void)setupHeader:(int)state section:(NSInteger)section{
    if (state == 1) {//test
        if (section == 0) {
            _titleLab.text = @"企业服务";
            _line.hidden = NO;
        }else if (section == 1){
            _titleLab.text = @"企业查询";
            _line.hidden = NO;
        }else{
            _titleLab.text = @"政府访客统计";
            _line.hidden = YES;
        }
    }else{
        _titleLab.text = @"企业查询";
        _line.hidden = NO;
    }
}

@end
