//
//  CreditReportCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditReportCell.h"


@interface CreditReportCell ()
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) UILabel *timesLab;
@property (nonatomic ,strong) UILabel *contentLab;
@end

@implementation CreditReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *contentBg = [UIView new];
        contentBg.layer.cornerRadius = 2;
        contentBg.layer.masksToBounds = YES;
        contentBg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentBg];
        [contentBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        
        self.priceLab = ({
            UILabel *view = [UILabel new];
            [contentBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(contentBg).offset(20);
                make.right.mas_equalTo(contentBg).offset(-20);
            }];
            view.font = KFont(12);
            view.textColor = KHexRGB(0xf77f00);
            view.text = @"$50";
            view;
        });
        
        NSString *title = @"企业信用报告-标准版";
        NSArray *component = [title componentsSeparatedByString:@"-"];
        NSRange rangeName = [title rangeOfString:component[1]];
        
        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:title];
        [attr addAttribute:NSForegroundColorAttributeName
                     value:KHexRGB(0xf77f00)
                     range:rangeName];

        self.nameLab = ({
            UILabel *view = [UILabel new];
            [contentBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(contentBg).offset(20);
                make.left.mas_equalTo(contentBg).offset(20);
                make.right.mas_lessThanOrEqualTo(_priceLab.mas_left).offset(-10);
            }];
            view.font = KFont(15);
            view.attributedText = attr;
            view;
        });
        
        self.timesLab = ({
            UILabel *view = [UILabel new];
            [contentBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_nameLab);
                make.top.mas_equalTo(_nameLab.mas_bottom).offset(10);
            }];
            view.text = @"今天剩余50次下载机会";
            view.font = KFont(13);
            view.textColor = KHexRGB(0x505050);
            view;
        });
        
        NSString *str = @"报告内容包括:\n1.基本工商、股东、司法风险信息\n2.知识产权、经营状况及企业年报";
        NSMutableParagraphStyle * mParagraphStyle = [[NSMutableParagraphStyle  alloc] init];
        mParagraphStyle.lineSpacing = 15;
    
        NSMutableAttributedString * mAttribute = [[NSMutableAttributedString alloc] initWithString:str];
        [mAttribute addAttribute:NSParagraphStyleAttributeName
                           value:mParagraphStyle
                           range:NSMakeRange(0, str.length)];
        
        self.contentLab = ({
            UILabel *view = [UILabel new];
            [contentBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_timesLab);
                make.top.mas_equalTo(_timesLab.mas_bottom).offset(15);
            }];
            view.font = KFont(14);
            view.textColor = KHexRGB(0x505050);
            view.numberOfLines = 0;
            view.attributedText = mAttribute;
            view;
        });
        
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexRGB(0xdadada);
        [contentBg addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(contentBg);
            make.top.mas_equalTo(_contentLab.mas_bottom).offset(20);
            make.height.mas_equalTo(1);
        }];
        
        UIButton *reportBtn = [UIButton new];
        reportBtn.layer.cornerRadius = 2;
        reportBtn.layer.masksToBounds = YES;
        reportBtn.backgroundColor = KHexRGB(0xd60e23);
        reportBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [reportBtn setTitle:@"获取报告" forState:UIControlStateNormal];
        [reportBtn addTarget:self action:@selector(sendReportAction) forControlEvents:UIControlEventTouchUpInside];
        [contentBg addSubview:reportBtn];
        [reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            make.right.bottom.mas_equalTo(contentBg).offset(-10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(29);
        }];
        
        
        UIButton *preViewBtn = [UIButton new];
        preViewBtn.layer.cornerRadius = 2;
        preViewBtn.layer.masksToBounds = YES;
        preViewBtn.layer.borderWidth = 1;
        preViewBtn.layer.borderColor = KHexRGB(0xd93947).CGColor;
        preViewBtn.titleLabel.font =[UIFont boldSystemFontOfSize:12];
        [preViewBtn setTitle:@"样本预览" forState:UIControlStateNormal];
        [preViewBtn setTitleColor:KHexRGB(0xd93947) forState:UIControlStateNormal];
        [preViewBtn addTarget:self action:@selector(previewAction) forControlEvents:UIControlEventTouchUpInside];
        [contentBg addSubview:preViewBtn];
        [preViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.height.mas_equalTo(reportBtn);
            make.right.mas_equalTo(reportBtn.mas_left).offset(-15);
        }];
        
    }
    return self;
}

- (void)sendReportAction{
    if ([self.delegate respondsToSelector:@selector(didClickSendReportButton)]) {
        [self.delegate didClickSendReportButton];
    }
    
}

- (void)previewAction{
    if ([self.delegate respondsToSelector:@selector(didClickPreviewButton)]) {
        [self.delegate didClickSendReportButton];
    }
}


@end
