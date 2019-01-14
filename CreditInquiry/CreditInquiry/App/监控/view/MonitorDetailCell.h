//
//  MonitorDetailCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MonitorDetailModel;
@interface MonitorDetailCell : UITableViewCell
@property (nonatomic ,strong) MonitorDetailModel *model;
@end

NS_ASSUME_NONNULL_END
