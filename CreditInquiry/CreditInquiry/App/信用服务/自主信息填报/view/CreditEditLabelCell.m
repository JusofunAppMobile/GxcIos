//
//  CreditEditLabelCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditEditLabelCell.h"
#import "UILabel+Alignment.h"

@interface CreditEditLabelCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UITextField *contentField;
@end
@implementation CreditEditLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(12);
                make.top.mas_equalTo(self.contentView).offset(15);
                make.bottom.mas_equalTo(self.contentView).offset(-15);
            }];
            [view setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            view.font = KFont(15);
            view;
        });
        
        self.contentField = ({
            UITextField *view = [UITextField new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_titleLab.mas_right).offset(5);
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView).offset(-12);
            }];
            view.textAlignment = NSTextAlignmentJustified;
            view.font = KFont(15);
            view;
        });

    }
    return self;
}

- (void)setContent:(id)content row:(NSInteger)row editType:(CreditEditType)type{
    if (type == EditTypeInfo) {
        if (row == 0) {
            _titleLab.text = @"行业：";
        }else if(row == 1){
            _titleLab.text = @"联系电话：";
        }else if (row == 2){
            _titleLab.text = @"邮箱：";
        }else{
            _titleLab.text = @"网址：";
        }
        
    }else if (type == EditTypeProduct){
        if (row == 0) {
            _titleLab.text = @"所属公司：";
        }else if(row == 1){
            _titleLab.text = @"产品名称：";
        }else if (row == 2){
            _titleLab.text = @"所属领域：";
        }else if (row == 3){
            _titleLab.text = @"标签：";
        }else{
            _titleLab.text = @"链接地址：";
        }
    }else if (type == EditTypeHonor){
        _titleLab.text = @"荣誉名称：";
    }else if (type == EditTypePartner){
        _titleLab.text = @"合作伙伴名称：";
    }else{
        if (row == 0) {
            _titleLab.text = @"企业成员姓名：";
        }else{
            _titleLab.text = @"企业成员职务：";
        }
    }
}

- (void)setCanEdit:(BOOL)canEdit{
    _canEdit = canEdit;
    _contentField.enabled = canEdit;
}


@end
