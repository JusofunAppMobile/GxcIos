//
//  BrowseCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/16.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BrowseCell.h"

@implementation BrowseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.nameImageView = ({
            UIImageView *label = [UIImageView new];
            [self.contentView addSubview:label];
            label.image = KImageName(@"home_icon_gongsi");
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView).offset(10);
                make.height.width.mas_equalTo(33);
                make.left.mas_equalTo(self.contentView).offset(15);
                make.bottom.mas_equalTo(self.contentView).offset(-10);
            }];
            label;
        });
        
        
        self.nameLabel = ({
            UILabel *label = [UILabel new];
            [self.contentView addSubview:label];
            label.textColor = KHexRGB(0x333333);
            label.font = KFont(16);
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.nameImageView.mas_right).offset(5);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.centerY.mas_equalTo(self.contentView);
            }];
            label;
        });
        
        [self.nameImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.nameLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        [self.nameImageView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
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
