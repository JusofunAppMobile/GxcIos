//
//  MonitorFilterModel.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/25.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonitorFilterModel : NSObject

@property (nonatomic ,copy) NSString *monitor_condition_id;
@property (nonatomic ,copy) NSString *monitor_condition_name;
@property (nonatomic ,assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
