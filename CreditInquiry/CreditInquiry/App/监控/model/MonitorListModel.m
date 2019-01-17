//
//  MonitorListModel.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/4.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorListModel.h"

@implementation MonitorListModel

-(NSString *)changeCount
{
    if(_changeCount)
    {
        return _changeCount;
    }
    else
    {
        return @"0";
    }
}



@end
