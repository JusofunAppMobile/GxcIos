//
//  MeInfoCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MeInfoCell.h"
#import "ContentInsetsLabel.h"
#import <UIButton+LXMImagePosition.h>

@interface MeInfoCell ()
@property (nonatomic ,strong) UIImageView *avatarView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIImageView *vipIcon;
@property (nonatomic ,strong) UIButton *joinBtn;
@property (nonatomic ,strong) ContentInsetsLabel *statusLab;
@property (nonatomic ,strong) UIButton *normalBtn;

@end
@implementation MeInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.avatarView];
        [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(54);
        }];

        [self.contentView addSubview:self.titleLab];
        [self setupViews];

        [self addLoginObserver];
        [self addModifyInfoObserver];
    }
    return self;
}

- (void)setupViews{

    [_vipIcon removeFromSuperview];
    [_normalBtn removeFromSuperview];
    [_joinBtn removeFromSuperview];
    [_statusLab removeFromSuperview];
    
    if (KUSER.userId.length) {
        [_avatarView sd_setImageWithURL:[NSURL URLWithString:KUSER.headIcon] placeholderImage:KImageName(@"me_head_h")];

        if (KUSER.authStatus.intValue == 1 ||KUSER.authStatus.intValue == 3) {//审核中
            [self.contentView addSubview:self.statusLab];
            
            _titleLab.text =  KUSER.company;
            _statusLab.text = KUSER.authStatus.intValue == 1 ?@"审核中":@"已认证";

            [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_avatarView);
                make.left.mas_equalTo(_avatarView.mas_right).offset(15);
            }];

            [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_titleLab.mas_bottom).offset(15);
                make.left.mas_equalTo(_titleLab);
                make.height.mas_equalTo(20);
            }];
            
            if (KUSER.vipStatus.intValue == 1) {//vip
                [self.contentView addSubview:self.vipIcon];
                [_vipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(_titleLab);
                    make.left.mas_equalTo(_titleLab.mas_right).offset(5);
                    make.right.mas_lessThanOrEqualTo(self.contentView).offset(-15);
                    make.width.height.mas_equalTo(15);
                }];
            }else{
                [self.contentView addSubview:self.joinBtn];
                [self.contentView addSubview:self.normalBtn];

                [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self.contentView);
                    make.right.mas_equalTo(self.contentView);
                    make.height.mas_equalTo(29);
                    make.width.mas_equalTo(80);
                }];
                
                [_normalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(_statusLab.mas_right).offset(20);
                    make.centerY.mas_equalTo(_statusLab);
                    make.height.mas_equalTo(14);
                }];
                [self layoutIfNeeded];
                [_normalBtn setImagePosition:LXMImagePositionRight spacing:5];
            }
            
        }else{//未认证
            _titleLab.text =  KUSER.phone;
            
            if (KUSER.vipStatus.intValue == 1){
                [self.contentView addSubview:self.vipIcon];
                [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(_avatarView);
                    make.left.mas_equalTo(_avatarView.mas_right).offset(15);
                }];
               
                [_vipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(_titleLab);
                    make.left.mas_equalTo(_titleLab.mas_right).offset(5);
                    make.right.mas_lessThanOrEqualTo(self.contentView).offset(-15);
                    make.width.height.mas_equalTo(15);
                }];
                
            }else{
                [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_avatarView);
                    make.left.mas_equalTo(_avatarView.mas_right).offset(15);
                }];
                
                [self.contentView addSubview:self.normalBtn];
                [_normalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_titleLab.mas_bottom).offset(15);
                    make.left.mas_equalTo(_titleLab);
                    make.height.mas_equalTo(14);
                }];
                [self layoutIfNeeded];
                [_normalBtn setImagePosition:LXMImagePositionRight spacing:5];
            }
        }
       
    }else{
        _avatarView.image = KImageName(@"me_head");
        self.titleLab.text = @"登录|注册";
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(_avatarView.mas_right).offset(15);
        }];
    }
}


- (void)addLoginObserver{
    [KNotificationCenter addObserver:self selector:@selector(setupViews) name:KLoginSuccess object:nil];
}

- (void)addModifyInfoObserver{
    [KNotificationCenter addObserver:self selector:@selector(setupViews) name:KModifyUserInfoSuccessNoti object:nil];
}

#pragma mark - lazy load
- (UIImageView *)avatarView{
    if (!_avatarView) {
        _avatarView = [UIImageView new];
        _avatarView.layer.cornerRadius = 27;
        _avatarView.layer.masksToBounds = YES;
    }
    return _avatarView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = KFont(17);
    }
    return _titleLab;
}

- (UIButton *)normalBtn{
    if (!_normalBtn) {
        _normalBtn = [UIButton new];
        _normalBtn.titleLabel.font = KFont(12);
        [_normalBtn setTitle:@"普通用户" forState:UIControlStateNormal];
        [_normalBtn setImage:KImageName(@"me_listicon_more") forState:UIControlStateNormal];
        [_normalBtn setTitleColor:KHexRGB(0x7d7d7d) forState:UIControlStateNormal];
    }
    return _normalBtn;
}


- (UIButton *)joinBtn{
    if (!_joinBtn) {
        _joinBtn = [UIButton new];
        [_joinBtn setImage:KImageName(@"mine_join") forState:UIControlStateNormal];
    }
    return _joinBtn;
}

- (UILabel *)statusLab{
    if (!_statusLab) {
        _statusLab = [ContentInsetsLabel new];
        _statusLab.font = KFont(12);
        _statusLab.contentInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        _statusLab.textColor = KHexRGB(0xd30e26);
        _statusLab.textAlignment = NSTextAlignmentCenter;
        _statusLab.backgroundColor = KHexRGB(0xffefe7);
        _statusLab.layer.cornerRadius = 2;
        _statusLab.layer.masksToBounds = YES;
    }
    return _statusLab;
}

- (UIImageView *)vipIcon{
    if (!_vipIcon) {
        _vipIcon = [UIImageView new];
        _vipIcon.image = KImageName(@"icon_vip");
    }
    return _vipIcon;
}


- (void)dealloc{
    [KNotificationCenter removeObserver:self name:KLoginSuccess object:nil];
    [KNotificationCenter removeObserver:self name:KModifyUserInfoSuccessNoti object:nil];
}

@end
