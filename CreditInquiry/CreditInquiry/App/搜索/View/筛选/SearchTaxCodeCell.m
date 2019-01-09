//
//  SearchTaxCodeCell.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2017/12/28.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import "SearchTaxCodeCell.h"

@interface SearchTaxCodeCell()
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) UIView *shadowView;

@end

@implementation SearchTaxCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.shadowView = ({
            UIView *shadowView = [UIView new];
            [self.contentView addSubview:shadowView];
            [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 15, 2, 15));//这里显示上下间隔为8防止阴影超出frame导致渲染异常
            }];
            shadowView.backgroundColor = [UIColor whiteColor];
            shadowView.layer.shadowColor =  [UIColor lightGrayColor].CGColor;;
            shadowView.layer.shadowOffset = CGSizeMake(0.1, 0.1);//0,-3
            shadowView.layer.shadowRadius = 2;
            shadowView.layer.shadowOpacity = 0.8;
            shadowView.layer.cornerRadius = 5;
            shadowView;
        });
        
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [_shadowView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_shadowView).offset(20);
                make.left.mas_equalTo(_shadowView).offset(15);
                make.right.mas_equalTo(_shadowView).offset(-15);
            }];
            view.font = KFont(16);
            view.textColor = KHexRGB(0xfc6200);
            view;
        });
        
        UILabel *taxTitle = [UILabel new];
        [_shadowView addSubview:taxTitle];
        [taxTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);
            make.left.mas_equalTo(_nameLab);
            make.bottom.mas_equalTo(_shadowView.mas_bottom).offset(-20);
        }];
        taxTitle.font = KFont(14);
        taxTitle.textColor = KHexRGB(0x919191);
        taxTitle.text = @"纳税人识别号：";
        
        self.codeLab = ({
            UILabel *view = [UILabel new];
            [_shadowView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(taxTitle.mas_right);
                make.top.mas_equalTo(taxTitle);
            }];
            view.font = KFont(14);
            view;
        });
        
        //小箭头
        UIImageView *arrowIcon = [UIImageView new];
        arrowIcon.image = KImageName(@"canTouchIcon");
        [_shadowView addSubview:arrowIcon];
        [arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_shadowView).offset(-15);
            make.centerY.mas_equalTo(_shadowView);
        }];
        
    }
    return self;
}

- (void)setModel:(SearchTaxCodeModel *)model{
    _model = model;
    
    _nameLab.text = model.companyname;
    _codeLab.text = model.identifierid;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

