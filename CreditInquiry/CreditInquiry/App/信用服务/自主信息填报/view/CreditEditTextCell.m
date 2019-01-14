//
//  CreditEditTextCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditEditTextCell.h"
#import "UITextView+Placeholder.h"

@interface CreditEditTextCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UITextView *textView;
@end
@implementation CreditEditTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(self.contentView).offset(15);
            }];
            view.font = KFont(16);
            view.text = @"荣誉简介";
            view;
        });
        
        self.textView = ({
            UITextView *view = [UITextView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.top.mas_equalTo(_titleLab.mas_bottom).offset(10);
                make.bottom.mas_equalTo(self.contentView).offset(-15);
                make.height.mas_equalTo(123);
            }];
            view.font = KFont(14);
            view.placeholder = @"请输入荣誉简介";
            view;
        });
    }
    return self;
}

- (void)setContent:(id)content type:(CreditEditType)type{
    if (type == EditTypeInfo) {
        _titleLab.text = @"公司介绍";
        _textView.placeholder = @"请输入公司介绍";
    }else if (type == EditTypeProduct){
        _titleLab.text = @"简介";
        _textView.placeholder = @"描述介绍产品性能、用途等信息";
    }else if (type == EditTypeHonor){
        _titleLab.text = @"简介";
        _textView.placeholder = @"请输入简介";
    }else if (type == EditTypePartner){
        _titleLab.text = @"简介";
        _textView.placeholder = @"请输入简介";
    }else{
        _titleLab.text = @"简介";
        _textView.placeholder = @"请输入简介";

    }
}


@end
