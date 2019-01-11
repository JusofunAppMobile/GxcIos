//
//  MonitorDetailHeader.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MonitorDetailHeaderDelegate <NSObject>

- (void)didClickMoreButton:(NSInteger)section;

@end

@interface MonitorDetailHeader : UITableViewHeaderFooterView
@property (nonatomic ,assign) NSInteger section;
@property (nonatomic ,weak) id <MonitorDetailHeaderDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
