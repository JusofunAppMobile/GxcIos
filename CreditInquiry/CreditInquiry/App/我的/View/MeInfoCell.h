//
//  MeInfoCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MeInfoCellDelegate <NSObject>

- (void)joinVip;

@end

@interface MeInfoCell : UITableViewCell
@property (nonatomic ,weak) id <MeInfoCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
