//
//  FilterCollectionCell.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/1/12.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterCellModel.h"
//标识是定位的城市
#define KDingWei @"dingWei"
@class FilterCollectionCell;
@protocol CollectionCellDelegate <NSObject>

- (void)selectCollectionViewCell:(FilterCellModel *)model;
- (void)deselectCollectionViewCell:(FilterCellModel *)model;

@end

@interface FilterCollectionCell : UICollectionViewCell

@property (nonatomic ,strong) FilterCellModel *model;

@property (nonatomic ,weak) id<CollectionCellDelegate>delegate;


@end

