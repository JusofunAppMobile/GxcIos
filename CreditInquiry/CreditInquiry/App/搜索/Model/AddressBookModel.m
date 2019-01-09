//
//  AddressBookModel.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/5/4.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "AddressBookModel.h"

@implementation AddressBookModel

//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{@"entId":@"id"};
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"companyid":@"id",@"companyname":@"name"};
}
@end
