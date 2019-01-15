//
//  MyMonitorCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MyMonitorListModel;
@interface MyMonitorCell : UITableViewCell
@property (nonatomic ,strong) MyMonitorListModel *model;

@end

NS_ASSUME_NONNULL_END
