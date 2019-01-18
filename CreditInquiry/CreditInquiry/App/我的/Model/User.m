//
//  User.m
//  EnterpriseInquiry
//
//  Created by LEZ on 16/8/12.
//  Copyright © 2016年 王志朋. All rights reserved.
//

#import "User.h"

@implementation User

SingletonM(User);


//+ (NSDictionary *)replacedKeyFromPropertyName{
//    return @{
//             @"userID" : @"userid",
//             @"jobID" : @"jobid",
//             @"focuseUnread" : @"myfocusunread",
//             @"messageUnread" : @"systemmessageunread"
//             };
//}

-(NSString *)userId
{
    if(_userId == nil)
    {
        return @"";
    }
    else
    {
        return _userId;
    }
}


-(NSString *)headIcon
{
    if(!_headIcon)
    {
        return @"";
    }
    else
    {
        return _headIcon;
    }
}

-(NSString *)phone
{
    if(!_phone)
    {
        return @"";
    }
    else
    {
        return _phone;
    }
}




@end
