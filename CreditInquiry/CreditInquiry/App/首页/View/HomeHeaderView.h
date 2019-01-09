//
//  HomeHeaderView.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/1/4.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchButton.h"
#import "CenterButton.h"
#import <SDCycleScrollView.h>
@protocol HomeHeaderViewDelegate<NSObject>

- (void)headerBtnClicked:(CenterButton *)button;

- (void)hotKeySearch:(NSString *)hotKey;

@end



@interface HomeHeaderView : UIView<SDCycleScrollViewDelegate>

@property (nonatomic ,strong) SearchButton *searchBtnView;
@property (nonatomic ,strong) UIImageView *bannerView;
@property (nonatomic ,weak) id <HomeHeaderViewDelegate>delegate;

-(void)reloadData;

@end
