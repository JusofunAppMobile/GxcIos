//
//  LoginController.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"
#import "RegistController.h"
#import <IQKeyboardManager.h>
#import "FogotPwdController.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginSuccessBlock)(void);

@interface LoginController : BasicViewController

@property(nonatomic,copy)LoginSuccessBlock loginSuccessBlock;

@end

NS_ASSUME_NONNULL_END
