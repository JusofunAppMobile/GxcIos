//
//  BaseSearchCell.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/7/24.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "BaseSearchCell.h"

@implementation BaseSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
