//
//  FogotPwdController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "FogotPwdController.h"

@interface FogotPwdController ()
@property (nonatomic ,strong) UITextField *phoneText;
@property (nonatomic ,strong) UITextField *codeText;
@property (nonatomic ,strong) UITextField *pwdText;
@property (nonatomic ,strong) UIButton *codeBtn;
@end

@implementation FogotPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlankBackButton];
    [self initView];
}

#pragma mark - initView
- (void)initView{
    
    UILabel *titleLab = [UILabel new];
    titleLab.font = KFont(20);
    titleLab.text = @"找回密码";
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight+30);
        make.left.mas_equalTo(35);
    }];
    
    UILabel *prefixLab = [UILabel new];
    prefixLab.font = KFont(12);
    prefixLab.text = @"+86";
    [self.view addSubview:prefixLab];
    [prefixLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).offset(35);
        make.left.mas_equalTo(35);
    }];
    
    self.phoneText = ({
        UITextField *view = [UITextField new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(prefixLab);
            make.left.mas_equalTo(prefixLab.mas_right).offset(10);
        }];
        view.placeholder = @"请输入手机号码";
        view.font = KFont(15);
        view;
    });
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = KHexRGB(0xd3d3d3);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(prefixLab.mas_bottom).offset(10);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(.5);
    }];
    
    self.codeBtn  = ({
        UIButton *view = [UIButton new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_bottom).offset(35);
            make.right.mas_equalTo(self.view).offset(-35);
        }];
        view.titleLabel.font = KFont(16);
        [view setTitle:@"获取验证码" forState:UIControlStateNormal];
        [view setTitleColor:KHexRGB(0xeb101e) forState:UIControlStateNormal];
        view;
    });
    
    self.codeText = ({
        UITextField *view = [UITextField new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_codeBtn);
            make.left.mas_equalTo(_phoneText);
            make.right.mas_equalTo(_codeBtn.mas_left).offset(20);
        }];
        view.placeholder = @"请输入验证码";
        view.font = KFont(15);
        view;
    });
    
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = KHexRGB(0xd3d3d3);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeBtn.mas_bottom).offset(8);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(.5);
    }];
    
    self.pwdText = ({
        UITextField *view = [UITextField new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line2.mas_bottom).offset(35);
            make.left.mas_equalTo(prefixLab.mas_right).offset(10);
        }];
        view.placeholder = @"请输入新密码";
        view.font = KFont(15);
        view;
    });
    
    UIView *line3 = [UIView new];
    line3.backgroundColor = KHexRGB(0xd3d3d3);
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdText.mas_bottom).offset(10);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(.5);
    }];
    
    
    UIButton *footerBtn = [UIButton new];
    footerBtn.backgroundColor = KHexRGB(0xeb101e);
    footerBtn.layer.cornerRadius = 20;
    footerBtn.layer.masksToBounds = YES;
    [footerBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:footerBtn];
    [footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.top.mas_equalTo(line3.mas_bottom).offset(45);
        make.height.mas_equalTo(45);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar fs_clearBackgroudCustomColor];
}
@end
