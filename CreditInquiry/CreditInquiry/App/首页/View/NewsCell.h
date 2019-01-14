//
//  NewsCell.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

//
typedef NS_ENUM(NSInteger, NewsType) {
    NewsNomalType = 0,
    NewsOneImageType ,
    NewsMoreImageType
};

NS_ASSUME_NONNULL_BEGIN

@interface NewsCell : UITableViewCell

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIImageView *imageView1;

@property (nonatomic ,strong) UIImageView *imageView2;

@property (nonatomic ,strong) UIImageView *imageView3;

@property (nonatomic ,assign)NewsType newsType;

@property(nonatomic,strong)NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
