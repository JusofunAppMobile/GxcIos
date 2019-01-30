//
//  MePlainCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MePlainCell.h"

@interface MePlainCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) NSArray *icons;
@property (nonatomic ,strong) NSArray *titles;
@end

@implementation MePlainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(self.contentView).offset(15);
            }];
            view;
        });
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(_iconView.mas_right).offset(10);
            }];
            view.font = KFont(15);
            view.textColor = KHexRGB(0x303030);
            view;
        });
        
        _icons = @[@"mine_lishi",@"mine_help",@"mine_setting"];
        _titles = @[@"浏览历史",@"使用帮助",@"设置"];
        
    }
    return self;
}

- (void)setRow:(NSInteger)row{
    _row = row;
    _iconView.image = KImageName(_icons[row]);
    _titleLab.text = _titles[row];
}

@end
