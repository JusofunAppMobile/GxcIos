//
//  CreditEditLabelCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditEditLabelCell.h"

@interface CreditEditLabelCell ()<UITextFieldDelegate>
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UITextField *contentField;
@property (nonatomic ,strong) NSMutableDictionary *data;
@property (nonatomic ,assign) CreditEditType editType;
@property (nonatomic ,assign) NSInteger row;
@end
@implementation CreditEditLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(15);
                make.top.mas_equalTo(self.contentView).offset(20);
                make.bottom.mas_equalTo(self.contentView).offset(-20);
            }];
            [view setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            view.font = KFont(15);
            view.textColor = KHexRGB(0x303030);
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
            view.font = KFont(15);
            view.textColor = KHexRGB(0x303030);
            view.delegate = self;
            view;
        });

    }
    return self;
}

- (void)setContent:(NSMutableDictionary *)data row:(NSInteger)row editType:(CreditEditType)type enable:(BOOL)enable{
    _data = data;
    _editType = type;
    _row = row;
    _contentField.enabled = enable;
    
    if (type == EditTypeInfo) {
        if (row == 0) {
            _titleLab.text = @"行        业：";
            _contentField.placeholder = @"请输入行业";
            _contentField.text = _data[@"industry"];
        }else if(row == 1){
            _titleLab.text = @"联系电话：";
            _contentField.placeholder = @"请输入联系电话";
            _contentField.text = _data[@"phone"];
        }else if (row == 2){
            _titleLab.text = @"邮        箱：";
            _contentField.placeholder = @"请输入邮箱";
            _contentField.text = _data[@"email"];
        }else{
            _titleLab.text = @"网        址：";
            _contentField.placeholder = @"请输入网址";
            _contentField.text = _data[@"webURL"];
        }
        
    }else if (type == EditTypeProduct){
        
        if (row == 0) {
            _titleLab.text = @"所属公司：";
            _contentField.placeholder = @"请输入所属公司";
            _contentField.text = _data[@"companyName"];
            _contentField.enabled = NO;
        }else if(row == 1){
            _titleLab.text = @"产品名称：";
            _contentField.placeholder = @"请输入产品名称";
            _contentField.text = _data[@"product"];
        }else if (row == 2){
            _titleLab.text = @"所属领域：";
            _contentField.placeholder = @"请输入所属领域";
            _contentField.text = _data[@"industry"];
        }else if (row == 3){
            _titleLab.text = @"标        签：";
            _contentField.placeholder = @"请输入产品标签";
            _contentField.text = _data[@"tag"];
        }else{
            _titleLab.text = @"链接地址：";
            _contentField.placeholder = @"请输入链接地址";
            _contentField.text = _data[@"url"];
        }
        
    }else if (type == EditTypeHonor){
        
        _titleLab.text = @"荣誉名称：";
        _contentField.placeholder = @"请输入荣誉名称";
        _contentField.text = _data[@"honor"];
        
    }else if (type == EditTypePartner){
        
        _titleLab.text = @"合作伙伴名称：";
        _contentField.placeholder = @"请输入合作伙伴名称";
        _contentField.text = _data[@"partner"];
        
    }else{
        
        if (row == 0) {
            _titleLab.text = @"企业成员姓名：";
            _contentField.placeholder = @"请输入企业成员姓名";
            _contentField.text = _data[@"name"];

        }else{
            _titleLab.text = @"企业成员职务：";
            _contentField.placeholder = @"请输入企业成员职务";
            _contentField.text = _data[@"position"];
        }
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *text = textField.text?:@"";
    
    if (_editType == EditTypeInfo) {
        if (_row == 0) {
            [_data setObject:text forKey:@"industry"];
        }else if(_row == 1){
            [_data setObject:text forKey:@"phone"];
        }else if (_row == 2){
            [_data setObject:text forKey:@"email"];
        }else{
            [_data setObject:text forKey:@"webURL"];
        }
        
    }else if (_editType == EditTypeProduct){
        
        if (_row == 0) {
            [_data setObject:text forKey:@"companyName"];
        }else if(_row == 1){
            [_data setObject:text forKey:@"product"];
        }else if (_row == 2){
            [_data setObject:text forKey:@"industry"];
        }else if (_row == 3){
            [_data setObject:text forKey:@"tag"];
        }else{
            [_data setObject:text forKey:@"url"];
        }
        
    }else if (_editType == EditTypeHonor){
        
        [_data setObject:text forKey:@"honor"];
        
    }else if (_editType == EditTypePartner){
        
        [_data setObject:text forKey:@"partner"];
        
    }else{
        
        if (_row == 0) {
            [_data setObject:text forKey:@"name"];
        }else{
            [_data setObject:text forKey:@"position"];
        }
    }
}

@end
