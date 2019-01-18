//
//  ObjectionModel.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/18.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ObjectionModel.h"
#import "ObjectionMenuModel.h"
@implementation ObjectionModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"menuList":ObjectionMenuModel.class};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"mId":@"id"};
}

@end
