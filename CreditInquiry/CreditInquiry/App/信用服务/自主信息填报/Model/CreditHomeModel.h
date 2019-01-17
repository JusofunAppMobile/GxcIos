//
//  CreditHomeModel.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/16.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreditHomeModel : NSObject

@property (nonatomic ,strong) NSDictionary *companyInfo;
@property (nonatomic ,strong) NSArray *serviceList;
@property (nonatomic ,strong) NSArray *inquiryList;
@property (nonatomic ,strong) NSArray *VisitorList;
@end

NS_ASSUME_NONNULL_END
