//
//  HomeMonitorCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "HomeMonitorCell.h"

@implementation HomeMonitorCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.logoImageView = ({
            UIImageView *logoImageView = [[UIImageView alloc]init];
            logoImageView.image = KImageName(@"home_LoadingLogo");
            [self.contentView addSubview:logoImageView];
            [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_equalTo(self.contentView).offset(15);
                make.width.height.mas_equalTo(40);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
            }];
            logoImageView;
        });
        
        self.nameLabel = ({
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.textColor = KRGB(51, 51, 51);
            nameLabel.font = KFont(16);
            nameLabel.text = @"";
            [self.contentView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.logoImageView.mas_right).offset(15);
                make.height.mas_equalTo(15);
                make.top.mas_equalTo(self.logoImageView);
                make.right.mas_equalTo(self.contentView).offset(-15);
            }];
            nameLabel;
        });
        
        self.timeLabel = ({
            UILabel *timeLabel = [[UILabel alloc]init];
            timeLabel.textColor = KRGB(153, 153, 153);
            timeLabel.font = KFont(12);
            timeLabel.text = @"";
            [self.contentView addSubview:timeLabel];
            [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.nameLabel);
                make.width.mas_equalTo(70); make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
                make.right.mas_equalTo(self.contentView).offset(-15);
            }];
            timeLabel;
        });
        
        self.contentLabel = ({
            UILabel *contentLabel = [[UILabel alloc]init];
            contentLabel.textColor = KRGB(51, 51, 51);
            contentLabel.font = KFont(12);
            contentLabel.text = @"";
            [self.contentView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.height.mas_equalTo(self.nameLabel);
                make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
                make.right.mas_equalTo(self.timeLabel.mas_left).offset(-10);
                
            }];
            contentLabel;
        });
        
        
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = KRGB(227, 227, 227);
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView);
            make.left.width.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}


-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
   //[_logoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:KImageName(@"home_LoadingLogo")];
    _nameLabel.text = [dataDic objectForKey:@"companyName"];
    _timeLabel.text = [dataDic objectForKey:@"changeDate"];
    
    NSString *dynamicStr = [NSString stringWithFormat:@"共%@条动态",[dataDic objectForKey:@"changeNum"]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:dynamicStr];
    [attr addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xe8603b) range:NSMakeRange(1, dynamicStr.length - 4)];
    _contentLabel.attributedText = attr;
    
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
