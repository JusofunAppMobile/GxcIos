//
//  MonitorFilterView.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MonitorViewDelegate<NSObject>

- (void)didSelectFilterView:(NSMutableArray *)selectArray;

@end

@interface MonitorFilterView : UIView

@property (nonatomic ,weak) id <MonitorViewDelegate>delegate;

@property (nonatomic ,strong) NSArray *dataArray;
- (void)showChooseView;
- (void)hideChooseView;

@property (nonatomic ,strong) NSMutableArray *saveArray;
@end

NS_ASSUME_NONNULL_END
