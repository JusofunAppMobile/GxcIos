//
//  MonitorFilterCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonitorFilterModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MonitorCellDelegate <NSObject>

- (void)selectCollectionViewCell:(MonitorFilterModel *)model selected:(BOOL)isSelected;


@end

@interface MonitorFilterCell : UICollectionViewCell

@property(nonatomic,weak)id<MonitorCellDelegate>delegate;

@property (nonatomic ,copy) NSString *text;

@property (nonatomic ,strong) UIView *selectedView;
@property (nonatomic ,strong) UIButton *titleBtn;
@property (nonatomic ,strong) UIImageView *iconView;

@property(nonatomic,strong)MonitorFilterModel *model;


@end

NS_ASSUME_NONNULL_END
