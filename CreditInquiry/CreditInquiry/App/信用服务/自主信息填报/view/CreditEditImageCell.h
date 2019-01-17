//
//  CreditEditImageCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CreditEditImageCellDelegate <NSObject>

- (void)didClickAddImageView;

@end

@interface CreditEditImageCell : UITableViewCell
@property (nonatomic ,weak) id <CreditEditImageCellDelegate>delegate;
- (void)setContent:(NSMutableDictionary *)data type:(CreditEditType)type;

@end

NS_ASSUME_NONNULL_END
