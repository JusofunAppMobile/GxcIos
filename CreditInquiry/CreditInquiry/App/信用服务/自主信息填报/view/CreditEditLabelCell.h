//
//  CreditEditLabelCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface CreditEditLabelCell : UITableViewCell

@property (nonatomic ,assign) BOOL canEdit;
- (void)setContent:(id)content row:(NSInteger)row editType:(CreditEditType)type;

@end

NS_ASSUME_NONNULL_END
