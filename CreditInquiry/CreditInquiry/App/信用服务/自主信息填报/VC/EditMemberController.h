//
//  EditMemberController.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReloadBlock)(void);

@interface EditMemberController : BasicViewController
@property (nonatomic ,copy) NSString *companyName;
@property (nonatomic ,copy) NSString *empId;
@property (nonatomic ,copy) ReloadBlock reloadBlock;

@end

NS_ASSUME_NONNULL_END
