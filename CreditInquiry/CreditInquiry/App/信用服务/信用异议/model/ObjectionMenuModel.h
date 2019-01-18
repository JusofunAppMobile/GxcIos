//
//  ObjectionMenuModel.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/18.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjectionMenuModel : NSObject
@property (nonatomic ,copy) NSString *menuid;
@property (nonatomic ,copy) NSString *menuName;
@property (nonatomic ,assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
