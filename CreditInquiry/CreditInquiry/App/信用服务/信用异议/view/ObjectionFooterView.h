//
//  ObjectionFooterView.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ObjectionFooterViewDelegate <NSObject>

- (void)didClickCommitButton;

@end

@interface ObjectionFooterView : UIView

@property (nonatomic ,weak) id <ObjectionFooterViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
