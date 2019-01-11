//
//  ObjectionItem.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ObjectionItem.h"



@implementation ObjectionItem

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = KHexRGB(0xd4d4d4).CGColor;
        self.layer.borderWidth = .5;
        self.layer.cornerRadius = 4.5;
        self.layer.masksToBounds = YES;
        self.titleLabel.font = KFont(13);
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self setTitleColor:KHexRGB(0x303030) forState:UIControlStateNormal];

    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = KHexRGB(0xd7001b);
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = KHexRGB(0xd4d4d4).CGColor;
    }
}




@end
