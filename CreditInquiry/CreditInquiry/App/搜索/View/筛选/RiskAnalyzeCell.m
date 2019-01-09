//
//  RiskAnalyzeCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "RiskAnalyzeCell.h"

@interface RiskAnalyzeCell()
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) UIView *shadowView;

@end

@implementation RiskAnalyzeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.shadowView = ({
            UIView *shadowView = [UIView new];
            [self.contentView addSubview:shadowView];
            [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 15, 2, 15));//这里显示上下间隔为8防止阴影超出frame导致渲染异常
            }];
            shadowView.backgroundColor = [UIColor whiteColor];
            shadowView.layer.shadowColor =  [UIColor lightGrayColor].CGColor;;
            shadowView.layer.shadowOffset = CGSizeMake(0.1, 0.1);//0,-3
            shadowView.layer.shadowRadius = 2;
            shadowView.layer.shadowOpacity = 0.8;
            shadowView.layer.cornerRadius = 5;
            shadowView;
        });
        
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [_shadowView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_shadowView).offset(20);
                make.left.mas_equalTo(_shadowView).offset(15);
                make.right.mas_equalTo(_shadowView).offset(-15);
            }];
            view.font = KFont(16);
            view.textColor = KHexRGB(0xfc6200);
            view;
        });
        

        self.codeLab = ({
            UILabel *view = [UILabel new];
            [_shadowView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.nameLab);
                make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);;
                make.bottom.mas_equalTo(_shadowView.mas_bottom).offset(-20);
            }];
            view.font = KFont(14);
            view;
        });
        
        //小箭头
        UIImageView *arrowIcon = [UIImageView new];
        arrowIcon.image = KImageName(@"canTouchIcon");
        [_shadowView addSubview:arrowIcon];
        [arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_shadowView).offset(-15);
            make.centerY.mas_equalTo(_shadowView);
        }];
        
    }
    return self;
}
-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    self.nameLab.text = @"小米通讯有限公司";
    
    
    NSString *str1 = @"自身风险：";
    NSString *countStr = [NSString stringWithFormat:@" %@条 ",@"341"];
    NSString *str2  = @"    关联风险：";
    NSString *countStr2 = [NSString stringWithFormat:@" %@条 ",@"486"];;
    NSString *str3 = [NSString stringWithFormat:@"%@%@%@%@",str1,countStr,str2,countStr2];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str3];
    
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0]
                          range:NSMakeRange(0, str3.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, str1.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(str1.length+countStr.length, str2.length)];
    
    [AttributedStr addAttribute:NSBackgroundColorAttributeName value:KRGB(255, 243, 236) range:NSMakeRange(str1.length, countStr.length)];
    
    [AttributedStr addAttribute:NSBackgroundColorAttributeName value:KRGB(255, 243, 236) range:NSMakeRange(str1.length+countStr.length+str2.length, countStr2.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:KRGB(235, 93, 89) range:NSMakeRange(str1.length, countStr.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:KRGB(235, 93, 89) range:NSMakeRange(str1.length+countStr.length+str2.length, countStr2.length)];
    
    self.codeLab.attributedText = AttributedStr;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
