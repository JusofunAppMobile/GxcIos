//
//  CreditCollectionCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditCollectionCell.h"
#import <UIButton+LXMImagePosition.h>
#import "CreditServiceModel.h"
#import <UIButton+AFNetworking.h>

@interface CreditCollectionCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *cellButotn;
@end
@implementation CreditCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.cellButotn = ({
            UIButton *view = [UIButton new];
            view.titleLabel.font = KFont(14);
            view.enabled = NO;
            [view setImage:KImageName(@"icon_shuiwu") forState:UIControlStateNormal];
            [view setTitle:@"税务案件" forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0x303030) forState:UIControlStateNormal];
//            [view addTarget:self action:@selector(cellAction) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(20, 0, 0, 0));
            }];
            view;
        });
        
//        self.iconView = ({
//            UIImageView *view = [UIImageView new];
//            [self.contentView addSubview:view];
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self.contentView).offset(20);
//                make.centerX.mas_equalTo(self.contentView);
//                make.height.mas_equalTo(30);
//            }];
//            view.contentScaleFactor = scale
//            view;
//        });
////
//        self.titleLab = ({
//            UILabel *view = [UILabel new];
//            [self.contentView addSubview:view];
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(_iconView.mas_bottom).offset(5);
//                make.centerX.mas_equalTo(self.contentView);
//            }];
//            view.font = KFont(14);
//            view;
//        });
//
        
    }
    return self;
}

- (void)cellAction{
    NSLog(@"点击");
}

- (void)setModel:(CreditServiceModel *)model{
    [_cellButotn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.menuImage]];
    [_cellButotn setTitle:model.menuName forState:UIControlStateNormal];

//    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.menuImage]];
//    _titleLab.text = model.menuName;
    
    [self layoutIfNeeded];

    [_cellButotn setImagePosition:LXMImagePositionTop spacing:5];
//    [_cellButotn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.menuImage]];
}

@end
