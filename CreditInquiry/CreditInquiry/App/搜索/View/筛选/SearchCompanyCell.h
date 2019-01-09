//
//  SearchCompanyCell.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2017/12/29.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyInfoModel.h"
#import "BaseSearchCell.h"

@interface SearchCompanyCell : BaseSearchCell

- (void)setModel:(CompanyInfoModel *)model showCheckbox:(BOOL)show;

@end
