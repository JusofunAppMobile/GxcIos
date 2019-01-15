//
//  ModifyInfoCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ModifyInfoCell.h"


@interface ModifyInfoCell ()
@end

@implementation ModifyInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textfield = ({
            UITextField *view = [UITextField new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
            }];
            view.placeholder = @"填写公司";
            view.font = KFont(14);
            view;
        });
    }
    return self;
}

- (void)setTypeStr:(NSString *)typeStr{
    _typeStr = typeStr;
    _textfield.placeholder = [NSString stringWithFormat:@"填写%@",typeStr];
}

@end
