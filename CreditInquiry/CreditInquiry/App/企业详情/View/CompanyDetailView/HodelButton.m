//
//  HodelButton.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "HodelButton.h"

@implementation HodelButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.nameImageView = ({
            UIImageView *view = [UIImageView new];
            [self addSubview:view];
           
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self).offset(5);
                make.height.width.mas_equalTo(30);
                make.left.mas_equalTo(self).offset(5);
            }];
            view;
        });
        
        self.nameLabel = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            view.textColor = KRGB(51, 51, 51);
            view.font = KFont(14);
        
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self).offset(5);
                make.right.mas_equalTo(self).offset(-5);
                make.height.mas_equalTo(15);
                make.left.mas_equalTo(self.nameImageView.mas_right).offset(5);
            }];
            view;
        });
        
        self.jobLabel = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            view.textColor = KRGB(225, 39, 46);
            view.font = KFont(12);
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
                make.left.height.right.mas_equalTo(self.nameLabel);
            }];
            view;
        });
        
        self.contentLabel = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            view.textColor = KRGB(153, 153, 153);
            view.font = KFont(12);
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.nameImageView.mas_bottom).offset(10);
                make.left.mas_equalTo(self.nameImageView);
                make.height.right.mas_equalTo(self.nameLabel);
                
            }];
            view;
        });
        
        self.layer.borderColor = KHexRGB(0xF8F8F8).CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 2;
        self.clipsToBounds = YES;
        
    }
    return self;
}


@end


@implementation HodelMoreButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.nameLabel = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            view.textColor = KRGB(153, 153, 153);
            view.font = KFont(14);
            view.textAlignment = NSTextAlignmentCenter;
            view.text = @"更多";
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_equalTo(self);
                make.right.mas_equalTo(self);
                make.height.mas_equalTo(40);
                
            }];
            view;
        });
        
        self.lineView = ({
            UIView *view = [UIView new];
            [self addSubview:view];
            view.backgroundColor = KHexRGB(0xE2E2E2);
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.nameLabel.mas_bottom);
                make.left.mas_equalTo(self).offset(10);
                make.right.mas_equalTo(self).offset(-10);
                make.height.mas_equalTo(0.5);
            }];
            view;
        });
        
        
        self.nameImageView = ({
            UIImageView *view = [UIImageView new];
            [self addSubview:view];
            view.contentMode = UIViewContentModeCenter;
            view.image = KImageName(@"info_icon_gengduo");
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.lineView.mas_bottom);
                make.left.width.mas_equalTo(self);
               make.height.mas_equalTo(40);
            }];
            view;
        });
        
    
        self.layer.borderColor = KHexRGB(0xF8F8F8).CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 2;
        self.clipsToBounds = YES;
    }
    return self;
}


@end
