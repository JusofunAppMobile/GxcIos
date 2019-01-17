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

@property(nonatomic,copy)NSString *entId;

//是否是展示信息
@property(nonatomic,assign)BOOL isShow;

@end

NS_ASSUME_NONNULL_END
