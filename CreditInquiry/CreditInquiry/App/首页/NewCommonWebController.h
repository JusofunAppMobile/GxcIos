//
//  NewCommonWebController.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/24.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewCommonWebController : BasicWebViewController

@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *urlStr;
//自主填报
@property (nonatomic ,copy) NSString *companyId;
@property (nonatomic ,copy) NSString *companyName;

@property (nonatomic ,assign) int webType;

//请求url的 参数
@property (nonatomic ,strong) NSDictionary *params;

@end

NS_ASSUME_NONNULL_END
