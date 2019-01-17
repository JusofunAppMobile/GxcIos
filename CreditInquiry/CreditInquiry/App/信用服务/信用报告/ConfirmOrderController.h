//
//  ConfirmOrderController.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderController : BasicViewController
@property (nonatomic ,copy) NSString *reportName;
@property (nonatomic ,copy) NSString *companyName;
@property (nonatomic ,copy) NSString *price;
@property (nonatomic ,assign) BOOL isVip;

@end

NS_ASSUME_NONNULL_END
