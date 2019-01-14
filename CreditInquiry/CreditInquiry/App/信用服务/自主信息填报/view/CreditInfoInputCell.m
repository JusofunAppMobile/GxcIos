//
//  CreditInfoInputCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditInfoInputCell.h"

@interface CreditInfoInputCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *editBtn;
@property (nonatomic ,strong) UIView *noInfoView;
@end

@implementation CreditInfoInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *headerBg = [UIView new];
        [self.contentView addSubview:headerBg];
        [headerBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(37);
        }];
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [headerBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(headerBg).offset(15);
                make.centerY.mas_equalTo(headerBg);
            }];
            view.font = KFont(16);
            view;
        });
        
        self.editBtn = ({
            UIButton *view = [UIButton new];
            [headerBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(headerBg).offset(-15);
                make.centerY.mas_equalTo(headerBg);
            }];
            [view setTitle:@"编辑该信息模块" forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0xd7001b) forState:UIControlStateNormal];
            [view addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
            view.titleLabel.font = KFont(14);
            view;
        });
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexRGB(0xd9d9d9);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(headerBg.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        
        self.noInfoView = ({
            UIView *view = [UIView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(line.mas_bottom).offset(12);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(70);
            }];
            view.backgroundColor = KHexRGB(0xf1f1f1);
            view.layer.cornerRadius = 5;
            view.layer.masksToBounds = YES;
            view;
        });
        
        UILabel *noInfoTitle = [UILabel new];
        noInfoTitle.text = @"暂无企业信息";
        noInfoTitle.font = KFont(14);
        noInfoTitle.textColor = KHexRGB(0x505050);
        [self.contentView addSubview:noInfoTitle];
        [noInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_noInfoView);
            make.top.mas_equalTo(_noInfoView).offset(15);
        }];
        
        UILabel *subTitle = [UILabel new];
        subTitle.text = @"发布该模块信息，在国信查上获取更多精准客户流量";
        subTitle.font = KFont(12);
        subTitle.textColor = KHexRGB(0x808080);
        [self.contentView addSubview:subTitle];
        [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_noInfoView);
            make.top.mas_equalTo(noInfoTitle.mas_bottom).offset(10);
        }];
        
        
    }
    return self;
}

- (void)setSection:(NSInteger)section{
    _section = section;
    
    switch (section) {
        case 0:
            _titleLab.text = @"企业信息";
            break;
        case 1:
            _titleLab.text = @"企业产品";
            break;
        case 2:
            _titleLab.text = @"企业荣誉";
            break;
        case 3:
            _titleLab.text = @"企业伙伴";
            break;
        case 4:
            _titleLab.text = @"企业成员";
            break;
        default:
            break;
    }
}

- (void)editBtnAction{
    if ([self.delegate respondsToSelector:@selector(didClickEditButton:)]) {
        [self.delegate didClickEditButton:_section];//test
    }
}
@end
