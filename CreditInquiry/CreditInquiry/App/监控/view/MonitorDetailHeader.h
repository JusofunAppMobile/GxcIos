//
//  MonitorDetailHeader.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MonitorDetailHeaderDelegate <NSObject>

- (void)didClickMoreButton:(MDSectionModel *)model;

@end

@interface MonitorDetailHeader : UITableViewHeaderFooterView
@property (nonatomic ,weak) id <MonitorDetailHeaderDelegate>delegate;
@property(nonatomic,strong)MDSectionModel*model;
@end

NS_ASSUME_NONNULL_END
