//
//  MonitorDynamicCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorDynamicCell.h"

@interface MonitorDynamicCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *dynamicLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) UIButton *monitorBtn;
@end

@implementation MonitorDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.width.height.mas_equalTo(40);
            }];
            view.backgroundColor = [UIColor greenColor];
            view;
        });
        
        self.monitorBtn = ({
            UIButton *view = [UIButton new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.height.mas_equalTo(25);
                make.width.mas_equalTo(50);
            }];
            view.titleLabel.font = KFont(12);
            [view setTitle:@"监控" forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0xd93947) forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0x909090) forState:UIControlStateNormal];
            view.layer.borderWidth = .5f;
            view.layer.borderColor = KHexRGB(0xd93947).CGColor;
            view.layer.cornerRadius = 3;
            view.layer.masksToBounds = YES;
            view;
        });
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_iconView);
                make.left.mas_equalTo(_iconView.mas_right).offset(15);
                make.right.mas_lessThanOrEqualTo(_monitorBtn.mas_left).offset(-10);
            }];
            view.font = KFont(15);
            view.text = @"小米科技有限责任公司";
            view;
        });
        
        self.dynamicLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_nameLab.mas_bottom).offset(10);
                make.left.mas_equalTo(_nameLab);
            }];
            view.font = KFont(12);
            view.text = @"共3条动态";
            view.textColor = KHexRGB(0x909090);
            view;
        });
        
        self.dateLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_dynamicLab);
                make.left.mas_equalTo(_dynamicLab.mas_right).offset(17);
            }];
            view.font = KFont(12);
            view.text = @"2019-09-08";
            view.textColor = KHexRGB(0x909090);
            view;
        });
        
    }
    return self;
}

@end
