//
//  ComCertificationController.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicViewController.h"
#import "CertificationCell.h"
#import <UIImage+Wechat.h>
#import "BRPickerView.h"
#import <UIButton+WebCache.h>
NS_ASSUME_NONNULL_BEGIN
#define KCertificationCellTag 94742
@interface ComCertificationController : BasicViewController<CertificationDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property(nonatomic,copy)NSString *companyName;

//是否是展示信息
@property(nonatomic,assign)BOOL isShow;

/**
 // 0：未认证 1：审核中 2：审核失败 3：审核成功
 */
@property(nonatomic,copy)NSString *status;

@end

NS_ASSUME_NONNULL_END
