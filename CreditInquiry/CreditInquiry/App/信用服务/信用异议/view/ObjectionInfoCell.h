//
//  ObjectionInfoCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ObjectionModel;
@class ObjectionMenuModel;

@protocol ObjectionInfoCellDelegate <NSObject>

- (void)infoCellDidClickMenu:(ObjectionMenuModel *)menuModel select:(BOOL)select;
- (void)infoCellDidEndEditing:(NSDictionary *)params;
@end

@interface ObjectionInfoCell : UITableViewCell
- (void)setModel:(ObjectionModel *)model type:(ObjectionType)objectionType;
@property (nonatomic ,weak) id <ObjectionInfoCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
