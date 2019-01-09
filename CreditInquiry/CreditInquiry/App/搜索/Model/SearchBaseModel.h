//
//  SearchBaseModel.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/7/23.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchBaseModel : NSObject
@property (nonatomic ,assign) BOOL selected;//选中导出
@property (nonatomic ,copy) NSString *companyid;
@property (nonatomic ,copy) NSString *companyname;

@end
