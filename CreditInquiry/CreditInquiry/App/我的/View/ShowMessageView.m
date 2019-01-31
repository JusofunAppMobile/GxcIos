//
//  ShowMessageView.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ShowMessageView.h"
@interface ShowMessageView ()

@property(nonatomic,strong)UIView*backView;

@property(nonatomic,strong)UIImageView*imageView;

@property(nonatomic,strong)UILabel*titleLabel;

@property(nonatomic,strong)UILabel*contentLabel;


@property(nonatomic,strong)UIButton*button;

@property(nonatomic,strong)UIButton*colseBtn;

@end
@implementation ShowMessageView

-(instancetype)initWithType:(ShowMessageType)showType action:(void (^)(void))action
{
    self = [super initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
        [self addGestureRecognizer:tap];
        
        self.ShowMessageAction = action;
        
        if(showType == ShowMessageCheckType)
        {
            [self checkUpdate];
            
        }
        else
        {
            [KeyWindow addSubview:self];
        }
        
        CGFloat width = 280;
        CGFloat x = (KDeviceW - 280)/2.0;
        width = x>50?(KDeviceW -100):280;
        
        self.backView = ({
            UIView *view = [UIView new];
            [self addSubview:view];
            view.layer.cornerRadius = 5;
            view.clipsToBounds = YES;
            view.backgroundColor = [UIColor whiteColor];
            
            view;
        });
        
        self.imageView = ({
            UIImageView *view = [UIImageView new];
            [self.backView addSubview:view];
            if(showType == ShowMessageVIPType)
            {
                view.image = KImageName(@"tanchuang_pic_vip");
            }
            else if(showType == ShowMessageAutiType)
            {
                view.image = KImageName(@"tanchuang_pic_renzheng");
            }
            else
            {
                view.image = KImageName(@"tanchuang_pic_gengxin");
            }
           // view.contentMode = UIViewContentModeScaleAspectFit;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.backView).offset(-1);
                make.width.mas_equalTo(self.backView);
                make.centerX.mas_equalTo(self.backView);
            }];
            view;
        });
        
        self.titleLabel = ({
            UILabel *view = [UILabel new];
            [self.backView addSubview:view];
            view.textColor = KRGB(153, 153, 153);
            view.font = KFont(14);
            view.textAlignment = NSTextAlignmentCenter;
            if(showType == ShowMessageVIPType)
            {
                view.text = @"开通VIP后获得权限";
            }
            else if(showType == ShowMessageAutiType)
            {
                view.text = @"认证后后获得权限";
            }
            else
            {
                
            }
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.imageView.mas_bottom).offset(25);
                make.centerX.mas_equalTo(self.backView);
                make.width.mas_equalTo(self.backView);
            }];
            view;
        });
        
        self.contentLabel = ({
            UILabel *view = [UILabel new];
            [self.backView addSubview:view];
            view.textColor = KRGB(0, 0, 0);
            view.font = KFont(13);
            view.numberOfLines = 0;
            //view.textAlignment = NSTextAlignmentCenter;
            if(showType == ShowMessageVIPType)
            {
                view.text = @"· 查看企业关系图，透视公司关联关系\n· 查看企业股权关系图，清晰企业股权结构\n· 获得专业政府认证企业信用分\n";
            }
            else if(showType == ShowMessageAutiType)
            {
                view.text = @"· 官方信息维护，展现企业全貌\n· 专属认证标识，彰显企业商誉\n· 实时访客查询，挖掘企业商机\n· 专业企业报告，助力企业管理";
            }
            else{
                view.text = @"";
            }
            
            [self setContent:view.text];
            
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineSpacing = 10 ;
            NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
            [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
            view.attributedText = [[NSAttributedString alloc] initWithString:view.text attributes:attributes];

            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
                make.left.mas_equalTo(self.backView).offset(20);
                make.right.mas_equalTo(self.backView).offset(-20);
                
            }];
            view;
        });
        
        self.button = ({
            UIButton *view = [UIButton new];
            [self.backView addSubview:view];
            if(showType == ShowMessageVIPType)
            {
                [view setTitle:@"立即开通" forState:UIControlStateNormal];
            }
            else if(showType == ShowMessageAutiType)
            {
                [view setTitle:@"前往认证" forState:UIControlStateNormal];
            }
            else
            {
                [view setTitle:@"立即更新" forState:UIControlStateNormal];
            }
            [view addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            view.backgroundColor = KHexRGB(0xDF242C);
            view.layer.cornerRadius = 5;
            view.clipsToBounds = YES;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(30);
                make.height.mas_equalTo(40);
                make.left.mas_equalTo(self.backView).offset(50);
                make.right.mas_equalTo(self.backView).offset(-50);
            }];
            view;
        });
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).offset(-10);
            make.centerX.mas_equalTo(self);
            
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(self.button.mas_bottom).offset(30);
        }];
        
        self.colseBtn = ({
            UIButton *view = [UIButton new];
            [self addSubview:view];
            [view addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
            [view setImage:KImageName(@"tanchuang_icon_close") forState:UIControlStateNormal];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.backView.mas_bottom).offset(40);
            
                make.centerX.mas_equalTo(self);
            }];
            view;
        });
        
    }

    return self;
}


-(void)checkUpdate
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",KAppleID];
    [RequestManager QXBGetWithURLString:urlStr parameters:nil success:^(id responseObject) {
        // NSLog(@"%@",responseObject);
        
        NSArray *dataArray = [responseObject objectForKey:@"results"];
        if(dataArray.count >0)
        {
            NSDictionary *dic = [dataArray objectAtIndex:0];
            NSString *appStoreVersion = dic[@"version"];
            appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            
            NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            appVersion = [appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            if([appStoreVersion intValue]>[appVersion intValue])
            {
                self.titleLabel.text = [NSString stringWithFormat:@"版本功能(V%@)",dic[@"version"]];
                [self setContent:[dic objectForKey:@"releaseNotes"]];
                
                [KeyWindow addSubview:self];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)setContent:(NSString*)contentStr
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 10 ;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.contentLabel.attributedText = [[NSAttributedString alloc] initWithString:contentStr attributes:attributes];
}


-(void)close:(UITapGestureRecognizer*)tap
{
    CGPoint selectPoint = [tap locationInView:self];
    if(!CGRectContainsPoint(self.backView.frame, selectPoint)){
        
        [self close];
        
    }
}

-(void)close
{
    [self performSelector:@selector(removeFromSuperview) withObject:nil];
}


-(void)buttonClick
{
    [self close];
    if(self.ShowMessageAction)
    {
        self.ShowMessageAction();
    }
}



@end
