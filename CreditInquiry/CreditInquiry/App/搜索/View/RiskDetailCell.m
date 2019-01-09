//
//  RiskDetailCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "RiskDetailCell.h"


@implementation RiskDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.typeLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textColor = KRGB(234, 0, 21);
            label.font = KFont(12);
            label.text = @"";
            label.layer.cornerRadius = 2;
            label.layer.borderWidth = 0.5;
            label.layer.borderColor = KRGB(234, 0, 21).CGColor;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(15);
            }];
            label;
        });
        
        UILabel *lastLabel = self.typeLabel;
        
        NSArray *array1 = @[@"self.label1",@"self.label2",@"self.label3",@"self.label4"];
        NSArray *array2 = @[@"self.contentLabel1",@"self.contentLabel2",@"self.contentLabel3",@"self.contentLabel4"];
        for(int i=0;i<4;i++)
        {
            UILabel *label = [[UILabel alloc]init];
            label.textColor = KRGB(153, 153, 153);
            label.font = KFont(12);
            
            label.text = @"";
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(10);
            }];
        
            UILabel *label2 = [[UILabel alloc]init];
            label2.textColor = KRGB(51, 51, 51);
            label2.font = KFont(12);
            label2.text = @"";
            label2.numberOfLines = 0;
            [self.contentView addSubview:label2];
            
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(label.mas_right).offset(5);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.top.mas_equalTo(label);
                
                if(i == 3)
                {
                    make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
                }
            }];
            
            [self setValue:label forKeyPath:array1[i]];
            [self setValue:label2 forKeyPath:array2[i]];
            
            [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            
            [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [label2 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            
           
            
            lastLabel = label2;
        }
        
        
        
        
    }
    return self;
}


-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    self.typeLabel.text = @" 行政处罚 ";
    
    self.label1.text = @"决定文书号：";
    self.label2.text = @"处罚类型：";
    self.label3.text = @"处罚机关：";
    self.label4.text = @"处罚日期：";
    
    self.contentLabel1.text = @"北京时间7日消息";
    self.contentLabel2.text = @"2421253535351月7日凌晨，马云在杭州的音乐酒吧正式开业！汪涵、蔡康永、马东、高晓松等大咖出席开业典礼，马云现场唱了一首《广岛之恋》！";
    self.contentLabel3.text = @"北京市工商行政管理局";
    self.contentLabel4.text = @"2018-12-31";
    
    
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
