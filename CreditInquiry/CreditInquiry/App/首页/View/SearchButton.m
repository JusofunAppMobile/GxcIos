//
//  SearchButton.m
//  EnterpriseInquiry
//
//  Created by clj on 16/8/14.
//  Copyright © 2016年 王志朋. All rights reserved.
//

#import "SearchButton.h"

@implementation SearchButton

-(UIImageView *)searchImageView
{
    if (_searchImageView == nil) {
        _searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (self.height - 15)/2.0, 15, 15)];
        _searchImageView.image = [UIImage imageNamed:@"icon_search"];
    }
    return _searchImageView;
}


-(UILabel *)searchLabel
{
    if (_searchLabel == nil) {
        _searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchImageView.frame) + 5,(self.height - 15)/2.0, self.frame.size.width -(CGRectGetMaxX(_searchImageView.frame) + 5)-15 , 15)];
        _searchLabel.textColor = KHexRGB(0xCCCCCC);
        _searchLabel.font = KSmallFont;
        
    }
    return _searchLabel;
}




- (instancetype)initWithFrame:(CGRect)frame andPlaceText:(NSString *)placeText
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
//        self.searchImageView = ({
//            UIImageView *view = [UIImageView new];
//            [self addSubview:view];
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.mas_equalTo(self);
//                make.width.height.mas_equalTo(15);
//                make.left.mas_equalTo(self).offset(20);
//            }];
//            view.image = [UIImage imageNamed:@"icon_search"];
//            view;
//        });
//
//        self.searchLabel = ({
//            UILabel *view = [UILabel new];
//            [self addSubview:view];
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.mas_equalTo(self);
//                make.left.mas_equalTo(self.searchImageView.mas_right).offset(10);
//                make.right.mas_equalTo(self).offset(-20);
//            }];
//            view.textColor = KHexRGB(0x999999);
//            view.font = KFont(13);
//            view;
//        });
//
        
        
        [self addSubview:self.searchImageView];
        [self addSubview:self.searchLabel];
        _searchLabel.text = placeText;
        
    }
    return self;
}



-(void)layoutSubviews
{
    CGPoint center = self.searchImageView.center;
    center.y = self.height/2;
    self.searchImageView.center = center;
    
    CGPoint center2 = self.searchLabel.center;
    center2.y = self.height/2;
    self.searchLabel.center = center2;
}

@end

