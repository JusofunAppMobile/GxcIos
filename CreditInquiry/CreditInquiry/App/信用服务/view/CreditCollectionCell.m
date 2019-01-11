//
//  CreditCollectionCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditCollectionCell.h"
#import <UIButton+LXMImagePosition.h>

@implementation CreditCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
                
        UIButton *view = [UIButton new];
        view.enabled = NO;
        [view setImage:KImageName(@"icon_shuiwu") forState:UIControlStateNormal];
        [view setTitle:@"税务案件" forState:UIControlStateNormal];
        [view setTitleColor:KHexRGB(0x303030) forState:UIControlStateNormal];
        view.titleLabel.font = KFont(14);
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(20, 0, 0, 0));
        }];
        [self layoutIfNeeded];
        [view setImagePosition:LXMImagePositionTop spacing:5];
    }
    return self;
}

@end
