//
//  HomeViewController.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/3.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"
#import "HomeHeaderView.h"
#import "HomeSectionHeader.h"
#import "SearchController.h"
#import "HomeMonitorCell.h"
#import "NewsCell.h"
#import "SeekRelationController.h"
#import "RiskVipController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : BasicViewController<UITableViewDelegate,UITableViewDataSource,HomeHeaderViewDelegate,SectionHeaderDelegate>

@property (nonatomic ,strong) UITableView *tableview;

@property (nonatomic ,strong) SearchButton *naviSearchView;

@property (nonatomic ,strong) NSDate *firstDate;

@end

NS_ASSUME_NONNULL_END
