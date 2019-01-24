//
//  CreditInfoCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CreditInfoCellDelegate <NSObject>

- (void)didClickChangeButton;
- (void)didClickAuthView;
@end

@interface CreditInfoCell : UICollectionViewCell
@property (nonatomic ,strong) NSDictionary *companyInfo;
@property (nonatomic ,weak) id <CreditInfoCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
