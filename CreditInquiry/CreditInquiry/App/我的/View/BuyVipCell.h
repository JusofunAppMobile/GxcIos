//
//  BuyVipCell.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyVipCell : UITableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section;

@property (nonatomic ,strong) UILabel *curPriceLabel;

@property(nonatomic ,assign) NSInteger row;

@property (nonatomic ,strong)NSDictionary *dataDic;

@property(nonatomic ,assign)BOOL choose;


@end

NS_ASSUME_NONNULL_END
