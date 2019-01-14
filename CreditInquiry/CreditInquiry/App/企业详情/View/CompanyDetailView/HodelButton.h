//
//  HodelButton.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HodelButton : UIButton

@property(nonatomic,strong)UIImageView *nameImageView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *jobLabel;

@property(nonatomic,strong)UILabel *contentLabel;


@end

@interface HodelMoreButton : UIButton

@property(nonatomic,strong)UIImageView *nameImageView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UIView *lineView;

@end

NS_ASSUME_NONNULL_END
