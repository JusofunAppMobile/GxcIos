//
//  CreditHomeModel.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/16.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditHomeModel.h"
#import "CreditServiceModel.h"
#import "CreditVisitorModel.h"

@implementation CreditHomeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"serviceList":CreditServiceModel.class,@"inquiryList":CreditServiceModel.class,@"VisitorList":CreditVisitorModel.class};
}

@end
