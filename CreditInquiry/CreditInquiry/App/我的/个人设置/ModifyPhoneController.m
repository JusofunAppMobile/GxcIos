//
//  ModifyPhoneController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ModifyPhoneController.h"
#import "UIButton+Verification.h"
#import "Tools.h"

@interface ModifyPhoneController ()
@property (nonatomic ,strong) UITextField *phoneText;
@property (nonatomic ,strong) UITextField *codeText;
@property (nonatomic ,strong) UIButton *codeBtn;
@end

@implementation ModifyPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlankBackButton];
    [self initView];
}

#pragma mark - initView
- (void)initView{
    
    UILabel *titleLab = [UILabel new];
    titleLab.font = KFont(20);
    titleLab.text = @"绑定新手机号码";
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
        [view addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
        view;
    });
    
    self.codeText = ({
        UITextField *view = [UITextField new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_codeBtn);
            make.left.mas_equalTo(_phoneText);
            make.right.mas_lessThanOrEqualTo(_codeBtn.mas_left).offset(-20);
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
    
    UIButton *footerBtn = [UIButton new];
    footerBtn.backgroundColor = KHexRGB(0xeb101e);
    footerBtn.layer.cornerRadius = 20;
    footerBtn.layer.masksToBounds = YES;
    [footerBtn setTitle:@"完成" forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footerBtn];
    [footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.top.mas_equalTo(line2.mas_bottom).offset(45);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark - 按钮
- (void)getCodeAction{
    if (!_phoneText.text.length) {
        [MBProgressHUD showHint:@"请输入手机号码！" toView:self.view];
        return;
    }
    if (![Tools validatePhoneNumber:_phoneText.text]) {
        [MBProgressHUD showHint:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_phoneText.text forKey:@"phone"];
    [params setObject:@"3" forKey:@"type"];
    
    [RequestManager postWithURLString:KSendMesCode parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [_codeBtn startTimeWithDuration:60];
            [MBProgressHUD showSuccess:@"验证码发送成功" toView:self.view];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
    }];
    
}

- (void)commitAction{
    
    if (!_phoneText.text.length) {
        [MBProgressHUD showHint:@"请输入手机号码" toView:self.view];
        return;
    }
    if (!_codeText.text.length) {
        [MBProgressHUD showHint:@"请输入验证码" toView:self.view];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_phoneText.text forKey:@"phone"];
    [params setObject:_codeText.text forKey:@"code"];
    [RequestManager postWithURLString:KChangePhone parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
            [self updateUserInfo];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }

    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
    }];
}
- (void)updateUserInfo{
    KUSER.phone = _phoneText.text;
    [KUSER update];
    if (_reloadBlock) {
        _reloadBlock();
    }
    [self back];
}
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar fs_clearBackgroudCustomColor];
}


@end
