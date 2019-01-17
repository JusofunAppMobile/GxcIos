//
//  CreditEditTextCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreditEditTextCell : UITableViewCell

- (void)setContent:(NSMutableDictionary *)data type:(CreditEditType)type editable:(BOOL)editable;
@end

NS_ASSUME_NONNULL_END
