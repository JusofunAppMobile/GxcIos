//
//  MyOrderModel.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/15.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderModel : NSObject
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *type;
@property (nonatomic ,copy) NSString *status;
@property (nonatomic ,copy) NSString *no;
@property (nonatomic ,copy) NSString *time;
@property (nonatomic ,copy) NSString *duration;
@property (nonatomic ,copy) NSString *email;
@property (nonatomic ,copy) NSString *format;
@property (nonatomic ,copy) NSString *url;
@property (nonatomic ,copy) NSString *money;
@property (nonatomic ,copy) NSString *orderState;

@end

NS_ASSUME_NONNULL_END
