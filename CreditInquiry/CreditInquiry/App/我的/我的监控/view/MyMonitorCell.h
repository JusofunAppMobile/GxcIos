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

@protocol MyMonitorCellDelegate <NSObject>
- (void)didClickMonitorButton:(MyMonitorListModel *)model cell:(UITableViewCell*)cell;
@end

@interface MyMonitorCell : UITableViewCell
@property (nonatomic ,weak) id <MyMonitorCellDelegate> delegate;
@property (nonatomic ,strong) UIButton *monitorBtn;

- (void)setModel:(MyMonitorListModel *)model type:(ListType)type;
- (void)setMonitorButtonState:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
