//
//  CreditInfoInputCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CreditInfoIuputCellDelegate <NSObject>

- (void)didClickEditButton:(NSInteger)section;

@end

@interface CreditInfoInputCell : UITableViewCell
@property (nonatomic ,weak) id <CreditInfoIuputCellDelegate>delegate;
@property (nonatomic ,assign) NSInteger section;
@end

NS_ASSUME_NONNULL_END
