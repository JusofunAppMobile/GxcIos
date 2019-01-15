//
//  SettingAvatarCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SettingAvatarCell.h"

@interface SettingAvatarCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@end

@implementation SettingAvatarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *titleLab = [UILabel new];
        titleLab.font = KFont(15);
        titleLab.text = @"头像";
        titleLab.textColor = KHexRGB(0x303030);
        [self.contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView).offset(10);
                make.bottom.mas_equalTo(self.contentView).offset(-10);
                make.width.height.mas_equalTo(52);
                make.right.mas_equalTo(self.contentView);
            }];
            [view sd_setImageWithURL:[NSURL URLWithString:KUSER.headIcon] placeholderImage:KImageName(@"me_head_h")];
            view;
        });
    }
    return self;
}

@end
