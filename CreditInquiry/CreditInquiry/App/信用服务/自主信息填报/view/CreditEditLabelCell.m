//
//  CreditEditLabelCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditEditLabelCell.h"

@interface CreditEditLabelCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UITextField *contentField;
@end
@implementation CreditEditLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(12);
                make.top.mas_equalTo(self.contentView).offset(15);
                make.bottom.mas_equalTo(self.contentView).offset(-15);
                make.width.mas_equalTo(80);
            }];
            view.font = KFont(15);
            view.text = @"联系电话：";
            view;
        });
        
        self.contentField = ({
            UITextField *view = [UITextField new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLab.mas_right).offset(5);
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView).offset(-12);
            }];
            view.text = @"中投国信科技发展t有限公司";
            view.font = KFont(15);
            view;
        });

    }
    return self;
}





@end
