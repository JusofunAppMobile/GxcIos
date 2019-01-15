//
//  MyOrderReportCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyOrderReportCell.h"
#import "MyOrderModel.h"
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
            view.text = @"订单编号：";
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
            view.text = @"购买时间：";
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
            view.text = @"报告格式：";
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

- (void)setModel:(MyOrderModel *)model{
    _model = model;
    
    _titleLab.text = model.title;
    _nameLab.text = model.name;
    _priceLab.text = [NSString stringWithFormat:@"￥%@",model.money];//test
    _orderLab.attributedText = [self getAttibuteForText:[NSString stringWithFormat:@"订单编号：%@",model.no]];
    _dateLab.attributedText = [self getAttibuteForText:[NSString stringWithFormat:@"购买时间：%@",model.time]];
    
    if ([model.type intValue] == 1) {
        _statusLab.text = model.status.intValue == 0?@"未生成":@"已生成";
        _emailLab.attributedText = [self getAttibuteForText:[NSString stringWithFormat:@"服务时长：%@",model.duration]];
        
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
        _statusLab.text = model.orderState.intValue == 0?@"未支付":@"已支付";//test 0,1?
        _emailLab.attributedText = [self getAttibuteForText:[NSString stringWithFormat:@"接收邮箱：%@",model.email]];
        _formatLab.attributedText = [self getAttibuteForText:[NSString stringWithFormat:@"报告格式：%@",model.format]];
        
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
