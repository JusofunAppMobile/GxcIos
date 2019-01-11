//
//  ShowMessageView.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

//推送消息
typedef NS_ENUM(NSInteger, ShowMessageType) {
    ShowMessageVIPType = 0, //VIP介绍
    PushMessageAutiType   =   1,//企业认证
};

NS_ASSUME_NONNULL_BEGIN

@interface ShowMessageView : UIView

-(instancetype)initWithType:(ShowMessageType)showType action:(void (^)(void))action;

@property (nonatomic, copy) void (^ShowMessageAction)(void);

@end

NS_ASSUME_NONNULL_END
