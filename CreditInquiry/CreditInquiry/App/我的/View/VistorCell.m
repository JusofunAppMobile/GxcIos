//
//  VistorCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "VistorCell.h"

@implementation VistorCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = ({
            UILabel *label = [UILabel new];
            [self.contentView addSubview:label];
            label.textColor = KRGB(51, 51, 51);
            label.font = KFont(15);
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView).offset(15);
                make.height.mas_equalTo(15);
                
                make.left.mas_equalTo(self.contentView).offset(15);
                make.bottom.mas_equalTo(self.contentView).offset(-15);
            }];
            label;
        });
        
        self.timeLabel = ({
            UILabel *label = [UILabel new];
            [self.contentView addSubview:label];
            label.textColor = KRGB(153, 153, 153);
            label.font = KFont(12);
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.nameLabel.mas_right).offset(10);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.centerY.mas_equalTo(self.contentView);
            }];
            label;
        });
        
    }
    return self;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
