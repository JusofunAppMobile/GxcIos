//
//  MeInfoCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MeInfoCell.h"
#import "ContentInsetsLabel.h"

@interface MeInfoCell ()
@property (nonatomic ,strong) UIImageView *avatarView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *loginLab;
@property (nonatomic ,strong) UIButton *typeBtn;
@property (nonatomic ,strong) UIButton *joinBtn;
@property (nonatomic ,strong) ContentInsetsLabel *statusLab;
@property (nonatomic ,strong) UIImageView *statusIcon;
@property (nonatomic ,strong) UIImageView *vipIcon;
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
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_avatarView);
            make.left.mas_equalTo(_avatarView.mas_right).offset(15);
        }];
        
        [self.contentView addSubview:self.vipIcon];
        [_vipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_titleLab);
            make.left.mas_equalTo(_titleLab.mas_right).offset(5);
            make.right.mas_lessThanOrEqualTo(self.contentView).offset(-15);
            make.width.height.mas_equalTo(15);
        }];
        
        [self.contentView addSubview:self.loginLab];
        [_loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(_titleLab);
        }];
      
        [self.contentView addSubview:self.typeBtn];
        [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLab.mas_bottom).offset(15);
            make.left.mas_equalTo(_titleLab);
            make.height.mas_equalTo(14);
        }];
        
        [self.contentView addSubview:self.statusLab];
        [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_typeBtn);
        }];
        
        [self.contentView addSubview:self.statusIcon];
        [_statusIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLab.mas_bottom).offset(5);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.joinBtn];
        [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(29);
            make.width.mas_equalTo(80);
        }];
        
        [self setupViews];
        [self addLoginObserver];
        [self addModifyInfoObserver];
    }
    return self;
}
- (void)setupViews{
    if (KUSER.userId.length) {
        _loginLab.hidden = YES;
        _titleLab.hidden = NO;
        [_avatarView sd_setImageWithURL:[NSURL URLWithString:KUSER.headIcon] placeholderImage:KImageName(@"me_head_h")];
        
        if (KUSER.authStatus.intValue == 0) {//未认证
            _titleLab.text = KUSER.phone;
            _statusLab.hidden = YES;
            _statusIcon.hidden = YES;
        }else if (KUSER.authStatus.intValue == 1){//已认证
            _titleLab.text = KUSER.company;
            _statusLab.hidden = NO;
            _statusIcon.hidden = YES;
        }else{
            _titleLab.text = KUSER.company;
            _statusLab.hidden = YES;
            _statusIcon.hidden = NO;
        }
        
        if (KUSER.vipStatus.intValue == 0) {//普通用户
            _vipIcon.hidden = YES;
            _typeBtn.hidden = NO;
            _joinBtn.hidden = KUSER.authStatus.intValue ==2?YES:NO;
        }else{
            _vipIcon.hidden = NO;
            _typeBtn.hidden = YES;
        }
        
    }else{
        _avatarView.image = KImageName(@"me_head");
        _titleLab.hidden = YES;
        _loginLab.hidden = NO;
        _typeBtn.hidden = YES;
        _joinBtn.hidden = YES;
        _statusLab.hidden = YES;
        _statusIcon.hidden = YES;
        _vipIcon.hidden = YES;
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

- (UILabel *)loginLab{
    if (!_loginLab) {
        _loginLab = [UILabel new];
        _loginLab.font = KFont(16);
        _loginLab.text = @"登录|注册";
    }
    return _loginLab;
}

- (UIButton *)typeBtn{
    if (!_typeBtn) {
        _typeBtn = [UIButton new];
        _typeBtn.titleLabel.font = KFont(12);
        [_typeBtn setTitle:@"普通用户" forState: UIControlStateNormal];
        [_typeBtn setTitleColor:KHexRGB(0x7d7d7d) forState:UIControlStateNormal];
    }
    return _typeBtn;
}

- (UIButton *)joinBtn{
    if (!_joinBtn) {
        _joinBtn = [UIButton new];
        _joinBtn.titleLabel.font = KFont(12);
        [_joinBtn setTitle:@"加入VIP" forState: UIControlStateNormal];
    }
    return _joinBtn;
}

- (UILabel *)statusLab{
    if (!_statusLab) {
        _statusLab = [ContentInsetsLabel new];
        _statusLab.font = KFont(12);
        _statusLab.text = @"已认证";
        _statusLab.contentInsets = UIEdgeInsetsMake(2, 3, 2, 3);
        _statusLab.textColor = KHexRGB(0xd30e26);
        _statusLab.textAlignment = NSTextAlignmentCenter;
        _statusLab.backgroundColor = KHexRGB(0xffefe7);
    }
    return _statusLab;
}

- (UIImageView *)statusIcon{
    if (!_statusIcon) {
        _statusIcon = [UIImageView new];
        _statusIcon.image = KImageName(@"mine_shenhe");
    }
    return _statusIcon;
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
