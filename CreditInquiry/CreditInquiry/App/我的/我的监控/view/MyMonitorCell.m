//
//  MyMonitorCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyMonitorCell.h"

@interface MyMonitorCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *nameLab;
@end
@implementation MyMonitorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(15);
                make.width.height.mas_equalTo(25);
            }];
            view.backgroundColor = [UIColor yellowColor];
            view;
        });
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(_iconView.mas_right).offset(15);
            }];
            view.font = KFont(16);
            view.text = @"小米科技股份有限公司";
            view.textColor = KHexRGB(0x303030);
            view;
        });
        
    }
    return self;
}



@end
