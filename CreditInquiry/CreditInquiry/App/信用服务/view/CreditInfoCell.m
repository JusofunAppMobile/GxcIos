//
//  CreditInfoCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditInfoCell.h"
#import "ContentInsetsLabel.h"

@interface CreditInfoCell ()
@property (nonatomic ,strong) UIView *cardInfoView;
@property (nonatomic ,strong) UIImageView *cardImageView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) UILabel *typeLab;
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIView *changeView;
@property (nonatomic ,strong) UILabel *changeNumLab;
@property (nonatomic ,strong) ContentInsetsLabel *statusLab;
@end

@implementation CreditInfoCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgView];
    }
    return self;
}

#pragma mark - set
- (void)setCompanyInfo:(NSDictionary *)companyInfo{
    _companyInfo = companyInfo;
    if (!_companyInfo) {
        return;
    }
    [_cardImageView removeFromSuperview];
    [_changeView removeFromSuperview];
    [_cardInfoView removeFromSuperview];
    
    int state = [_companyInfo[@"state"] intValue];//test 0 1 2 3
    if (state == 3){//已认证
        [self addSubview:self.cardInfoView];
        [self addSubview:self.changeView];
        [self.bgView setBackgroundColor:KHexRGB(0xd51424)];
        _statusLab.hidden = YES;
    }else if(state == 1){//审核中
        [self addSubview:self.cardInfoView];
        [self.bgView setBackgroundColor:KHexRGB(0xd51424)];
        _statusLab.hidden = NO;
    }else{//认证失败 未认证
        [self addSubview:self.cardImageView];
        [self.bgView setBackgroundColor:[UIColor clearColor]];
    }
    
    //view加载完成
    _nameLab.text = _companyInfo[@"companyName"];
    _codeLab.text = _companyInfo[@"code"];
    _typeLab.text = _companyInfo[@"type"];
    _changeNumLab.text = _companyInfo[@"changeNum"];
}
#pragma mark - 近三个月变化
- (void)changeAction{
    if ([self.delegate respondsToSelector:@selector(didClickChangeButton)]) {
        [self.delegate didClickChangeButton];
    }
}

#pragma mark - lazy load
- (UIView *)changeView{
    if (!_changeView) {
        _changeView = [[UIView alloc]initWithFrame:KFrame(15, self.cardInfoView.maxY+10,self.width-15*2, 47)];
        _changeView.layer.cornerRadius = 4;
        _changeView.layer.masksToBounds = YES;
        _changeView.backgroundColor =KHexRGB(0xffefe7);
        
        UILabel *changeTitle = [UILabel new];
        changeTitle.text = @"近3个月企业信息变化";
        changeTitle.font = KFont(15);
        changeTitle.textColor = KHexRGB(0x505050);
        [_changeView addSubview:changeTitle];
        [changeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_changeView);
            make.left.mas_equalTo(18);
        }];
        
        UIImageView *nextIcon = [UIImageView new];//test
        nextIcon.image = KImageName(@"me_listicon_more");
        [_changeView addSubview:nextIcon];
        [nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_changeView);
            make.right.mas_equalTo(_changeView).offset(-20);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(16);
        }];
        
        _changeNumLab = [UILabel new];
        _changeNumLab.backgroundColor = KHexRGB(0xd60e23);
        _changeNumLab.textColor = [UIColor whiteColor];
        _changeNumLab.text = @"3";//test
        _changeNumLab.font = KFont(12);
        _changeNumLab.textAlignment = NSTextAlignmentCenter;
        _changeNumLab.layer.cornerRadius = 10;
        _changeNumLab.layer.masksToBounds = YES;
        [_changeView addSubview:_changeNumLab];
        [_changeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_changeView);
            make.right.mas_equalTo(nextIcon.mas_left).offset(-6);
            make.height.width.mas_equalTo(20);
        }];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeAction)];
        [_changeView addGestureRecognizer:tap];
        
    }
    return _changeView;
}

- (UIImageView *)cardImageView{
    if (!_cardImageView) {
        _cardImageView = [[UIImageView alloc]initWithFrame:KFrame(15, 15, KDeviceW -15*2, (KDeviceW -15*2)*(221.f/688))];
        _cardImageView.image = KImageName(@"service_renzheng");
    }
    return _cardImageView;
}

- (UIView *)cardInfoView{
    if (!_cardInfoView) {
        _cardInfoView = [[UIView alloc]initWithFrame:KFrame(15, 5, self.width-15*2, 115)];
        _cardInfoView.backgroundColor = [UIColor whiteColor];
        _cardInfoView.layer.cornerRadius = 5;
        _cardInfoView.layer.shadowRadius = 2;
        _cardInfoView.layer.shadowOpacity = .8;
        _cardInfoView.layer.shadowOffset = CGSizeMake(.1, .1);
        _cardInfoView.layer.shadowColor =  [UIColor lightGrayColor].CGColor;;
        
        _nameLab = [UILabel new];
        _nameLab.font = KFont(16);
        [_cardInfoView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
        }];
        
        _statusLab = [ContentInsetsLabel new];
        _statusLab.font = KFont(14);
        _statusLab.text = @"审核中";
        _statusLab.contentInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        _statusLab.textColor = KHexRGB(0xd30e26);
        _statusLab.textAlignment = NSTextAlignmentCenter;
        _statusLab.backgroundColor = KHexRGB(0xffefe7);
        _statusLab.layer.cornerRadius = 2;
        _statusLab.layer.masksToBounds = YES;
        _statusLab.hidden = YES;
        [_cardInfoView addSubview:_statusLab];
        [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab.mas_right).offset(5);
            make.centerY.mas_equalTo(_nameLab);
            make.right.mas_lessThanOrEqualTo(_cardInfoView).offset(-15);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *codeTitle = [UILabel new];
        [_cardInfoView addSubview:codeTitle];
        [codeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab);
            make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);
        }];
        codeTitle.text = @"统一社会信用代码：";
        codeTitle.font = KFont(12);
        codeTitle.textColor = KHexRGB(0x909090);
        
        
        _codeLab = [UILabel new];
        _codeLab.font = KFont(12);
        [_cardInfoView addSubview:_codeLab];
        [_codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeTitle.mas_right);
            make.top.mas_equalTo(codeTitle);
            make.right.mas_lessThanOrEqualTo(_cardInfoView).offset(-15);
        }];
        
        
        UILabel *typeTitle = [UILabel new];
        [_cardInfoView addSubview:typeTitle];
        [typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(codeTitle.mas_bottom).offset(15);
            make.left.mas_equalTo(codeTitle);
        }];
        typeTitle.text = @"企业类型：";
        typeTitle.font = KFont(12);
        typeTitle.textColor = KHexRGB(0x909090);
        
        _typeLab = [UILabel new];
        _typeLab.font = KFont(12);
        [_cardInfoView addSubview:_typeLab];
        [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(typeTitle.mas_right);
            make.top.mas_equalTo(typeTitle);
            make.right.mas_lessThanOrEqualTo(_cardInfoView).offset(-15);
        }];        
    }
    return _cardInfoView;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 62)];
    }
    return _bgView;
}



@end
