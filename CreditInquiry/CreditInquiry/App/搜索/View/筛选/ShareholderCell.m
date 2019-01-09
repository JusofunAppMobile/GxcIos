//
//  ShareholderCell.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/8/1.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "ShareholderCell.h"
#import "CompanyInfoModel.h"
#import "ContentInsetsLabel.h"

@interface ShareholderCell ()
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *compLab;
@property (nonatomic ,strong) ContentInsetsLabel *statusLab;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *moneyLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) UIButton *previewBtn;
@property (nonatomic ,strong) UIImageView *checkbox;
@property (nonatomic ,strong) CompanyInfoModel *model;

@end

@implementation ShareholderCell

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
        
        
        self.previewBtn = ({
            UIButton *view = [UIButton new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_bgView).offset(-15);
                make.top.mas_equalTo(_bgView.mas_top).offset(15);
                make.width.mas_equalTo(30);
            }];
            view.hidden = YES;
            view.titleLabel.font = KFont(14);
            [view setImage:KImageName(@"股东穿透预览") forState:UIControlStateNormal];
            [view addTarget:self action:@selector(previewAction) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
        
        self.compLab = ({
            UILabel *view = [UILabel new];
            view.font = KFont(16);
            view.textColor = KHexRGB(0x333333);
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_bgView).offset(15);
                make.right.mas_equalTo(_previewBtn.mas_left).offset(-10);
                make.top.mas_equalTo(_bgView.mas_top).offset(20);
                make.height.mas_equalTo(16).priorityHigh();
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
        
        self.checkbox = ({
            UIImageView *view = [UIImageView new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_bgView).offset(-18);
                make.top.mas_equalTo(nameTitle);
                make.height.width.mas_equalTo(15);
            }];
            view.image = KImageName(@"蓝色未选中");
            view.hidden = YES;
            view;
        });
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(nameTitle.mas_right);
                make.right.mas_equalTo(_checkbox.mas_right).offset(-10);
                make.top.mas_equalTo(nameTitle);
                make.height.mas_equalTo(14).priorityHigh();
            }];
            view.textColor = KHexRGB(0x1e9efb);
            view.font = KFont(14);
            view;
        });
        
        UILabel *moneyTitle = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(nameTitle);
                make.top.mas_equalTo(nameTitle.mas_bottom).offset(16);
                make.width.mas_equalTo(86);
                make.height.mas_equalTo(14).priorityHigh();
            }];
            view.text = @"注册资金：";
            view.font = KFont(14);
            view.textColor =  KHexRGB(0x999999);
            view;
        });
        
        self.moneyLab = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_nameLab);
                make.top.mas_equalTo(moneyTitle);
            }];
            view.textColor = KHexRGB(0x333333);
            view.font = KFont(14);
            view;
        });
        
        UILabel *dateTitle = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(moneyTitle);
                make.top.mas_equalTo(moneyTitle.mas_bottom).offset(16);
                make.bottom.mas_equalTo(_bgView.mas_bottom).offset(-16);
                make.width.mas_equalTo(86);
                make.height.mas_equalTo(14).priorityHigh();
            }];
            view.font = KFont(14);
            view.textColor =  KHexRGB(0x999999);
            view.text = @"成立日期：";
            view;
        });
        
        self.dateLab = ({
            UILabel *view =[UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_moneyLab);
                make.top.mas_equalTo(dateTitle);
            }];
            view.textColor = KHexRGB(0x333333);
            view.font = KFont(14);
            view;
        });
        
    }
    return self;
}


- (void)setModel:(CompanyInfoModel *)model showCheckbox:(BOOL)show{
    _model = model;
    _nameLab.text = _model.legal;
    _compLab.text = _model.companyname;
    _dateLab.text = _model.establish;
    _moneyLab.text = _model.funds.length?_model.funds:@"未公示";
    _statusLab.text = _model.companystate.length?_model.companystate:@"未公示";
    _previewBtn.hidden = ![model.ishasshareholder boolValue];//test此处是true false么？
    
    [self displayCheckbox:show state:_model.selected];

}

- (void)displayCheckbox:(BOOL)show state:(BOOL)selected{
    _previewBtn.hidden = _checkbox.hidden = !show;
    if (show) {
        _checkbox.image = selected?KImageName(@"蓝色选中"):KImageName(@"蓝色未选中");
        if ([self.delegate respondsToSelector:@selector(cellSelectedWithModel:)]) {
            [self.delegate cellSelectedWithModel:_model];
        }
    }
}


#pragma mark - action
- (void)previewAction{
    if ([self.delegate respondsToSelector:@selector(cellPreviewAction:)]) {
        [self.delegate cellPreviewAction:_model];
    }
}

@end
