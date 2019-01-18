//
//  DetailHolderCell.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYLabel.h>
#import "HodelButton.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DetailHolderType) {
    DetailHolderGDType = 1, //股东
    DetailHolderGGType = 2, //高管
};

@protocol DetailHolderDelegate <NSObject>

-(void)detailHolderCheckMore:(DetailHolderType)type;

@end

@interface DetailHolderCell : UITableViewCell

@property(nonatomic,assign)id<DetailHolderDelegate>delegate;

@property(nonatomic,strong)NSArray*hodelArray;

@property(nonatomic,strong)NSArray*executivesArray;

@end

NS_ASSUME_NONNULL_END
