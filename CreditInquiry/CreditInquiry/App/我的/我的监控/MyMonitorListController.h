//
//  MyMonitorListController.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    ListTypeMyMonitor = 0,
    ListTypeMyCollection,
} ListType;

@interface MyMonitorListController : BasicViewController
@property (nonatomic ,assign) ListType listType;
@end

NS_ASSUME_NONNULL_END
