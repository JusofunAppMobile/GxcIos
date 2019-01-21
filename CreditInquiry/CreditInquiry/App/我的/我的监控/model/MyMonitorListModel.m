//
//  MyMonitorListModel.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/15.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyMonitorListModel.h"

@implementation MyMonitorListModel

- (NSString *)companyName{
    if (_companyName) {
        return _companyName;
    }
    return _companyname;
}

- (NSString *)companyId{
    if (_companyId) {
        return _companyId;
    }
    return _companyid;
}

- (NSString *)companyname{
    if (_companyname) {
        return _companyname;
    }
    return _companyName;
}

- (NSString *)companyid{
    if (_companyid) {
        return _companyid;
    }
    return _companyId;
}

@end
