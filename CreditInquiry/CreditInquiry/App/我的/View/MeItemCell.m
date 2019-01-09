//
//  MeItemCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MeItemCell.h"
#import <UIButton+LXMImagePosition.h>
#define BASE_TAG 2019

@implementation MeItemCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSArray *icons = @[@"mine_dingdan",@"mine_jiankong",@"mine_shoucang",
                           @"mine_renzheng",@"mine_tequan",@"mine_zengsong"];
        NSArray *titles = @[@"我的订单",@"我的监控",@"我的收藏",@"认证企业",@"VIP特权",
                            @"赠送好友VIP"];
        
        CGFloat width = (KDeviceW -15*2)/4;
        CGFloat height = 50;
        CGFloat lineSpace = 17;
        for (int i = 0; i<6; i++) {
            UIButton *item = [[UIButton alloc]initWithFrame:KFrame(width*(i%4), 20+(i/4)*(height+lineSpace), width, 50)];
            item.tag = BASE_TAG+i;
            item.titleLabel.font = KFont(14);
            [item setTitleColor:KHexRGB(0x303030) forState:UIControlStateNormal];
            [item setTitle:titles[i] forState:UIControlStateNormal];
            [item setImage:KImageName(icons[i]) forState:UIControlStateNormal];
            [item setImagePosition:LXMImagePositionTop spacing:10];
            [item addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:item];
        }
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didClickItemAtIndex:)]) {
        [self.delegate didClickItemAtIndex:sender.tag-BASE_TAG];
    }
}


@end
