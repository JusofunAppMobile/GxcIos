//
//  MyOrderReportCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MyOrderModel;
@interface MyOrderReportCell : UITableViewCell
@property (nonatomic ,strong) MyOrderModel *model;
@end

NS_ASSUME_NONNULL_END
