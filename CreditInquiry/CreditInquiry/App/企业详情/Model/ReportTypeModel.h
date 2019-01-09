//
//  ReportTypeModel.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/8/9.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportTypeModel : NSObject

@property (nonatomic ,copy) NSString *type;//1.企业报告 2.股权结构分析报告 3.企业风险监控分析报告
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *icon;
@end
