//
//  CreditEditTextCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditEditTextCell.h"
#import "UITextView+Placeholder.h"

@interface CreditEditTextCell ()<UITextViewDelegate>
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong) NSMutableDictionary *data;
@end
@implementation CreditEditTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(self.contentView).offset(15);
            }];
            view.textColor = KHexRGB(0x303030);
            view.font = KFont(15);
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
            view.delegate = self;
            view.textAlignment = NSTextAlignmentJustified;
            view.font = KFont(15);
            view.textColor = KHexRGB(0x535353);
            view;
        });
    }
    return self;
}

- (void)setContent:(NSMutableDictionary *)data type:(CreditEditType)type editable:(BOOL)editable{
    _data = data;
    _textView.editable = editable;
    
    _textView.text = data[@"introduce"];
    if (type == EditTypeInfo) {
        _titleLab.text = @"公司介绍";
        _textView.placeholder = @"请输入公司介绍";
    }else if (type == EditTypeProduct){
        _titleLab.text = @"产品简介";
        _textView.placeholder = @"描述介绍产品性能、用途等信息";
    }else if (type == EditTypeHonor){
        _titleLab.text = @"荣誉简介";
        _textView.placeholder = @"请输入荣誉简介";
    }else if (type == EditTypePartner){
        _titleLab.text = @"合作伙伴简介";
        _textView.placeholder = @"请输入合作伙伴简介";
    }else{
        _titleLab.text = @"公司成员简介";
        _textView.placeholder = @"请输入公司成员简介";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString *text = textView.text?:@"";
    [_data setObject:text forKey:@"introduce"];

}


@end
