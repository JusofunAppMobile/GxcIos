//
//  NoDataView.m
//  ConstructionBank
//
//  Created by JUSFOUN on 2018/10/8.
//  Copyright © 2018年 JUSFOUN. All rights reserved.
//

#import "NoDataView.h"

@interface NoDataView ()
@property (nonatomic ,strong) UILabel *label;
@end

@implementation NoDataView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.label = ({
            UILabel *view = [UILabel new];
            view.textColor = KHexRGB(0x909090);
            view.font = KFont(16);
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self);
                make.bottom.mas_equalTo(self.mas_centerY);
            }];
            view;
        });
        
        UIImageView *iconView = [UIImageView new];
        iconView.image = KImageName(@"netFailed");
        [self addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_label.mas_top).offset(-30);
            make.centerX.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    _label.text = text;
}

@end
