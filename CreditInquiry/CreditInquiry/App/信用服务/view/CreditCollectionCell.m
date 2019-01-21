//
//  CreditCollectionCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditCollectionCell.h"
#import <UIButton+LXMImagePosition.h>
#import "CreditServiceModel.h"
#import <UIButton+AFNetworking.h>

@interface CreditCollectionCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *titleLab;
@end
@implementation CreditCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView).offset(20);
                make.centerX.mas_equalTo(self.contentView);
                make.height.mas_equalTo(35);
                make.left.right.mas_equalTo(self.contentView);
            }];
            view.contentMode = UIViewContentModeScaleAspectFit;
            view;
        });
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_iconView.mas_bottom).offset(5);
                make.centerX.mas_equalTo(self.contentView);
            }];
            view.textAlignment = NSTextAlignmentCenter;
            view.font = KFont(14);
            view;
        });
        
    }
    return self;
}

- (void)setModel:(CreditServiceModel *)model{
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.menuImage]];
    _titleLab.text = model.menuName;
}

@end
