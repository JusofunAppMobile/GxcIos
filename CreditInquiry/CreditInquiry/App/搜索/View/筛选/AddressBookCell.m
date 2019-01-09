//
//  AddressBookCell.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/5/2.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "AddressBookCell.h"
#import "AddressBookModel.h"
#import "Tools.h"
#import "ContentInsetsLabel.h"

@interface AddressBookCell()

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *compLab;
@property (nonatomic ,strong) ContentInsetsLabel *statusLab;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) UIView *phoneView;
@property (nonatomic ,strong) UIView *expandView;
@property (nonatomic ,strong) AddressBookModel *model;
@property (nonatomic ,strong) UILabel *label1;
@property (nonatomic ,strong) UILabel *label2;
@property (nonatomic ,strong) UILabel *label3;
@property (nonatomic ,strong) UIImageView *checkBox;
@property (nonatomic ,strong) UIButton *expandBtn;
@property (nonatomic ,assign) BOOL showCheckbox;

@end

@implementation AddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bgView =({
            UIView *bgView = [UIView new];
            bgView.backgroundColor = [UIColor whiteColor];
            bgView.layer.shadowColor =  [UIColor lightGrayColor].CGColor;;
            bgView.layer.shadowOffset = CGSizeMake(0.1, .1);//0,-3
            bgView.layer.shadowRadius = 2;//0,-3
            bgView.layer.shadowOpacity = 0.8;
            bgView.layer.cornerRadius = 5;
            [self.contentView addSubview:bgView];
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(self.contentView.mas_top).offset(10);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
            }];
            bgView;
        });
        
        CGFloat padding = KDeviceW==320?10:15;
        
        self.compLab = ({
            UILabel *view = [UILabel new];
            view.font = KFont(16);
            view.textColor = KHexRGB(0x333333);
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_bgView).offset(padding);
                make.right.mas_equalTo(_bgView).offset(-padding);
                make.top.mas_equalTo(_bgView.mas_top).offset(20);
                make.height.mas_equalTo(16);
            }];
            view;
        });
        
        self.statusLab = ({
            ContentInsetsLabel *view = [ContentInsetsLabel new];
            view.font = KFont(12);
            view.textColor = KHexRGB(0x1e9efb);
            view.layer.borderColor = KHexRGB(0x1e9efb).CGColor;
            view.layer.borderWidth = .5;
            view.layer.cornerRadius = 6;
            view.textAlignment = NSTextAlignmentCenter;
            view.contentInsets = UIEdgeInsetsMake(0, 6, 0, 6);
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_compLab);
                make.top.mas_equalTo(_compLab.mas_bottom).offset(10);
                make.width.mas_greaterThanOrEqualTo(35);
                make.height.mas_equalTo(19).priorityHigh();
            }];
            view;
        });
        
        UILabel *nameTitle = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_compLab);
                make.top.mas_equalTo(_statusLab.mas_bottom).offset(16);
                make.width.mas_equalTo(86);
                make.height.mas_equalTo(14).priorityHigh();
            }];
            view.text = @"法定代表人：";
            view.font = KFont(14);
            view.textColor = KHexRGB(0x999999);
            view;
        });
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(nameTitle.mas_right);
                make.right.mas_equalTo(_bgView).offset(-15);
                make.top.mas_equalTo(nameTitle.mas_top);
                make.height.mas_equalTo(14);
            }];
            view.textColor = KHexRGB(0x1e9efb);
            view.font = KFont(14);
            view;
        });
        
        UILabel *dateTitle = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(nameTitle);
                make.top.mas_equalTo(nameTitle.mas_bottom).offset(16);
                make.width.mas_equalTo(86);
                make.height.mas_equalTo(14).priorityHigh();
            }];
            view.text = @"成立日期：";
            view.font = KFont(14);
            view.textColor =  KHexRGB(0x999999);
            view;
        });
        
        self.dateLab = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_nameLab);
                make.top.mas_equalTo(dateTitle.mas_top);
                make.height.mas_equalTo(dateTitle);
            }];
            view.textColor = KHexRGB(0x333333);
            view.font = KFont(14);
            view;
        });
        
        UILabel *phoneTitle = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(dateTitle);
                make.top.mas_equalTo(dateTitle.mas_bottom).offset(16);
                make.width.mas_equalTo(86);
                make.height.mas_equalTo(14).priorityHigh();
            }];
            view.font = KFont(14);
            view.textColor =  KHexRGB(0x999999);
            view.text = @"联系电话：";
            view;
        });
        
        self.phoneView = ({
            UIView *view =[UIView new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_dateLab);
                make.top.mas_equalTo(phoneTitle.mas_top);
                make.height.mas_equalTo(14).priorityHigh();
            }];
            view;
        });
        
        self.expandView = ({
            UIView *view = [UIView new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_phoneView.mas_bottom).offset(16);
                make.left.right.mas_equalTo(_bgView);
                make.height.mas_equalTo(0).priorityHigh();
                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
            }];
            view;
        });
        
        
        UIImageView *lineView = [UIImageView new];
        lineView.image = KImageName(@"灰线");
        [_expandView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(_expandView);
            make.height.mas_equalTo(1).priorityHigh(1000);
        }];
        
        self.expandBtn = ({
            
            UIButton *expandBtn = [UIButton new];
            [expandBtn setImage:KImageName(@"展开") forState:UIControlStateNormal];
            [expandBtn setImage:KImageName(@"收起") forState:UIControlStateSelected];
            [expandBtn addTarget:self action:@selector(expandAction:) forControlEvents:UIControlEventTouchUpInside];
            [_expandView addSubview:expandBtn];
            [expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView.mas_bottom);
                make.left.right.bottom.mas_equalTo(_expandView);
            }];
            expandBtn;
        });
        
        
        self.checkBox = ({
            UIImageView *checkBox = [UIImageView new];
            checkBox.image = KImageName(@"蓝色未选中");
            [self.contentView addSubview:checkBox];
            [checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_bgView);
                make.right.mas_equalTo(_bgView).offset(-15);
            }];
            checkBox;
        });
        
    }
    return self;
}

