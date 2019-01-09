//
//  CreditEditImageCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditEditImageCell.h"

@interface CreditEditImageCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *tipLab;
@property (nonatomic ,strong) UIImageView *iconView;
@end

@implementation CreditEditImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(15);
                make.width.mas_equalTo(80);
            }];
            view.font = KFont(16);
            view.text = @"荣誉图片";
            view;
        });
        
        
        self.tipLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(30);
                make.right.mas_equalTo(self.contentView).offset(-30);
                make.top.mas_equalTo(_titleLab.mas_bottom).offset(15);
            }];
            view.numberOfLines = 2;
            view.text = @"仅支持JPG、JPEG和PNG格式，大小不超过5M。";
            view.textColor = KHexRGB(0x828282);
            view.font = KFont(12);
            view;
        });
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
                make.top.mas_equalTo(_tipLab.mas_bottom).offset(25);
                make.bottom.mas_equalTo(self.contentView).offset(-16);
                make.width.mas_equalTo(185*(KDeviceW/375.f));
                make.height.mas_equalTo(125*(KDeviceW/375.f));
            }];
            view.backgroundColor = [UIColor grayColor];
            view;
        });
    }
    return self;
}

@end
