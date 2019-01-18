//
//  DetailHolderCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "DetailHolderCell.h"

@interface DetailHolderCell()

@property(nonatomic,strong)UILabel *gdLabel;
@property(nonatomic,strong)UILabel *ggLabel;

@property(nonatomic,strong)UIScrollView *scrollView1;

@property(nonatomic,strong)UIScrollView *scrollView2;

@end

@implementation DetailHolderCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.gdLabel = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            view.textColor = KRGB(225, 39, 46);
            view.backgroundColor = KHexRGB(0xFFF7F4);
            view.font = KFont(14);
            view.numberOfLines = 0;
            view.textAlignment = NSTextAlignmentCenter;
            view.text = @"股\n东";
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(80);
                make.left.mas_equalTo(self.contentView).offset(15);
                
            }];
            view;
        });
        
        self.ggLabel = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            view.textColor = KRGB(0, 155, 242);
            view.backgroundColor = KHexRGB(0xCCEEFE);
            view.font = KFont(14);
            view.numberOfLines = 0;
            view.textAlignment = NSTextAlignmentCenter;
            view.text = @"董\n监\n高";
            view.preferredMaxLayoutWidth = 30;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.gdLabel.mas_bottom).offset(15);
                make.width.left.mas_equalTo(self.gdLabel);
                   make.height.mas_greaterThanOrEqualTo(80);
            
            }];
            view;
        });
        
       
        
        self.scrollView1 = ({
            UIScrollView *view = [UIScrollView new];
            [self.contentView addSubview:view];
            view.showsHorizontalScrollIndicator = NO;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView);
                make.height.mas_equalTo(80);
                make.left.mas_equalTo(self.gdLabel.mas_right).offset(5);
                make.right.mas_equalTo(self.contentView);
            }];
            view;
        });
        
        self.scrollView2 = ({
            UIScrollView *view = [UIScrollView new];
            [self.contentView addSubview:view];
            view.showsHorizontalScrollIndicator = NO;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.scrollView1.mas_bottom).offset(15);
                make.left.mas_equalTo(self.scrollView1);
                make.height.mas_equalTo(80);
                make.right.mas_equalTo(self.contentView);
                
            }];
            view;
        });
        
        
        
    }
    return self;
}

-(void)checkMore:(UIButton*)button
{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(detailHolderCheckMore:)])
    {
        [self.delegate detailHolderCheckMore:button.tag == 3456?DetailHolderGDType:DetailHolderGGType];
    }
    
}


-(void)setHodelArray:(NSArray *)hodelArray
{
    _hodelArray = hodelArray;
    
    for(UIView *view in self.scrollView1.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    for(int i=0;i<hodelArray.count;i++)
    {
        NSDictionary *dic = [hodelArray objectAtIndex:i];
        HodelButton *button = [[HodelButton alloc]initWithFrame:KFrame(5*i+130*i, 0, 130, 80)];
        button.nameLabel.text = [dic objectForKey:@"name"];
        if([[dic objectForKey:@"strongHolder"] intValue]  == 1)
        {
            button.jobLabel.text = @"大股东";
        }
        else
        {
            button.jobLabel.text = @"";
        }
        
        //button.contentLabel.text = [NSString stringWithFormat:@"持股比例%@%%",[dic objectForKey:@"holdRatio"]];
        
        NSString *dynamicStr = [NSString stringWithFormat:@"持股比例%@%%",[dic objectForKey:@"holdRatio"]];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:dynamicStr];
        [attr addAttribute:NSForegroundColorAttributeName value:KRGB(255, 158, 53) range:NSMakeRange(4, dynamicStr.length - 4)];
        button.contentLabel.attributedText = attr;
        
         button.nameImageView.image = [self getImage:button.nameLabel.text];
        [self.scrollView1 addSubview:button];
        
        if(i == hodelArray.count-1)
        {
            HodelMoreButton *button2 = [[HodelMoreButton alloc]initWithFrame:KFrame(button.maxX +5, 0, 50, 80)];
            button2.tag = 3456;
            [button2 addTarget:self action:@selector(checkMore:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView1 addSubview:button2];
            
            self.scrollView1.contentSize = CGSizeMake(button2.maxX +10, 0);
        }
        
        
    }
    
    
    
}

-(void)setExecutivesArray:(NSArray *)executivesArray
{
    _executivesArray = executivesArray;
    
    for(UIView *view in self.scrollView2.subviews)
    {
        [view removeFromSuperview];
    }
    
    for(int i=0;i<executivesArray.count;i++)
    {
        NSDictionary *dic = [executivesArray objectAtIndex:i];
        HodelButton *button = [[HodelButton alloc]initWithFrame:KFrame(5*i+130*i, 0, 130, 80)];
        button.nameLabel.text = [dic objectForKey:@"name"];;
        button.jobLabel.text = [dic objectForKey:@"job"];;
        button.jobLabel.textColor = KRGB(51, 51, 51);
        button.nameImageView.image = [self getImage:button.nameLabel.text];
        [self.scrollView2 addSubview:button];
        
        if(i == executivesArray.count-1)
        {
            HodelMoreButton *button2 = [[HodelMoreButton alloc]initWithFrame:KFrame(button.maxX +5, 0, 50, 80)];
            button2.tag = 3457;
            [button2 addTarget:self action:@selector(checkMore:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView2 addSubview:button2];
            
            self.scrollView2.contentSize = CGSizeMake(button2.maxX +10, 0);
        }
    }
    
}

- (UIImage *)getImage:(NSString *)name
{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    NSString *headerName = nil;
    if (name.length == 1) {
        headerName = name;
    }else{
        headerName = [name substringToIndex:1];
    }
    UIImage *headerimg = [self zd_imageWithColor:KHexRGB(0xDF242C) size:CGSizeMake(30, 30) text:headerName textAttributes:dic circular:NO];
    return headerimg;
}


- (UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
