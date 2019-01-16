//
//  NewsCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        self.imageView1 = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = KImageName(@"home_LoadingPic");
            [self.contentView addSubview:imageView];
            imageView.hidden = YES;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.height.width.mas_equalTo(0);


            }];
            imageView;
        });

        self.imageView2 = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = KImageName(@"home_LoadingPic");
            [self.contentView addSubview:imageView];
            imageView.hidden = YES;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.top.height.width.mas_equalTo(0);


            }];
            imageView;
        });

        self.imageView3 = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = KImageName(@"home_LoadingPic");
            [self.contentView addSubview:imageView];
            imageView.hidden = YES;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.top.height.width.mas_equalTo(0);
            }];
            imageView;
        });
        
        self.nameLabel = ({
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.font = KFont(16);
            nameLabel.numberOfLines = 0 ;
            nameLabel.text = @"全面降准背后房价新周期来临？专家：房价下跌、探底主趋势不会变";
            [self.contentView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(15);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.height.mas_equalTo(40);
                
            }];
            nameLabel;
        });
        
        self.timeLabel = ({
            UILabel *timeLabel = [[UILabel alloc]init];
            timeLabel.textColor = KRGB(153, 153, 153);
            timeLabel.font = KFont(12);
            timeLabel.text = @"福州政府网   今天18：00";
            [self.contentView addSubview:timeLabel];
            [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(15);
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15); make.right.mas_equalTo(self.contentView).offset(-15); make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20).priorityHigh();
                
            }];
            timeLabel;
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


-(void)layoutSubviews
{
   
   CGFloat imageWidth = (KDeviceW -30-20)/3.0;
    if(_newsType == NewsMoreImageType)
    {

        self.imageView1.hidden = NO;
        self.imageView2.hidden = NO;
        self.imageView3.hidden = NO;
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(40).priorityHigh();

        }];

        [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            make.width.mas_equalTo(imageWidth);
            make.height.mas_equalTo(70);

        }];
        [self.imageView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView1.mas_right).offset(10);
            make.top.height.width.mas_equalTo(self.imageView1);

        }];
        [self.imageView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView2.mas_right).offset(10);
            make.top.height.width.mas_equalTo(self.imageView1);

        }];

        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(15); make.top.mas_equalTo(self.imageView3.mas_bottom).offset(15); make.right.mas_equalTo(self.contentView).offset(-15); make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20).priorityHigh();

        }];

    }
    else if (_newsType == NewsOneImageType)
    {
        self.imageView1.hidden = NO;
        self.imageView2.hidden = YES;
        self.imageView3.hidden = YES;

        [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(imageWidth);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(70);
           
        }];
    
        [self.imageView2 mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.left.top.height.width.mas_equalTo(0);

        }];
        [self.imageView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.top.height.width.mas_equalTo(0);

        }];

        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.right.mas_equalTo(self.imageView1.mas_left).offset(-15);
            make.height.mas_equalTo(40).priorityHigh();

        }];
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(15); make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20).priorityHigh();

        }];
    }
    else if (_newsType == NewsOnlyImageType)
    {
        self.imageView1.hidden = NO;
        self.timeLabel.hidden = YES;
        self.nameLabel.hidden = YES;
        [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.width.mas_equalTo(KDeviceW - 30);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.top.left.mas_equalTo(15);
            make.height.mas_equalTo(70);
            make.bottom.mas_equalTo(self.contentView).offset(-15);
            
        }];
    }
    else
    {
        self.imageView1.hidden = YES;
        self.imageView2.hidden = YES;
        self.imageView3.hidden = YES;
        [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.top.height.width.mas_equalTo(0);
        }];
        [self.imageView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.top.height.width.mas_equalTo(0);

        }];
        [self.imageView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.top.height.width.mas_equalTo(0);

        }];
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(40);

        }];

        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15); make.right.mas_equalTo(self.contentView).offset(-15); make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20).priorityHigh();

        }];
    }
}
 
-(void)setNewsType:(NewsType)newsType
{
    _newsType = newsType;
    
    [self layoutIfNeeded];
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    _nameLabel.text = [dataDic objectForKey:@"newsName"];
    _timeLabel.text = [NSString stringWithFormat:@"%@   %@",[dataDic objectForKey:@"newsFrom"],[dataDic objectForKey:@"newsTime"]];
    
    NSArray *imageArray = [dataDic objectForKey:@"newsImage"];
    if(imageArray.count >= 2)
    {
        self.newsType = NewsMoreImageType;
        [_imageView1 sd_setImageWithURL:[NSURL URLWithString:imageArray[0]] placeholderImage:KImageName(@"home_LoadingPic")];
        [_imageView2 sd_setImageWithURL:[NSURL URLWithString:imageArray[1]] placeholderImage:KImageName(@"home_LoadingPic")];
        if(imageArray.count>=3)
        {
            [_imageView3 sd_setImageWithURL:[NSURL URLWithString:imageArray[2]] placeholderImage:KImageName(@"home_LoadingPic")];
        }
        
    }
    else if (imageArray.count == 1)
    {
        self.newsType = NewsOneImageType;
        [_imageView1 sd_setImageWithURL:[NSURL URLWithString:imageArray[0]] placeholderImage:KImageName(@"home_LoadingPic")];
    }
    else
    {
        self.newsType = NewsNomalType;
    }
    
    if([[dataDic objectForKey:@"newsType"] intValue] == 1)//直连
    {
        self.newsType = NewsOnlyImageType;
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
