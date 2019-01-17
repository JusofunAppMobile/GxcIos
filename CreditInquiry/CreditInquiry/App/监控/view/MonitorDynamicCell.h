//
//  MonitorDynamicCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MonitorListModel;
@protocol MonitorDynamicCellDelegate <NSObject>

- (void)didClickMonitorButton:(MonitorListModel *)model cell:(UITableViewCell*)cell;

@end

@interface MonitorDynamicCell : UITableViewCell

@property (nonatomic ,strong) UIButton *monitorBtn;
@property (nonatomic ,weak) id <MonitorDynamicCellDelegate>delegate;
@property (nonatomic ,strong) MonitorListModel *model;


- (void)setMonitorButtonState:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
