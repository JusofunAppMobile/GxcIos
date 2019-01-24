//
//  DetailRiskCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "DetailRiskCell.h"

@implementation DetailRiskCell
{
    UILabel*label2;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *kongView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 5)];
        kongView.backgroundColor = KRGB(241, 242, 246);

        [self.contentView addSubview:kongView];
        
        UIImageView *iconView = [UIImageView new];
        iconView.image = KImageName(@"info_pic_fengxian");
        [self.contentView addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kongView.mas_bottom);
            make.left.right.bottom.mas_equalTo(self.contentView);
        }];
        
//
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:KFrame(15, 80/2.0-15+5, 30, 30)];
//        imageView.image = [UIImage imageNamed:@"info_pic_title"];
//        //imageView.contentMode = UIViewContentModeCenter;
//        [self.contentView addSubview:imageView];
//
//        UILabel*label = [[UILabel alloc]initWithFrame:KFrame(KDeviceW -70-15, 5+27.5, 70, 20)];
//        label.text = @"查看风险";
//        label.textColor = KRGB(235, 62, 58);
//        label.font = KFont(14);
//        label.layer.cornerRadius = 2;
//        label.layer.borderColor = KHexRGB(0xEF9295).CGColor;
//        label.layer.borderWidth = 1;
//        label.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:label];
//
//
//        label2 = [[UILabel alloc]initWithFrame:KFrame(imageView.maxX + 10, 5+30, KDeviceW - 30 -imageView.width - label.width -20, 15)];
//
//        //label2.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:label2];
//
//        self.selfRiskNum = @"0";
//        self.relateRiskNum = @"0";
        
//        [self  setLabelContent];
        
    }
    return self;
}

//-(void)setLabelContent
//{
//    NSString *str1 = @"自身风险：";
//    NSString *countStr = [NSString stringWithFormat:@"%@条",self.selfRiskNum];
//    NSString *str2  = @"关联风险：";
//    NSString *countStr2 = [NSString stringWithFormat:@"%@条",self.relateRiskNum];;
//    NSString *str3 = [NSString stringWithFormat:@"%@%@  %@%@",str1,countStr,str2,countStr2];
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str3];
//
//    [AttributedStr addAttribute:NSFontAttributeName
//                          value:[UIFont systemFontOfSize:14.0]
//                          range:NSMakeRange(0, str3.length)];
//
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, str1.length)];
//
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(str1.length+countStr.length, str2.length)];
//
//    [AttributedStr addAttribute:NSBackgroundColorAttributeName value:KRGB(255, 241, 235) range:NSMakeRange(str1.length, countStr.length)];
//
//    [AttributedStr addAttribute:NSBackgroundColorAttributeName value:KRGB(255, 241, 235) range:NSMakeRange(str1.length+countStr.length+str2.length+2, countStr2.length)];
//
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:KRGB(235, 62, 58) range:NSMakeRange(str1.length, countStr.length)];
//
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:KRGB(235, 62, 58) range:NSMakeRange(str1.length+countStr.length+str2.length+2, countStr2.length)];
//
//
//
//
//    label2.attributedText = AttributedStr;
//}
//
//-(void)setSelfRiskNum:(NSString *)selfRiskNum
//{
//
//
//    if(!selfRiskNum)
//    {
//        selfRiskNum = @"0";
//    }
//    _selfRiskNum = selfRiskNum;
//
//    [self setLabelContent];
//}
//
//-(void)setRelateRiskNum:(NSString *)relateRiskNum
//{
//
//    if(!relateRiskNum)
//    {
//        relateRiskNum = @"0";
//    }
//    _relateRiskNum = relateRiskNum;
//
//    [self setLabelContent];
//}

@end
