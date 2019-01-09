//
//  ReportTypeCell.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/8/9.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportTypeModel;
@interface ReportTypeCell : UITableViewCell

- (void)setModel:(ReportTypeModel *)model hideLine:(BOOL)hide;
@end
