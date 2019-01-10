//
//  MyOrderReportCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyOrderReportCell.h"

@interface MyOrderReportCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *statusLab;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) UILabel *orderLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) UILabel *emailLab;
@property (nonatomic ,strong) UILabel *formatLab;
@property (nonatomic ,strong) UIView *footerBg;
@property (nonatomic ,strong) UIView *line2;
@end

@implementation MyOrderReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(13);
            }];
            view.font = KFont(15);
            view.textColor = KHexRGB(0x303030);
            view;
        });
        
        self.statusLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_titleLab);
                make.right.mas_equalTo(-15);
            }];
            view.font = KBlodFont(12);
            view.textColor = KHexRGB(0xe00018);
            view;
        });
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexRGB(0xd9d9d9);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLab.mas_bottom).offset(13);
            make.left.mas_equalTo(13);
            make.right.mas_equalTo(-13);
            make.height.mas_equalTo(1);
        }];
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLab);
                make.top.mas_equalTo(line.mas_bottom).offset(11);
            }];
            view.font = KFont(13);
            view.textColor = KHexRGB(0x303030);
            view.text = @"小米科技有限责任公司";
            view;
        });
        
        self.priceLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_nameLab);
                make.right.mas_equalTo(-15);
            }];
            view.font = KBlodFont(12);
            view.text = @"￥233";
            view.textColor = KHexRGB(0xe00018);
            view;
        });
        
        self.orderLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLab);
                make.top.mas_equalTo(_nameLab.mas_bottom).offset(10);
            }];
            view.font = KFont(13);
            view.text = @"订单编号：1233321312321545";
            view.textColor = KHexRGB(0x878787);
            view;
        });
        
        self.dateLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLab);
                make.top.mas_equalTo(_orderLab.mas_bottom).offset(10);
            }];
            view.font = KFont(13);
            view.text = @"购买时间：2018-12-31 14:21:20";
            view.textColor = KHexRGB(0x878787);
            view;
        });
        
        self.emailLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLab);
                make.top.mas_equalTo(_dateLab.mas_bottom).offset(10);
            }];
            view.font = KFont(13);
            view.text = @"接收邮箱：sadsa222@sina.com";
            view.textColor = KHexRGB(0x878787);
            view;
        });
        
        self.formatLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLab);
                make.top.mas_equalTo(_emailLab.mas_bottom).offset(10);
                make.height.mas_equalTo(14);
            }];
            view.font = KFont(13);
            view.text = @"报告格式：PDF";
            view.textColor = KHexRGB(0x878787);
            view;
        });
        
        self.line2 = ({
            UIView *line2 = [UIView new];
            line2.backgroundColor = KHexRGB(0xd9d9d9);
            [self.contentView addSubview:line2];
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_formatLab.mas_bottom).offset(13);
                make.left.right.height.mas_equalTo(line);
            }];
            line2;
        });
        
        self.footerBg = ({
            UIView *footerBg = [UIView new];
            [self.contentView addSubview:footerBg];
            [footerBg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40);
                make.left.right.bottom.mas_equalTo(self.contentView);
                make.top.mas_equalTo(_line2.mas_bottom);
            }];
            footerBg;
        });
       
        
        UIButton *reportBtn = [UIButton new];
        reportBtn.layer.cornerRadius = 4;
        reportBtn.layer.masksToBounds = YES;
        reportBtn.backgroundColor = KHexRGB(0xd60e23);
        reportBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [reportBtn setTitle:@"查看报告" forState:UIControlStateNormal];
        [_footerBg addSubview:reportBtn];
        [reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_footerBg);
            make.right.mas_equalTo(_footerBg).offset(-15);
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(25);
        }];
        
        
        UIButton *sendBtn = [UIButton new];
        sendBtn.layer.cornerRadius = 4;
        sendBtn.layer.masksToBounds = YES;
        sendBtn.layer.borderWidth = 1;
        sendBtn.layer.borderColor = KHexRGB(0xc8c8c8).CGColor;
        sendBtn.titleLabel.font =[UIFont boldSystemFontOfSize:13];
        [sendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [sendBtn setTitleColor:KHexRGB(0xd93947) forState:UIControlStateNormal];
        [_footerBg addSubview:sendBtn];
        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.height.mas_equalTo(reportBtn);
            make.right.mas_equalTo(reportBtn.mas_left).offset(-10);
        }];
    }
    return self;
}

- (void)setType:(NSInteger)type{
    _type = type;
    if (type == 1) {
        _statusLab.text = @"已生成";
        _titleLab.text = @"VIP会员服务";
        _orderLab.attributedText = [self getAttibuteForText:@"订单编号：1233321312321545"];
        _dateLab.attributedText = [self getAttibuteForText:@"购买时间：2018-12-31 14:21:20"];
        _emailLab.attributedText = [self getAttibuteForText:@"服务时长：12个月"];

        _formatLab.hidden = YES;
        _footerBg.hidden = YES;
        _line2.hidden = YES;
       
        [_formatLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            make.top.mas_equalTo(_emailLab.mas_bottom).offset(0);
        }];
        [_footerBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
    }else{
        _statusLab.text = @"已支付";
        _titleLab.text = @"企业信用报告-专业版";
        _orderLab.attributedText = [self getAttibuteForText:@"订单编号：1233321312321545"];
        _dateLab.attributedText = [self getAttibuteForText:@"购买时间：2018-12-31 14:21:20"];
        _emailLab.attributedText = [self getAttibuteForText:@"接收邮箱：sadsa222@sina.com"];
        _formatLab.attributedText = [self getAttibuteForText:@"订单编号：1233321312321545"];

        _formatLab.hidden = NO;
        _footerBg.hidden = NO;
        _line2.hidden = NO;
       
        [_formatLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(_emailLab.mas_bottom).offset(10);
        }];
        [_footerBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
    }
}


- (NSAttributedString *)getAttibuteForText:(NSString *)str{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:KHexRGB(0x303030) range:NSMakeRange(5, str.length-5)];
    return attr;
}

@end
