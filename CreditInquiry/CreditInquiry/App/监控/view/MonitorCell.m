//
//  MonitorCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/4.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorCell.h"
#import "ContentInsetsLabel.h"

@interface MonitorCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) ContentInsetsLabel *changeItemLab;
@property (nonatomic ,strong) UILabel *beforeLab;
@property (nonatomic ,strong) UILabel *afterLab;
@property (nonatomic ,strong) UIButton *monitorBtn;
@property (nonatomic ,strong) UIButton *shareBtn;

@end
@implementation MonitorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(15);
                make.width.height.mas_equalTo(40);
            }];
            view.backgroundColor = [UIColor greenColor];
            view;
        });
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_iconView);
                make.left.mas_equalTo(_iconView.mas_right).offset(15);
            }];
            view.text = @"珠海格力电器股份有限公司";
            view.font = KFont(15);
            view;
        });
        
        self.dateLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_iconView);
                make.left.mas_equalTo(_nameLab);
            }];
            view.text = @"今天 18:00";
            view.font = KFont(12);
            view.textColor = KHexRGB(0x9b9b9b);
            view;
        });
        
        UIView *changeBg = [UIView new];
        [self.contentView addSubview:changeBg];
        [changeBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(_iconView.mas_bottom).offset(10);
        }];
        changeBg.backgroundColor = KHexRGB(0xf2f2f2);
        changeBg.layer.cornerRadius = 2;
        
        self.changeItemLab = ({
            ContentInsetsLabel *view = [ContentInsetsLabel new];
            [changeBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(changeBg).offset(10);
                make.height.mas_equalTo(20);
            }];
            view.contentInsets = UIEdgeInsetsMake(0, 7, 0, 7);
            view.font = KFont(12);
            view.textColor = KHexRGB(0xde494c);
            view.text = @"法人变更";
            view.layer.borderWidth = 1.f;
            view.layer.borderColor = KHexRGB(0xe7748f).CGColor;
            view.layer.cornerRadius = 2;
            view.layer.masksToBounds = YES;
            view.textAlignment = NSTextAlignmentCenter;
            view.backgroundColor = KHexRGB(0xfddddc);
            view;
        });
        
        UILabel *beforeTitle = ({
            UILabel *view = [UILabel new];
            [changeBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_changeItemLab);
                make.top.mas_equalTo(_changeItemLab.mas_bottom).offset(7);
            }];
            view.text = @"变更前";
            view.textColor = KHexRGB(0x909090);
            view.font = KFont(12);
            view;
        });
        
        UILabel *afterTitlte = ({
            UILabel *view = [UILabel new];
            [changeBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(changeBg.mas_centerX).offset(0.5+10);
                make.top.mas_equalTo(beforeTitle);
            }];
            view.text = @"变更后";
            view.textColor = KHexRGB(0x909090);
            view.font = KFont(12);
            view;
        });
        
        self.beforeLab = ({
            UILabel *view = [UILabel new];
            [changeBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(beforeTitle);
                make.top.mas_equalTo(beforeTitle.mas_bottom).offset(7);
                make.right.mas_equalTo(changeBg.mas_centerX).offset(-10-0.5);
                make.bottom.mas_lessThanOrEqualTo(changeBg.mas_bottom).offset(-10);
            }];
            view.font = KFont(14);
            view.text = @"黄晓明";
            view.numberOfLines = 3;
            view;
        });
        
        
        self.afterLab = ({
            UILabel *view = [UILabel new];
            [changeBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(afterTitlte);
                make.top.mas_equalTo(_beforeLab);
                make.right.mas_equalTo(changeBg).offset(-10);
                make.bottom.mas_lessThanOrEqualTo(changeBg.mas_bottom).offset(-10);
            }];
            view.font = KFont(14);
            view.text = @"马化腾撒打算打算等哈收到哈哈是的哈是的哈是大红色撒大会上的哈哈是的";
            view.numberOfLines = 2;
            view.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
            view;
        });
        
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexRGB(0xd3d3d3);
        [changeBg addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(changeBg);
            make.top.mas_equalTo(beforeTitle).offset(5);
            make.bottom.mas_greaterThanOrEqualTo(_beforeLab).offset(-5);
            make.bottom.mas_greaterThanOrEqualTo(_afterLab).offset(-5);
            make.width.mas_equalTo(1);
        }];
        
        self.monitorBtn = ({
            UIButton *view = [UIButton new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(changeBg.mas_bottom).offset(15);
                make.bottom.mas_equalTo(self.contentView).offset(-15);
                make.left.mas_equalTo(22);
                make.height.mas_equalTo(16);
            }];
            view.titleLabel.font = KFont(14);
            [view setTitle:@"监控" forState:UIControlStateNormal];
            [view setTitle:@"已监控" forState:UIControlStateSelected];
            [view setTitleColor:KHexRGB(0x505050) forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0xde494c) forState:UIControlStateSelected];
            view;
        });
        
        
        self.shareBtn = ({
            UIButton *view = [UIButton new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.height.mas_equalTo(_monitorBtn);
                make.left.mas_equalTo(_monitorBtn.mas_right).offset(40);
            }];
            view.titleLabel.font = KFont(14);
            [view setTitle:@"分享" forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0x505050) forState:UIControlStateNormal];
            view;
        });
        
    }
    return self;
}



@end
