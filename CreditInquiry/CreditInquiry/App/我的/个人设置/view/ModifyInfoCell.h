//
//  ModifyInfoCell.h
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModifyInfoCell : UITableViewCell
@property (nonatomic ,copy) NSString *typeStr;
@property (nonatomic ,strong) UITextField *textfield;

@end

NS_ASSUME_NONNULL_END
