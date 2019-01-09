//
//  ReportTypeCell.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/8/9.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "ReportTypeCell.h"
#import "ReportTypeModel.h"

@interface ReportTypeCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel  *nameLabel;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) ReportTypeModel *model;

@end
@implementation ReportTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(15);
            }];
            view.image = KImageName(@"企业风险分析报告");
            view;
        });
        
        self.nameLabel = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(_iconView.mas_right).offset(5);
            }];
            view.text = @"企业风险分析报告";
            view.font = KFont(16);
            view.textColor = KHexRGB(0xff8600);
            view;
        });
        
        self.lineView = ({
            UIView *view = [UIView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(self.contentView);
                make.height.mas_equalTo(1);
            }];
            view.backgroundColor = KHexRGB(0xebebeb);
            view;
        });
        
    }
    return self;
}


- (void)setModel:(ReportTypeModel *)model hideLine:(BOOL)hidden{
    _model = model;
    _nameLabel.text = model.name;
    _lineView.hidden = hidden;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil ];

}

@end
