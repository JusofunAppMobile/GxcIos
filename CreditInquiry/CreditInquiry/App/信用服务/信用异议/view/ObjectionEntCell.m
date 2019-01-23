//
//  ObjectionEntCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ObjectionEntCell.h"

@interface ObjectionEntCell ()
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) UILabel *typeLab;
@end

@implementation ObjectionEntCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(self.contentView).offset(15);
                make.right.mas_equalTo(-15);
            }];
            view.font = KFont(17);
            view;
        });
        
        UILabel *codeTitle = [UILabel new];
        [self.contentView addSubview:codeTitle];
        [codeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);
            make.left.mas_equalTo(_nameLab);
        }];
        codeTitle.text = @"统一社会信用代码：";
        codeTitle.font = KFont(12);
        codeTitle.textColor = KHexRGB(0x909090);
        
        
        self.codeLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(codeTitle);
                make.left.mas_equalTo(codeTitle.mas_right);
                make.right.mas_lessThanOrEqualTo(self.contentView).offset(-15);
            }];
            view.font = KFont(12);
            view.textColor = KHexRGB(0x303030);
            view;
        });
        
        UILabel *typeTitle = [UILabel new];
        [self.contentView addSubview:typeTitle];
        [typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_codeLab.mas_bottom).offset(10);
            make.left.mas_equalTo(codeTitle);
            make.bottom.mas_equalTo(self.contentView).offset(-15);
        }];
        typeTitle.text = @"企业类型：";
        typeTitle.font = KFont(12);
        typeTitle.textColor = KHexRGB(0x909090);
        
        self.typeLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(typeTitle);
                make.left.mas_equalTo(typeTitle.mas_right);
                make.right.mas_lessThanOrEqualTo(self.contentView).offset(-15);
            }];
            view.font = KFont(12);
            view.textColor = KHexRGB(0x303030);
            view;
        });
    }
    return self;
}

- (void)setCompanyInfo:(NSDictionary *)companyInfo{
    _companyInfo = companyInfo;
    _nameLab.text = companyInfo[@"companyName"];
    _codeLab.text = companyInfo[@"code"];
    _typeLab.text = companyInfo[@"type"];
}

@end
