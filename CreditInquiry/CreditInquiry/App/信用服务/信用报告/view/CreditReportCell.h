//
//  CreditReportCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CreditReportCellDelegate <NSObject>

- (void)didClickPreviewButton:(int)cellType;
- (void)didClickSendReportButton:(int)cellType;

@end

@interface CreditReportCell : UITableViewCell
@property (nonatomic ,weak) id <CreditReportCellDelegate>delegate;
@property (nonatomic ,strong) NSDictionary *reportInfo;
@end

NS_ASSUME_NONNULL_END
