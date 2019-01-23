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

@protocol MyOrderReportCellDelegate <NSObject>

- (void)didClickCheckReportButton:(MyOrderModel *)model;
- (void)didClickSendReportButton:(MyOrderModel *)model;
@end

@interface MyOrderReportCell : UITableViewCell
@property (nonatomic ,strong) MyOrderModel *model;
@property (nonatomic ,weak) id <MyOrderReportCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
