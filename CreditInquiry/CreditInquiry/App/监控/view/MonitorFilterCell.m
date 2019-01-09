//
//  MonitorFilterCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorFilterCell.h"

@interface MonitorFilterCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@end

@implementation MonitorFilterCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.contentView);
            }];
            view.textAlignment = NSTextAlignmentCenter;
            view.font = KFont(12);
            view.backgroundColor = KHexRGB(0xf6f6f6);
            view.layer.cornerRadius = 4;
            view.layer.masksToBounds = YES;
            view;
        });
        
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    _titleLab.text = text;
}

@end
