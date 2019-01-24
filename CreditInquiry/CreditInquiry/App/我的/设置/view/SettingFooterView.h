//
//  SettingFooterView.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SettingFooterViewDelegate <NSObject>

- (void)didClickLoginout;
@end
@interface SettingFooterView : UIView
@property (nonatomic ,weak) id <SettingFooterViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
