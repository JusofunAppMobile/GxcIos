//
//  SearchResultWebController.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/24.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"
#import "BasicWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultWebController : BasicWebViewController
@property (nonatomic ,assign) SearchType searchType;
@property (nonatomic ,copy) NSString *companyName;
@end

NS_ASSUME_NONNULL_END
