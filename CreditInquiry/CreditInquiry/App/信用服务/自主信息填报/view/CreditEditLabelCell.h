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

- (void)setContent:(NSMutableDictionary *)data row:(NSInteger)row editType:(CreditEditType)type enable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
