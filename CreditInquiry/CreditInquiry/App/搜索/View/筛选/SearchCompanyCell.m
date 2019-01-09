//
//  SearchCompanyCell.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2017/12/29.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import "SearchCompanyCell.h"

@interface SearchCompanyCell()
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *compLab;
@property (nonatomic ,strong) UILabel *statusLab;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *moneyLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) UIImageView *focusView;//命中
@property (nonatomic ,strong) UILabel *focusLab;
@property (nonatomic ,strong) UIButton *previewBtn;
@property (nonatomic ,strong) UIImageView *checkbox;
@property (nonatomic ,strong) CompanyInfoModel *model;


@end

@implementation SearchCompanyCell

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
            [view setTitle:@"预览" forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0xff781b) forState:UIControlStateNormal];
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
            UILabel *view = [UILabel new];
            view.font = KFont(12);
            view.textColor = KHexRGB(0x1e9efb);
            view.layer.borderColor = KHexRGB(0x1e9efb).CGColor;
            view.layer.borderWidth = .5;
            view.layer.cornerRadius = 6;
            view.textAlignment = NSTextAlignmentCenter;
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

        self.focusView = ({
            UIImageView *view = [UIImageView new];
            view.backgroundColor = KHexRGB(0xfff7ed);
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_bgView);
                make.top.mas_equalTo(_dateLab.mas_bottom).offset(16);
                make.height.mas_equalTo(0).priorityHigh();
                make.bottom.mas_equalTo(_bgView.mas_bottom);
            }];
            view.hidden = YES;
            view;
        });
        
        self.focusLab = ({
            UILabel *view = [UILabel new];
            [_focusView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_focusView).offset(15);
                make.centerY.mas_equalTo(_focusView);
                make.right.mas_equalTo(_focusView).offset(-15);
            }];
            view.textColor = KHexRGB(0x999999);
            view.font = KFont(12);
            view;
        });
    }
    return self;
}

- (void)setModel:(CompanyInfoModel *)model showCheckbox:(BOOL)show{
    if (model) {
        _model = model;
        _nameLab.text = _model.legal;
        _compLab.text = _model.companyname;
        _dateLab.text = _model.establish;
        _moneyLab.text = _model.funds.length?_model.funds:@"未公示";
        
        NSString *status = _model.companystate.length?_model.companystate:@"未公示";
        _statusLab.text = status;
        
        //企业名称命中高亮
        if (_model.companylightname.length>0) {
            _compLab.attributedText = [Tools titleNameWithTitle:_model.companylightname otherColor:[UIColor blackColor]];
            _compLab.lineBreakMode = NSLineBreakByTruncatingTail;
        }else{
            _compLab.text  = _model.companyname;
        }
        
        //企业状态 加宽
        [_statusLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([self getTextWidth:_statusLab.text]+12);
        }];

        //关联是否显示
        if ([_model.related length]) {
            _focusLab.attributedText = [Tools titleNameWithTitle:_model.related otherColor:KHexRGB(0x999999)];
            [_focusView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(30).priorityHigh();
            }];
            _focusView.hidden = NO;
        }else{
            [_focusView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0).priorityHigh();
            }];
            _focusView.hidden = YES;
        }
        [self displayCheckbox:show state:_model.selected];
    }
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

- (CGFloat)getTextWidth:(NSString *)text{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 19) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
