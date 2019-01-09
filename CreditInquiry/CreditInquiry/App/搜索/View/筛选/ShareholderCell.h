//
//  ShareholderCell.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/8/1.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "BaseSearchCell.h"

@class CompanyInfoModel;
@interface ShareholderCell : BaseSearchCell
- (void)setModel:(CompanyInfoModel *)model showCheckbox:(BOOL)show;

@end
