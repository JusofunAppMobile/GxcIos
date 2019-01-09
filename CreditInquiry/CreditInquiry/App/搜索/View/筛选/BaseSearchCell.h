//
//  BaseSearchCell.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/7/24.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  SearchBaseModel;

@protocol SearchCellSelectedDelegate <NSObject>

- (void)cellSelectedWithModel:(SearchBaseModel *)model;//checkbox选中、取消
- (void)cellPreviewAction:(SearchBaseModel *)model;

@optional

- (void)cellExpandAction;//展开、收起


@end

@interface BaseSearchCell : UITableViewCell

@property (nonatomic ,weak) id <SearchCellSelectedDelegate>delegate;

@end
