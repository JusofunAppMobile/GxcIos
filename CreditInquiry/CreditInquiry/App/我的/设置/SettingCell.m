//
//  SettingCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *contentLab;
@end

@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.titleLab = ({
            UILabel *titleLab = [UILabel new];
            titleLab.font = KFont(15);
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
            view.textColor = KHexRGB(0x505050);
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView);
            }];
            view;
        });
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            _titleLab.text = @"消息推送设置";
            _contentLab.text = nil;
        }else{
            _titleLab.text = @"清除缓存";
            _contentLab.text = @"8.24MB";
        }
    }else{
        if (indexPath.row == 0) {
            _titleLab.text = @"服务协议";
            _contentLab.text = nil;
        }else if (indexPath.row == 1){
            _titleLab.text = @"隐私政策";
            _contentLab.text = nil;
        }else{
            _titleLab.text = @"关于我们";
            _contentLab.text = nil;
        }
    }
}


@end
