//
//  CreditServiceHeader.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/4.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditServiceHeader.h"

@interface CreditServiceHeader ()
@property (nonatomic ,strong) UIView *cardInfoView;
@property (nonatomic ,strong) UIImageView *cardImageView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *codeLab;
@property (nonatomic ,strong) UILabel *typeLab;
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIView *changeView;
@property (nonatomic ,strong) UILabel *changeNumLab;
@end

@implementation CreditServiceHeader

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
    _nameLab.text = _companyInfo[@"companyName"];
    _codeLab.text = _companyInfo[@"code"];
    _typeLab.text = _companyInfo[@"type"];
    
    int status = [_companyInfo[@"status"] intValue];//test
    if (status == 0) {
        [self addSubview:self.cardImageView];
        [self.bgView setBackgroundColor:[UIColor whiteColor]];
        [self setFrame:KFrame(0, self.y, self.width, _cardImageView.maxY+5)];
    }else if (status == 1){//已认证
        [self addSubview:self.cardInfoView];
        [self addSubview:self.changeView];
        [self.bgView setBackgroundColor:KHexRGB(0xd51424)];
        [self setFrame:KFrame(0, self.y, self.width, _changeView.maxY+10)];
    }else{//审核中
        [self addSubview:self.cardInfoView];
        [self.bgView setBackgroundColor:KHexRGB(0xd51424)];
        [self setFrame:KFrame(0, self.y, self.width, _cardInfoView.maxY+5)];
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
        nextIcon.backgroundColor = [UIColor blueColor];
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
        
    }
    return _changeView;
}

- (UIImageView *)cardImageView{
    if (!_cardImageView) {
        _cardImageView = [[UIImageView alloc]initWithFrame:KFrame(15, 5, self.width -15*2, 115)];
        _cardImageView.layer.cornerRadius = 5;
        _cardImageView.layer.masksToBounds = YES;
        _cardImageView.backgroundColor = [UIColor redColor];
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
        _nameLab.text = @"长沙市大洋科技有限公司";
        _nameLab.font = KFont(16);
        [_cardInfoView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
        }];
        
        _codeLab = [UILabel new];
        _codeLab.text = @"统一社会信用代码：9123992919293912";
        _codeLab.font = KFont(12);
        [_cardInfoView addSubview:_codeLab];
        [_codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab);
            make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);
        }];
        
        _typeLab = [UILabel new];
        _typeLab.text = @"企业类型：非上市、自然人投资或控股";
        _typeLab.font = KFont(12);
        [_cardInfoView addSubview:_typeLab];
        [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab);
            make.top.mas_equalTo(_codeLab.mas_bottom).offset(15);
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
