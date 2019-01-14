//
//  MonitorListModel.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/4.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonitorListModel : NSObject
@property (nonatomic ,copy) NSString *companyName;
@property (nonatomic ,copy) NSString *companyId;
@property (nonatomic ,copy) NSString *changeNum;
@property (nonatomic ,copy) NSString *changeDate;
@property (nonatomic ,copy) NSString *isUserMonitor;
@property (nonatomic ,copy) NSString *companyIcon;
@end

NS_ASSUME_NONNULL_END
