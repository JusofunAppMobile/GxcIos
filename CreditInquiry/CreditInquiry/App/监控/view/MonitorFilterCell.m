//
//  MonitorFilterCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorFilterCell.h"

@interface MonitorFilterCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@end

@implementation MonitorFilterCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        self.titleLab = ({
//            UILabel *view = [UILabel new];
//            [self.contentView addSubview:view];
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.mas_equalTo(self.contentView);
//            }];
//            view.textAlignment = NSTextAlignmentCenter;
//            view.font = KFont(12);
//            view.backgroundColor = KHexRGB(0xf6f6f6);
//            view.layer.cornerRadius = 4;
//            view.layer.masksToBounds = YES;
//            view;
//        });
        
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderWidth=.5;
        self.layer.cornerRadius = 2;
        self.layer.borderColor=KHexRGB(0xDFE0E1).CGColor;
        
        self.titleBtn = [UIButton new];
        [_titleBtn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        _titleBtn.titleLabel.font = KFont(12);
        [_titleBtn setTitleColor:KHexRGB(0x666666) forState:UIControlStateNormal];
        [_titleBtn setTitleColor:KHexRGB(0xfc6f26) forState:UIControlStateSelected];
        [_titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 3)];
        [self.contentView addSubview:_titleBtn];
        [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        self.iconView = [UIImageView new];
        _iconView.image = KImageName(@"对号");
        _iconView.hidden = YES;
        [_titleBtn addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(_titleBtn);
        }];
        
        
    }
    return self;
}

- (void)itemAction:(UIButton *)button
{
    [self changeState:!button.selected];
    if ([self.delegate respondsToSelector:@selector(selectCollectionViewCell:selected:)]) {
        [self.delegate selectCollectionViewCell:self.dataDic selected:button.selected];
    }

}

- (void)changeState:(BOOL)selected{
    _titleBtn.selected = selected;
    _iconView.hidden = !selected;
    
    if (selected) {
        self.layer.borderColor=KHexRGB(0xfc6f26).CGColor;
    }else{
        self.layer.borderColor=KHexRGB(0xDFE0E1).CGColor;
    }
}


-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    [self.titleBtn setTitle:[dataDic objectForKey:@"monitor_condition_name"] forState:UIControlStateNormal];
}


- (void)setText:(NSString *)text{
    _text = text;
    _titleLab.text = text;
    
    [self.titleBtn setTitle:text forState:UIControlStateNormal];
}

@end
