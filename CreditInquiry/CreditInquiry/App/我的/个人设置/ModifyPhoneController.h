//
//  ModifyPhoneController.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReloadBlock)(void);

@interface ModifyPhoneController : BasicViewController
@property (nonatomic ,copy) ReloadBlock reloadBlock;
@end

NS_ASSUME_NONNULL_END
