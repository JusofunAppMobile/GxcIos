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
            view.text = @"企业信用报告-专业版";
            view;
        });
        
        self.statusLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(13);
                make.right.mas_equalTo(-15);
            }];
            view.font = KFont(12);
            view.textColor = KHexRGB(0xe00018);
            view.text = @"已生成";
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
            }];
            view.font = KFont(13);
            view.text = @"报告格式：PDF";
            view.textColor = KHexRGB(0x878787);
            view;
        });
        
        
        UIView *line2 = [UIView new];
        line2.backgroundColor = KHexRGB(0xd9d9d9);
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_formatLab.mas_bottom).offset(13);
            make.left.right.height.mas_equalTo(line);
        }];
        
        self.footerBg = ({
            UIView *footerBg = [UIView new];
            [self.contentView addSubview:footerBg];
            [footerBg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40);
                make.left.right.bottom.mas_equalTo(self.contentView);
                make.top.mas_equalTo(line2.mas_bottom);
            }];
            footerBg;
        });
       
        
        UIButton *reportBtn = [UIButton new];
        reportBtn.layer.cornerRadius = 2;
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
        sendBtn.layer.cornerRadius = 2;
        sendBtn.layer.masksToBounds = YES;
        sendBtn.layer.borderWidth = 1;
        sendBtn.layer.borderColor = KHexRGB(0xd93947).CGColor;
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

@end
