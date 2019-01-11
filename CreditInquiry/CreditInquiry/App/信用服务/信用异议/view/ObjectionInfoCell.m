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

static int BASE_TAG = 2019;


@interface ObjectionInfoCell ()

@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) UILabel *typeLab;
@property (nonatomic ,strong) UIView *itemBg;
@property (nonatomic ,strong) UIView *inputBg;
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic ,assign) NSInteger type;
@property (nonatomic ,strong) NSArray *holderTexts;
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
            view.placeholder = @"我们会收集您提交的请求，并在3～5个工作日回复";
            view;
        });
        
//        UIButton *footerBtn = [UIButton new];
//        [self.contentView addSubview:footerBtn];
//        [footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo()
//        }];
        
       
    }
    return self;
}


- (void)setTitles:(NSArray *)titles type:(NSInteger)type{
    _titles = titles;
    _type = type;
    
    [self initItems];
    [self initInputViews];
}

- (void)initItems{
    CGFloat space = 5;
    CGFloat lineSpace = 10;
    CGFloat width = (KDeviceW - 15*2 - space*3)/4;
    CGFloat height = 30;
    
    for (int i = 0; i<_titles.count; i++) {
        ObjectionItem *item = [[ObjectionItem alloc]initWithFrame:KFrame(15 + (width+space)*(i%4),10+(lineSpace+height)*(i/4) , width, height)];
        item.tag = BASE_TAG+i;
        [item setTitle:_titles[i] forState:UIControlStateNormal];
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_itemBg addSubview:item];
        
        if (i == _titles.count-1) {
            [_itemBg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(item.maxY);
            }];
        }
    }
}

- (void)initInputViews{
    if (_type == 0) {
        [_inputBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        CGFloat space = 10;
        CGFloat height = 40;
        for (int i = 0; i<4; i++) {
            MyTextField *view = [[MyTextField alloc]initWithFrame:KFrame(15, 15+i*(height+space), KDeviceW - 15*2, height)];
            view.placeholder = _holderTexts[i];
            view.layer.borderColor = KHexRGB(0xd4d4d4).CGColor;
            view.layer.borderWidth = 1;
            view.layer.cornerRadius = 5;
            view.font = KFont(12);
            [_inputBg addSubview:view];
            if (i == 3) {
                [_inputBg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(view.maxY);
                }];
            }
        }
    }
}


- (void)itemAction:(UIButton *)sender{
    [_itemBg.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ObjectionItem class]]) {
            ObjectionItem *button = (ObjectionItem *)obj;
            if ([obj isEqual:sender]) {
                button.selected = YES;
            }else{
                button.selected = NO;
            }
        }
    }];
}

@end
