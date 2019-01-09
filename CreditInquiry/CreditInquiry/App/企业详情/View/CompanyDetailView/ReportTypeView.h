//
//  ReportTypeView.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/8/9.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportTypeModel;
@protocol ReportTypeDelegate <NSObject>

- (void)didSwitchReportType:(ReportTypeModel *)model;

@end

@interface ReportTypeView : UIView
@property (nonatomic ,strong) NSArray *models;
@property (nonatomic ,weak) id<ReportTypeDelegate>delegate;
@end

