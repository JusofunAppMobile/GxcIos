//
//  MeItemCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MeItemCellDelegate <NSObject>

- (void)didClickItemAtIndex:(NSInteger)index;

@end

@interface MeItemCell : UITableViewCell
@property (nonatomic ,weak) id <MeItemCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
