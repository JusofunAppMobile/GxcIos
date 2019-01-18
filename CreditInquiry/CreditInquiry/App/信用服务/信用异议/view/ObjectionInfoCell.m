//
//  ObjectionInfoCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ObjectionInfoCell.h"
#import "UITextView+Placeholder.h"
#import "ObjectionItem.h"
#import "MyTextField.h"
#import "ObjectionModel.h"
#import "ObjectionMenuModel.h"

static int BASE_TAG = 2019;
static int Text_TAG = 3003;

@interface ObjectionInfoCell ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) UILabel *typeLab;
@property (nonatomic ,strong) UIView *itemBg;
@property (nonatomic ,strong) UIView *inputBg;
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong) NSArray *holderTexts;

@property (nonatomic ,assign) ObjectionType type;
@property (nonatomic ,strong) ObjectionModel *model;

@property (nonatomic ,strong) NSMutableDictionary *params;
@end

@implementation ObjectionInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.holderTexts = @[@"您的真实姓名",@"您的身份证号码",@"您的联系电话",@"您的电子邮箱"];
        
        UILabel *titleLab = [UILabel new];
        titleLab.font = KFont(15);
        titleLab.text = @"异议信息";
        [self.contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        
        UILabel *tipLab = [UILabel new];
        tipLab.font = KFont(13);
        tipLab.text = @"请选择信息有误的部分";
        tipLab.textColor = KHexRGB(0x909090);
        [self.contentView addSubview:tipLab];
        [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLab);
            make.left.mas_equalTo(titleLab.mas_right).offset(10);
        }];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = KHexRGB(0xd9d9d9);
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(.5);
        }];
        
        self.itemBg = ({
            UIView *view = [UIView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView.mas_bottom);
                make.left.right.mas_equalTo(self.contentView);
            }];
            view;
        });
        
        self.inputBg = ({
            UIView *view = [UIView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_itemBg.mas_bottom);
                make.left.right.mas_equalTo(self.contentView);
            }];
            view;
        });
        
        self.textView = ({
            UITextView *view = [UITextView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_inputBg.mas_bottom).offset(10);
                make.left.mas_equalTo(self.contentView).offset(15);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.height.mas_equalTo(75);
                make.bottom.mas_equalTo(self.contentView.mas_bottom);
            }];
            view.font = KFont(14);
            view.layer.cornerRadius = 5;
            view.layer.borderColor = KHexRGB(0xd4d4d4).CGColor;
            view.layer.borderWidth = .5;
            view.delegate = self;
            view.placeholder = @"我们会收集您提交的请求，并在3～5个工作日回复";
            view;
        });
    }
    return self;
}

- (void)setModel:(ObjectionModel *)model type:(ObjectionType)objectionType{
    _model = model;
    _type = objectionType;
    if (objectionType == ObjectionTypeCredit) {
        _textView.placeholder = @"我们会收集您提交的请求，并在3～5个工作日回复";
    }else{
        _textView.placeholder = @"感谢您使用“异议申诉”功能，并对国信查功能提出宝贵意见（字数为25-1000字）";
    }
    
    [self initItems];
    [self initInputViews];
}

- (void)initItems{
    CGFloat space = 5;
    CGFloat lineSpace = 10;
    CGFloat width = (KDeviceW - 15*2 - space*3)/4;
    CGFloat height = 30;
    [_itemBg.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    for (int i = 0; i<_model.menuList.count; i++) {
        
        ObjectionMenuModel *model = _model.menuList[i];
        
        ObjectionItem *item = [[ObjectionItem alloc]initWithFrame:KFrame(15 + (width+space)*(i%4),10+(lineSpace+height)*(i/4) , width, height)];
        item.tag = BASE_TAG+i;
        [item setTitle:model.menuName forState:UIControlStateNormal];
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        item.selected = model.selected;
        [_itemBg addSubview:item];
        
        if (i == _model.menuList.count - 1) {
            [_itemBg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(item.maxY).priorityHigh(1000);
            }];
        }
    }
}

- (void)initInputViews{
    if (_type == ObjectionTypeError) {
        [_inputBg.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        
        CGFloat space = 10;
        CGFloat height = 40;
        for (int i = 0; i<4; i++) {
            MyTextField *view = [[MyTextField alloc]initWithFrame:KFrame(15, 15+i*(height+space), KDeviceW - 15*2, height)];
            view.placeholder = _holderTexts[i];
            view.layer.borderColor = KHexRGB(0xd4d4d4).CGColor;
            view.layer.borderWidth = 1;
            view.layer.cornerRadius = 5;
            view.font = KFont(12);
            view.delegate = self;
            view.tag = Text_TAG+i;
            [_inputBg addSubview:view];
            
            if (i == 3) {
                [_inputBg mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(view.maxY).priorityHigh(1000);
                }];
            }
        }
    }else{
        [_inputBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text) {
        NSInteger index = textField.tag - Text_TAG;
        NSString *key = nil;
        if (index == 0) {
            key = @"name";
        }else if (index == 1){
            key = @"IDCard";
        }else if (index == 2){
            key = @"phone";
        }else{
            key = @"Email";
        }
        [self.params setObject:textField.text forKey:key];
    }
    if ([self.delegate respondsToSelector:@selector(infoCellDidEndEditing:)]) {
        [self.delegate infoCellDidEndEditing:self.params];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text) {
        [self.params setObject:textView.text forKey:@"errorMsg"];
    }
    if ([self.delegate respondsToSelector:@selector(infoCellDidEndEditing:)]) {
        [self.delegate infoCellDidEndEditing:self.params];
    }
}

- (void)itemAction:(UIButton *)sender{//多选问题
    sender.selected = !sender.selected;
    
    ObjectionMenuModel *model = _model.menuList[sender.tag - BASE_TAG];
    model.selected = sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(infoCellDidClickMenu:select:)]) {
        [self.delegate infoCellDidClickMenu:model select:sender.selected];
    }
}

#pragma mark - delegate
- (NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}


@end