- (void)displayCheckbox:(BOOL)show state:(BOOL)selected{
    _checkBox.hidden = !show;
    if (show) {
        _checkBox.image = selected?KImageName(@"蓝色选中"):KImageName(@"蓝色未选中");
        if ([self.delegate respondsToSelector:@selector(cellSelectedWithModel:)]) {
            [self.delegate cellSelectedWithModel:_model];
        }
    }
}

#pragma mark - 按钮
//展开
- (void)expandAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    _model.expand = sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(cellExpandAction)]) {
        [self.delegate cellExpandAction];
    }
}
//查看更多
- (void)moreAction{
    if ([self.delegate respondsToSelector:@selector(cellPreviewAction:)]) {
        [self.delegate cellPreviewAction:_model];
    }
}

//选中
- (void)checkboxAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    _model.selected = sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(cellSelectedWithModel:)]) {
        [self.delegate cellSelectedWithModel:_model];
    }
}

#pragma mark- 设置model
- (void)setModel:(AddressBookModel *)model checkboxShow:(BOOL)show{
    
    if (!model) return;
    _model          = model;
    _compLab.text   = model.companyname;
    _statusLab.text = model.type.length?model.type:@"企业未公示";
    _nameLab.text   = model.legalPerson;
    _expandBtn.selected = model.expand;
    _dateLab.text = ![Tools checkNull:model.establishDate]?model.establishDate:@"企业未公示";
    
    [self displayCheckbox:show state:model.selected];
    [self layoutExpandView];
}


- (void)layoutExpandView{
    
    NSInteger count = _model.phoneArr.count;
    
    if (count > 2) {
        [_expandView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30).priorityHigh();
        }];
        _expandView.hidden = NO;
    }else{
        [_expandView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityHigh();
        }];
        _expandView.hidden = YES;
    }
    
    [_phoneView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_model.expand?60:14).priorityHigh();
    }];
   
    [self createPhoneLabel:count];
}

- (void)createPhoneLabel:(NSInteger)count{
    
    for (UIView *view in _phoneView.subviews) {
        [view removeFromSuperview];
    }
   
    NSInteger labelNum = _model.expand ?MIN(4, count):MIN(2, count);
    
    _label1 = nil;
    _label2 = nil;
    _label3 = nil;
    
    for (int i = 0; i < labelNum; i++) {
        if (i == 0) {
            _label1 = [UILabel new];
            _label1.font = KFont(14);
            _label1.textColor = KHexRGB(0x1d89fa);
            _label1.text = _model.phoneArr[i];
            [_phoneView addSubview:_label1];
            [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(_phoneView);
                make.height.mas_equalTo(14);
            }];
        }else if (i == 1){
            _label2 = [UILabel new];
            _label2.font = KFont(14);
            _label2.textColor = KHexRGB(0x1d89fa);
            _label2.text = (count>2&&!_model.expand)?@"...":_model.phoneArr[i];
            [_phoneView addSubview:_label2];
            [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_label1.mas_right).offset(KDeviceW==320?5:30);
                make.right.mas_lessThanOrEqualTo(_bgView.mas_right);
                make.top.mas_equalTo(_label1);
                make.height.mas_equalTo(14);
            }];
            
        }else if (i == 2){
            _label3 = [UILabel new];
            _label3.font = KFont(14);
            _label3.textColor = KHexRGB(0x1d89fa);
            _label3.text = _model.phoneArr[i];
            [_phoneView addSubview:_label3];
            [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_label1);
                make.top.mas_equalTo(_label1.mas_bottom).offset(30);
                make.height.mas_equalTo(14);
            }];
        }else{
            UIButton *moreBtn = [UIButton new];
            moreBtn.titleLabel.font = KFont(14);
            [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
            [moreBtn setTitleColor:KHexRGB(0xfc5108) forState:UIControlStateNormal];
            [moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
            [_phoneView addSubview:moreBtn];
            [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_label2);
                make.top.bottom.mas_equalTo(_label3);
            }];
        }
    }
}



@end
