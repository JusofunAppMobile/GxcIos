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



-(void)forgetPassword{
    
    [self.view endEditing:YES];
    if (_phoneText.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:self.view];
        return;
    }
    if (_codeText.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码" toView:self.view];
        return;
    }
    if (_pwdText.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_phoneText.text forKey:@"phone"];
    [params setObject:_codeText.text forKey:@"code"];
    [params setObject:[JAddField desEncryptWithString:_pwdText.text]  forKey:@"newpassword"];
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KForgetPassword parameters:params  success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:NO];
        if ([responseObject[@"result"] integerValue] == 0) {
         
            [MBProgressHUD showSuccess:@"找回成功" toView:nil];
            [self back];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
            
            
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
    }];
    
    
}

-(void)getCode
{
    
    if (_phoneText.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:self.view];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_phoneText.text forKey:@"phone"];
    [params setObject:@"4" forKey:@"type"];
    
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KSendMesCode parameters:params  success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:NO];
        if ([responseObject[@"result"] integerValue] == 0) {
            
            [self startTimer];
            
            [MBProgressHUD showSuccess:@"发送验证码成功" toView:self.view];
            
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
            
            
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
    }];
    
}



-(void)startTimer{
    
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _codeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_codeBtn  setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _codeBtn .userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
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
            make.height.mas_equalTo(35);
            make.left.mas_equalTo(prefixLab.mas_right).offset(10);
            make.right.mas_equalTo(self.view).offset(-35).priorityLow();
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
        [view addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_bottom).offset(35);
            make.right.mas_equalTo(self.view).offset(-35);
            make.height.mas_equalTo(35);
        }];
        view.titleLabel.font = KFont(16);
        [view setTitle:@"获取验证码" forState:UIControlStateNormal];
        [view setTitleColor:KHexRGB(0xeb101e) forState:UIControlStateNormal];
        view;
    });
    [self.codeBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    self.codeText = ({
        UITextField *view = [UITextField new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_codeBtn);
            make.left.mas_equalTo(_phoneText);
            make.height.mas_equalTo(35);
            make.right.mas_equalTo(_codeBtn.mas_left).offset(-20);
        }];
        view.placeholder = @"请输入验证码";
        view.font = KFont(15);
        view;
    });
    [self.codeText setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = KHexRGB(0xd3d3d3);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeBtn.mas_bottom);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(.5);
    }];
    
    self.pwdText = ({
        UITextField *view = [UITextField new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line2.mas_bottom).offset(35);
            make.height.mas_equalTo(35);
            make.left.mas_equalTo(prefixLab.mas_right).offset(10);
            make.right.mas_equalTo(self.view).offset(-35).priorityLow();
        }];
        view.placeholder = @"请输入新密码";
        view.font = KFont(15);
        view;
    });
    [prefixLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.phoneText setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [prefixLab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.phoneText setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.pwdText setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.pwdText setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    UIView *line3 = [UIView new];
    line3.backgroundColor = KHexRGB(0xd3d3d3);
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdText.mas_bottom);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(.5);
    }];
    
    
    UIButton *footerBtn = [UIButton new];
    footerBtn.backgroundColor = KHexRGB(0xeb101e);
    footerBtn.layer.cornerRadius = 20;
    footerBtn.layer.masksToBounds = YES;
    [footerBtn setTitle:@"完成" forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
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
