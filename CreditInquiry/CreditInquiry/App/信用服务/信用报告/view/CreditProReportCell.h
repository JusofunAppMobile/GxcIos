//
//  CreditProReportCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditReportCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface CreditProReportCell : UITableViewCell
@property (nonatomic ,strong) NSDictionary *reportInfo;
@property (nonatomic ,weak) id <CreditReportCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
