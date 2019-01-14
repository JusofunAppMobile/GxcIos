//
//  MDSectionModel.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDSectionModel : NSObject
@property (nonatomic ,copy) NSString *total;
@property (nonatomic ,copy) NSString *icon;//1：变更信息    2：警示信息 3：利好信息
@property (nonatomic ,strong) NSArray *data;//监控条目内容
@property (nonatomic ,copy) NSString *monitor_name;
@end

NS_ASSUME_NONNULL_END
