//
//  CreditCollectionCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CreditServiceModel;
@interface CreditCollectionCell : UICollectionViewCell
@property (nonatomic ,strong) CreditServiceModel *model;
@end

NS_ASSUME_NONNULL_END
