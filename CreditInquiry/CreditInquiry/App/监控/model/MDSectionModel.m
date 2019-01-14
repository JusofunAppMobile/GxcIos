//
//  MDSectionModel.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MDSectionModel.h"
#import "MonitorDetailModel.h"

@implementation MDSectionModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":MonitorDetailModel.class};
}
@end
