//
//  SettingPlainCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SettingPlainCell.h"

@interface SettingPlainCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *contentLab;
@end

@implementation SettingPlainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.titleLab = ({
            UILabel *titleLab = [UILabel new];
            titleLab.font = KFont(15);
            titleLab.text = @"头像";
            titleLab.textColor = KHexRGB(0x303030);
            [self.contentView addSubview:titleLab];
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView).offset(19);
                make.bottom.mas_equalTo(self.contentView).offset(-19);
                make.left.mas_equalTo(self.contentView).offset(15);
            }];
            titleLab;
        });
       
        self.contentLab = ({
            UILabel *view = [UILabel new];
            view.font = KFont(15);
            view.text = @"修改密码";
            view.textColor = KHexRGB(0x878787);
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView).offset(-10);
            }];
            view;
        });
    }
    return self;
}


@end
