//
//  HomeMonitorCell.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMonitorCell : UITableViewCell
@property (nonatomic ,strong) UIImageView *logoImageView;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UILabel *contentLabel;
@property (nonatomic ,strong) UILabel *timeLabel;

@property(nonatomic,strong)NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
