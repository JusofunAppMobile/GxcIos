//
//  NewsController.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"
#import "NewsCell.h"
#import <SDCycleScrollView.h>
#import "CommonWebViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewsController : BasicViewController<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@end

NS_ASSUME_NONNULL_END
