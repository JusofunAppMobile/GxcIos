//
//  LoginController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@property(nonatomic,strong)UIScrollView *backScrollView;

@property(nonatomic,strong)UIImageView *logoImageView;

@property(nonatomic,strong)UITextField *phoneTextFld;

@property(nonatomic,strong)UITextField *pwdTextFld;

@property(nonatomic,strong)UIView *lineView1;

@property(nonatomic,strong)UIView *lineView2;

@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UIButton *forgetBtn;



@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBlankBackButton];
    [self drawRightBarButton];
    
    [self drawView];
    
}

-(void)login{
    
    [self.view endEditing:YES];
    if (_phoneTextFld.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:self.view];
        return;
    }
    if (_pwdTextFld.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_phoneTextFld.text forKey:@"phone"];
    [params setObject:@"123" forKey:@"regId"];//test
    [params setObject:[JAddField desEncryptWithString:_pwdTextFld.text] forKey:@"password"];
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KLogin parameters:params  success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:NO];
        if ([responseObject[@"result"] integerValue] == 0) {
            [User clearTable];
            User *model = [User mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [model save];
            [KNotificationCenter postNotificationName:KLoginSuccess object:nil];
            [self back];
            
            if(self.loginSuccessBlock)
            {
                self.loginSuccessBlock();
            }
            
            [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
    }];
    
    
}

-(void)regist
{
    
    RegistController *vc = [[RegistController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)forgetPassword
{
    FogotPwdController *vc = [FogotPwdController new];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)drawView
{
    
//    self.backScrollView = ({
//        UIScrollView *view = [UIScrollView new];
//        [self.view addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(KNavigationBarHeight);
//            make.bottom.left.mas_equalTo(self.view);
//            make.width.mas_equalTo(KDeviceW);
//        }];
//        view;
//    });
    
    self.logoImageView = ({
        UIImageView *view = [UIImageView new];
        [self.view addSubview:view];
        view.image = KImageName(@"logo");
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.height.width.mas_equalTo(66);
            make.top.mas_equalTo(KNavigationBarHeight+30);
        }];
        view;
    });
    
    
    self.phoneTextFld = ({
        UITextField *view = [UITextField new];
        [self.view addSubview:view];
        view.textColor = [UIColor blackColor];
        view.font = KFont(16);
        view.placeholder = @"请输入手机号码";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_logoImageView.mas_bottom).offset(52);
            make.left.mas_equalTo(self.view).offset(30);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    self.lineView1 = ({
        UIView *view = [UITextField new];
        [self.view addSubview:view];
        view.backgroundColor = KHexRGB(0xDBDBDB);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneTextFld.mas_bottom);
            make.left.mas_equalTo(self.view).offset(30);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    
    self.pwdTextFld = ({
        UITextField *view = [UITextField new];
        [self.view addSubview:view];
        view.textColor = [UIColor blackColor];
        view.secureTextEntry = YES;
        view.font = KFont(16);
        view.placeholder = @"请输入密码";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lineView1.mas_bottom).offset(23);
            make.left.mas_equalTo(self.view).offset(30);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    self.lineView2 = ({
        UIView *view = [UITextField new];
        [self.view addSubview:view];
        view.backgroundColor = KHexRGB(0xDBDBDB);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pwdTextFld.mas_bottom);
            make.left.mas_equalTo(self.view).offset(30);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    
    self.loginBtn = ({
        UIButton *view = [UIButton new];
        [self.view addSubview:view];
        [view setTitle:@"登录" forState:UIControlStateNormal];
        [view addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        view.backgroundColor = KHexRGB(0xEE2520);
        view.layer.cornerRadius = 22;
        view.clipsToBounds = YES;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lineView2.mas_bottom).offset(30);
            make.left.mas_equalTo(self.view).offset(30);
            make.width.mas_equalTo(KDeviceW-60);
            make.height.mas_equalTo(45);
        }];
        view;
    });
    
   
    self.forgetBtn = ({
        UIButton *view = [UIButton new];
        [self.view addSubview:view];
        [view setTitle:@"忘记密码" forState:UIControlStateNormal];
        view.titleLabel.font = KFont(14);
        [view addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        [view setTitleColor:KHexRGB(0x8F8F8F) forState:UIControlStateNormal];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.loginBtn.mas_bottom);
            make.right.mas_equalTo(self.loginBtn);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        view;
    });
    
//    _phoneTextFld.text = @"13264302360";//test
//    _pwdTextFld.text = @"123456";//test
    
}


- (void)drawRightBarButton{
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60+10, 40)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.titleLabel.font = KFont(16);
    [button setTitle:@"注册" forState:UIControlStateNormal];
    [button setTitleColor:KHexRGB(0x262626) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:button];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
}



@end
