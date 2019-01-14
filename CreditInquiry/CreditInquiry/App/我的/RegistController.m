//
//  RegistController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "RegistController.h"

@interface RegistController ()

@property(nonatomic,strong)UIScrollView *backScrollView;

@property(nonatomic,strong)UIImageView *logoImageView;

@property(nonatomic,strong)UITextField *phoneTextFld;

@property(nonatomic,strong)UITextField *pwdTextFld;

@property(nonatomic,strong)UITextField *codeTextFld;


@property(nonatomic,strong)UIButton *codeBtn;

@property(nonatomic,strong)UIView *lineView1;

@property(nonatomic,strong)UIView *lineView2;

@property(nonatomic,strong)UIView *lineView3;

@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)YYLabel *agreementLabel;



@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBlankBackButton];
    
    
    [self drawView];
    
}

-(void)regist
{
    
    
}

-(void)getCode
{
    
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
    [params setObject:@"1" forKey:@"type"];
   
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
        [MBProgressHUD showError:@"哎呀，服务器开小差啦，请您稍等，马上回来~" toView:self.view];
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



-(void)agreement
{
    NSLog(@"服务协议");
}

-(void)privacyPolicy
{
    NSLog(@"隐私政策");
}


-(void)drawView
{
    
    self.backScrollView = ({
        UIScrollView *view = [UIScrollView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(KNavigationBarHeight);
            make.bottom.left.mas_equalTo(self.view);
            make.width.mas_equalTo(KDeviceW);
        }];
        view;
    });
    
    
    self.loginBtn = ({
        UIButton *view = [UIButton new];
        [self.backScrollView addSubview:view];
        [view setTitle:@"注册" forState:UIControlStateNormal];
        [view addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
        [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        view.backgroundColor = KHexRGB(0xEE2520);
        view.layer.cornerRadius = 22;
        view.clipsToBounds = YES;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backScrollView).offset(80);
            make.left.mas_equalTo(self.backScrollView).offset(30);
            make.width.mas_equalTo(KDeviceW-60);
            make.height.mas_equalTo(44);
        }];
        view;
    });
    
    self.pwdTextFld = ({
        UITextField *view = [UITextField new];
        [self.backScrollView addSubview:view];
        view.textColor = [UIColor blackColor];
        view.secureTextEntry = YES;
        view.font = KFont(16);
        view.placeholder = @"请输入密码";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.loginBtn.mas_top).offset(-30);
            make.left.mas_equalTo(self.backScrollView).offset(30);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    self.lineView2 = ({
        UIView *view = [UITextField new];
        [self.backScrollView addSubview:view];
        view.backgroundColor = KHexRGB(0xDBDBDB);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pwdTextFld.mas_bottom);
            make.left.mas_equalTo(self.backScrollView).offset(30);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    self.codeBtn = ({
        UIButton *view = [UIButton new];
        [self.backScrollView addSubview:view];
        [view setTitle:@"获取验证码" forState:UIControlStateNormal];
        view.titleLabel.font = KFont(16);
        [view addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
        [view setTitleColor:KHexRGB(0xF02F27) forState:UIControlStateNormal];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(self.pwdTextFld.mas_top).offset(-20);
            make.right.mas_equalTo(self.loginBtn);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(35);
        }];
        view;
    });
    
    self.codeTextFld = ({
        UITextField *view = [UITextField new];
        [self.backScrollView addSubview:view];
        view.textColor = [UIColor blackColor];
        view.font = KFont(16);
        view.placeholder = @"请输入验证码";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.pwdTextFld.mas_top).offset(-20);
            make.left.mas_equalTo(self.backScrollView).offset(30);
            make.height.mas_equalTo(35);
            make.right.mas_equalTo(self.codeBtn.mas_left).offset(-10);
        }];
        view;
    });
    
    self.lineView3 = ({
        UIView *view = [UITextField new];
        [self.backScrollView addSubview:view];
        view.backgroundColor = KHexRGB(0xDBDBDB);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeTextFld.mas_bottom);
            make.left.mas_equalTo(self.backScrollView).offset(30);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    
    
    self.phoneTextFld = ({
        UITextField *view = [UITextField new];
        [self.backScrollView addSubview:view];
        view.textColor = [UIColor blackColor];
        view.font = KFont(16);
        view.placeholder = @"请输入手机号码";
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.codeTextFld.mas_top).offset(-20);
            make.left.mas_equalTo(self.backScrollView).offset(30);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    self.lineView1 = ({
        UIView *view = [UITextField new];
        [self.backScrollView addSubview:view];
        view.backgroundColor = KHexRGB(0xDBDBDB);
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneTextFld.mas_bottom);
            make.left.mas_equalTo(self.backScrollView).offset(30);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(KDeviceW-60);
        }];
        view;
    });
    
    
    self.logoImageView = ({
        UIImageView *view = [UIImageView new];
        [self.backScrollView addSubview:view];
        view.image = KImageName(@"logo");
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.phoneTextFld.mas_top).offset(-50);
            
            make.centerX.mas_equalTo(self.backScrollView);
        }];
        view;
    });
    
    
    self.agreementLabel = ({
        YYLabel *view = [YYLabel new];
        [self.backScrollView addSubview:view];
        NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"注册即表示同意《服务协议》及《隐私政策》"];
        text.yy_font = [UIFont systemFontOfSize:14];
        text.yy_color = KHexRGB(0xA2A2A2);
        text.yy_alignment = NSTextAlignmentCenter;
        __weak typeof(self) weakself = self;
        [text yy_setTextHighlightRange:NSMakeRange(8, 4) color:KHexRGB(0xEE2520) backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            [weakself agreement];
        }];
        
        [text yy_setTextHighlightRange:NSMakeRange(15, 4) color:KHexRGB(0xEE2520) backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            [weakself privacyPolicy];
        }];
        view.attributedText = text;
        view.numberOfLines = 0;
        view.preferredMaxLayoutWidth = KDeviceW-60; //设置最大的宽度
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(10);
            make.left.mas_equalTo(self.backScrollView).offset(30);
            make.width.mas_equalTo(KDeviceW-60);
            
        }];
        view;
    });
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
}

@end
