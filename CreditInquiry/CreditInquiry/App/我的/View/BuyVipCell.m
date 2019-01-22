//
//  BuyVipCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BuyVipCell.h"
@interface BuyVipCell()

@property (nonatomic ,strong) UILabel *yearLabel;
@property (nonatomic ,strong) UILabel *dayLabel;
@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) UIImageView *payImageView;
@property (nonatomic ,strong) UILabel *payLabel;
@property (nonatomic ,strong) UIImageView *chooseImageView;

@property (nonatomic ,strong) UILabel *oriPriceLabel;


@property(nonatomic,assign)NSInteger section;

@end
@implementation BuyVipCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.section = section;
        if(section == 0)
        {
             self.backView = ({
                 
                 UIView *backView = [UIView new];
                 [self.contentView addSubview:backView];
                 backView.backgroundColor = [UIColor whiteColor];
                 backView.layer.cornerRadius = 5;
                 backView.clipsToBounds = YES;
                 backView.layer.borderWidth = 1;
                 backView.layer.borderColor = KRGB(201, 201, 201).CGColor;
                 
                 [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.left.mas_equalTo(15);
                     make.top.mas_equalTo(10);
                     make.right.mas_equalTo(self.contentView).offset(-15);
                     make.height.mas_equalTo(65); make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityHigh();
                 }];
                 backView;
            });
                 
            self.yearLabel = ({
                UILabel *yearLabel = [UILabel new];
                [_backView addSubview:yearLabel];
                yearLabel.textColor = KRGB(0, 0, 0);
                yearLabel.font = KFont(16);
                
                [yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(15);
                    make.centerY.mas_equalTo(self.backView);
                }];
                yearLabel;
            });
           
            
            
            self.curPriceLabel = ({
                UILabel *view = [UILabel new];
                [self.backView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self.backView);
                make.right.mas_equalTo(self.backView).offset(-15);
                    
                }];
                view.font = KFont(16);
                view.textColor = KHexRGB(0xEE2520);
                view;
            });
            
            self.oriPriceLabel = ({
                UILabel *view = [UILabel new];
                [self.backView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.backView).offset(20);
                    make.height.mas_equalTo(15);
                    make.right.mas_equalTo(self.curPriceLabel.mas_left).offset(-10);
                    
                }];
                view.font = KFont(12);
                view.textColor = KHexRGB(0x666666);
                view;
            });
            
            self.dayLabel = ({
                UILabel *dayLabel = [UILabel new];
                [self.backView addSubview:dayLabel];
                dayLabel.textColor = KHexRGB(0x666666);
                dayLabel.font = KFont(12);
                [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.oriPriceLabel.mas_bottom).offset(5);
                    make.height.mas_equalTo(15);
                    make.right.mas_equalTo(self.curPriceLabel.mas_left).offset(-10);
                }];
                dayLabel;
            });
            
        }
        else
        {
            self.payImageView = ({
                UIImageView *imageView = [UIImageView new];
                [self.contentView addSubview:imageView];
                imageView.image = KImageName(@"icon_gudong");
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(15);
                    make.top.mas_equalTo(10);
                    make.width.height.mas_equalTo(35);
                    make.bottom.mas_equalTo(self.contentView).offset(-10).priorityHigh();
                }];
                
                imageView;
            });
            
            
            self.payLabel = ({
                UILabel *yearLabel = [UILabel new];
                [self.contentView addSubview:yearLabel];
                yearLabel.textColor = KRGB(0, 0, 0);
                yearLabel.font = KFont(16);
                
                [yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.payImageView.mas_right).offset(20);
                    make.centerY.mas_equalTo(self.contentView);
                }];
                yearLabel;
            });
            
            self.chooseImageView = ({
                UIImageView *imageView = [UIImageView new];
                [self.contentView addSubview:imageView];
                imageView.image = KImageName(@"notChoose");
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(self.contentView).mas_equalTo(-15);
                    make.centerY.mas_equalTo(self.contentView);
                }];
                
                imageView;
            });
            
        }
        
    }
    return self;
}

-(void)setChoose:(BOOL)choose
{
    _choose = choose;
    
    if(self.section == 0)
    {
        if(choose)
        {
            self.backView.layer.borderColor = KHexRGB(0xEE2520).CGColor;
            self.backView.backgroundColor = KHexRGB(0xFCF4F4);
        }
        else
        {
            self.backView.backgroundColor = [UIColor whiteColor];
            self.backView.layer.borderColor = KRGB(201, 201, 201).CGColor;
        }
        
    }
    else
    {
        if(choose)
        {
            self.chooseImageView.image = KImageName(@"choose");
        }
        else
        {
            self.chooseImageView.image = KImageName(@"notChoose");
        }
    }
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    if(dataDic.count == 0)
    {
        return;
    }
    
    if(self.section == 0)
    {
        if(self.row == 0)
        {
            NSString * oriPrice = [dataDic objectForKey:@"oneOriPrice"];
            NSString * curPrice = [dataDic objectForKey:@"oneCurPrice"];;
            NSString * dayPrice = [dataDic objectForKey:@"oneDayPrice"];;
            self.oriPriceLabel.text = [NSString stringWithFormat:@"¥%@",oriPrice];
            self.dayLabel.text = [NSString stringWithFormat:@"低至¥%@/天",dayPrice];
            self.curPriceLabel.text = [NSString stringWithFormat:@"¥%@",curPrice];
        }
        else if (self.row == 1)
        {
            NSString * oriPrice = [dataDic objectForKey:@"twoOriPrice"];
            NSString * curPrice = [dataDic objectForKey:@"twoCurPrice"];;
            NSString * dayPrice = [dataDic objectForKey:@"twoDayPrice"];;
            self.oriPriceLabel.text = [NSString stringWithFormat:@"¥%@",oriPrice];
            self.dayLabel.text = [NSString stringWithFormat:@"低至¥%@/天",dayPrice];
            self.curPriceLabel.text = [NSString stringWithFormat:@"¥%@",curPrice];
        }
        else
        {
            
            NSString * oriPrice = [dataDic objectForKey:@"threeOriPrice"];
            NSString * curPrice = [dataDic objectForKey:@"threeCurPrice"];;
            NSString * dayPrice = [dataDic objectForKey:@"threeDayPrice"];;
            self.oriPriceLabel.text = [NSString stringWithFormat:@"¥%@",oriPrice];
            self.dayLabel.text = [NSString stringWithFormat:@"低至¥%@/天",dayPrice];
            self.curPriceLabel.text = [NSString stringWithFormat:@"¥%@",curPrice];
        }
        
    }
    else
    {
        
    }
    
}



-(void)setRow:(NSInteger)row
{
    _row = row;
    if(self.section == 0)
    {
        if(row == 0)
        {
            self.yearLabel.text = @"1年VIP会员";
        }
        else if (row == 1)
        {
            self.yearLabel.text = @"2年VIP会员";
        }
        else
        {
            self.yearLabel.text = @"3年VIP会员";
        }
    }
    else
    {
        if(row == 0)
        {
            self.payLabel.text = @"支付宝";
            self.payImageView.image = KImageName(@"iconfontrectangle390");
        }
        else
        {
           self.payLabel.text = @"微信支付";
        self.payImageView.image = KImageName(@"weixin");
        }
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
