//
//  DetailMapCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "DetailMapCell.h"

@implementation DetailMapCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat width = (KDeviceW - 30 -20)/3.0;
        
        NSArray *array = @[@"企业图谱",@"关联关系",@"股权结构"];
        NSArray *imageArray = @[@"企业图谱",@"企业图谱",@"企业图谱"];
        

        for(int i = 0;i<imageArray.count;i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = KFrame(15+width*i+10*i, 0, width, 110);
            
            [button setImage:[Tools scaleImage:KImageName([imageArray objectAtIndex:i]) size:CGSizeMake(width, button.height - 50)] forState:UIControlStateNormal];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = KFont(14);
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [button setImagePosition:LXMImagePositionTop spacing:10];
            [button addTarget:self action:@selector(detailMapButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            
            button.tag = KDetailMapBtnTag +i;
            
            
        }
    
    }
    return self;
}


-(void)detailMapButtonClick:(UIButton*)button
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(detailMapButtonClick:)])
    {
        [self.delegate detailMapButtonClick:button];
    }
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
