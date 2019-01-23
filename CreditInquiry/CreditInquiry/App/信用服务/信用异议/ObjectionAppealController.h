//
//  ObjectionAppealController.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObjectionAppealController : BasicViewController
@property (nonatomic ,assign) ObjectionType objectionType;
@property (nonatomic ,strong) NSDictionary *companyInfo;
@end

NS_ASSUME_NONNULL_END
