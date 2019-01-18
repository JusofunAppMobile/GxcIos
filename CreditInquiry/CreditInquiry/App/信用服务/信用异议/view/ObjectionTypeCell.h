//
//  ObjectionTypeCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ObjectionModel;

@protocol ObjectionTypeCellDelegate <NSObject>
- (void)didSelectObjectionTypeMenu:(ObjectionModel *)model;
@end

@interface ObjectionTypeCell : UITableViewCell
@property (nonatomic ,strong) NSArray *typeList;
@property (nonatomic ,weak) id <ObjectionTypeCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
