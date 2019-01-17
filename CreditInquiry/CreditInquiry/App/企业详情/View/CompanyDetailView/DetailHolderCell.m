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
        
        button.contentLabel.text = [NSString stringWithFormat:@"持股比例%@%%",[dic objectForKey:@"holdRatio"]];
         button.nameImageView.image = [self getImage:button.nameLabel.text];
        [self.scrollView1 addSubview:button];
        
        if(i == hodelArray.count-1)
        {
            HodelMoreButton *button2 = [[HodelMoreButton alloc]initWithFrame:KFrame(button.maxX +5, 0, 50, 80)];
            
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
        button.nameImageView.image = [self getImage:button.nameLabel.text];
        [self.scrollView2 addSubview:button];
        
        if(i == executivesArray.count-1)
        {
            HodelMoreButton *button2 = [[HodelMoreButton alloc]initWithFrame:KFrame(button.maxX +5, 0, 50, 80)];
            
            [self.scrollView2 addSubview:button2];
            
            self.scrollView2.contentSize = CGSizeMake(button2.maxX +10, 0);
        }
    }
    
}



- (UIImage *)getImage:(NSString *)name
{
    UIColor *color = KHexRGB(0xDF242C);  //获取随机颜色
    CGRect rect = CGRectMake(0.0f, 0.0f, 30, 30);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSString *headerName = nil;
    if (name.length == 1) {
        headerName = name;
    }else{
        headerName = [name substringToIndex:1];
    }
    UIImage *headerimg = [self imageToAddText:img withText:headerName];
    return headerimg;
}


//把文字绘制到图片上
- (UIImage *)imageToAddText:(UIImage *)img withText:(NSString *)text
{
    //1.获取上下文
    UIGraphicsBeginImageContext(img.size);
    //2.绘制图片
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //3.绘制文字
    CGRect rect = CGRectMake(0,3, img.size.width, img.size.height);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    //文字的属性
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor whiteColor]};
    //将文字绘制上去
    [text drawInRect:rect withAttributes:dic];
    //4.获取绘制到得图片
    UIImage *watermarkImg = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束图片的绘制
    UIGraphicsEndImageContext();
    
    return watermarkImg;
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
