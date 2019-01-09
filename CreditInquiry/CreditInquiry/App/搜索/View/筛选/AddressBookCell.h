//
//  AddressBookCell.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/5/2.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSearchCell.h"
@class AddressBookModel;
//
//@protocol AddressBookExpandDelegate<NSObject>
//
//- (void)cellExpandAction;//展开、收起
//
//- (void)cellSelectedWithModel:(AddressBookModel *)model;//checkbox选中、取消
//
//- (void)checkMoreAction:(AddressBookModel *)model;
//
//@end

@interface AddressBookCell : BaseSearchCell

//@property (nonatomic ,weak) id <AddressBookExpandDelegate>delegate;


- (void)setModel:(AddressBookModel *)model checkboxShow:(BOOL)show;

@end
