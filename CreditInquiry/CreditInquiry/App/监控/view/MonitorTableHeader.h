//
//  MonitorTableHeader.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MonitorTableHeaderDelegate <NSObject>
- (void)didClickFilterButton;
@end

@interface MonitorTableHeader : UIView
@property (nonatomic ,weak) id <MonitorTableHeaderDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
