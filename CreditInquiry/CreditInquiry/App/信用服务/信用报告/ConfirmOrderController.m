//
//  ConfirmOrderController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ConfirmOrderController.h"
#import "MyTextField.h"
#import "ReportSendSuccessController.h"
#import "Tools.h"

@interface ConfirmOrderController ()

@property (nonatomic ,strong) UIButton *leftBtn;
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UILabel *priceLab;
@property (nonatomic ,strong) MyTextField *emailField;
@end

@implementation ConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"获取报告"];
    [self setBlankBackButton];
    [self initView];
}

#pragma mark - initView
- (void)initView{
    
    self.view.backgroundColor = KHexRGB(0xebf0f3);
    
    UIImageView *iconBg1 = [UIImageView new];
    iconBg1.image = KImageName(@"menu_bg01");
    [self.view addSubview:iconBg1];
    [iconBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(KNavigationBarHeight+20);
    }];
    
    UILabel *typeTitle = [UILabel new];
    typeTitle.text = @"报告类型：";
    typeTitle.font = KFont(14);
    typeTitle.textColor = KHexRGB(0x858687);
    [iconBg1 addSubview:typeTitle];
    [typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconBg1).offset(20);
        make.top.mas_equalTo(iconBg1).offset(35);
        make.height.mas_equalTo(16);
    }];
    
    NSString *reportName = _reportType == 1?@"企业报告-基础版":@"企业报告-专业版";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:reportName];
    [attr addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xf77f00) range:NSMakeRange(reportName.length-3, 3)];
    
    UILabel *typeLab = [UILabel new];
    typeLab.font = KFont(15);
    typeLab.textColor = KHexRGB(0x303030);
    typeLab.attributedText = attr;
    [iconBg1 addSubview:typeLab];
    [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(typeTitle.mas_right);
        make.centerY.mas_equalTo(typeTitle);
        make.right.mas_lessThanOrEqualTo(iconBg1).offset(-20);
    }];
    
    UILabel *goalTitle = [UILabel new];
    goalTitle.text = @"报告目标：";
    goalTitle.font = KFont(14);
    goalTitle.textColor = KHexRGB(0x858687);
    [iconBg1 addSubview:goalTitle];
    [goalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(typeTitle);
        make.top.mas_equalTo(typeTitle.mas_bottom).offset(21);
        make.height.mas_equalTo(16);
        make.bottom.mas_equalTo(iconBg1.mas_bottom).offset(-20);
    }];
    
    
    UILabel *goalLab = [UILabel new];
    goalLab.text = _companyName;
    goalLab.font = KFont(15);
    goalLab.textColor = KHexRGB(0x303030);
    goalLab.numberOfLines = 0;
    [iconBg1 addSubview:goalLab];
    [goalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goalTitle.mas_right);
        make.centerY.mas_equalTo(goalTitle);
        make.right.mas_equalTo(iconBg1).offset(-20);
    }];
    
    UIImageView *iconBg2 = [UIImageView new];
    iconBg2.image = KImageName(@"menu_bg02");
    [self.view addSubview:iconBg2];
    [iconBg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(iconBg1);
        make.top.mas_equalTo(iconBg1.mas_bottom);
        make.height.mas_equalTo((20.f/345)*(KDeviceW-15*2));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = KHexRGB(0xe6e6e6);
    [iconBg2 addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconBg2).offset(20);
        make.right.mas_equalTo(iconBg2).offset(-20);
        make.centerY.mas_equalTo(iconBg2);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *iconBg3 = [UIImageView new];
    iconBg3.image = KImageName(@"menu_bg03");
    iconBg3.userInteractionEnabled = YES;
    [self.view addSubview:iconBg3];
    [iconBg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(iconBg1);
        make.top.mas_equalTo(iconBg2.mas_bottom);
    }];
    
    self.emailField = ({
        MyTextField *textField = [MyTextField new];
        textField.placeholder = @"请输入接收报告的邮箱地址";
        textField.layer.borderWidth = 1.f;
        textField.borderStyle = UITextBorderStyleNone;
        textField.backgroundColor = KHexRGB(0xfcf3f0);
        textField.layer.borderColor = KHexRGB(0xe49192).CGColor;
        textField.layer.cornerRadius = 2;
        textField.layer.masksToBounds = YES;
        textField.font = KFont(14);
        [iconBg3 addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(iconBg3).offset(20);
            make.left.mas_equalTo(iconBg3).offset(20);
            make.right.mas_equalTo(iconBg3).offset(-20);
            make.height.mas_equalTo(40);
        }];
        textField;
    });
   
    UILabel *formatLab = [UILabel new];
    formatLab.text = @"报告格式：";
    formatLab.font = KFont(14);
    formatLab.textColor = KHexRGB(0x858687);
    [iconBg3 addSubview:formatLab];
    [formatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_emailField);
        make.top.mas_equalTo(_emailField.mas_bottom).offset(23);
        make.height.mas_equalTo(16);
    }];
    
    self.leftBtn = ({
        UIButton *leftBtn = [UIButton new];
        leftBtn.selected = YES;
        leftBtn.titleLabel.font = KFont(12);
        leftBtn.layer.cornerRadius = 2;
        leftBtn.layer.borderWidth = 1.f;
        leftBtn.layer.borderColor = KHexRGB(0xd31023).CGColor;
        leftBtn.layer.masksToBounds = YES;
        leftBtn.backgroundColor = KHexRGB(0xffefe9);
        [leftBtn setTitle:@"PDF" forState:UIControlStateNormal];
        [leftBtn setTitleColor:KHexRGB(0xd41124) forState:UIControlStateSelected];
        [leftBtn setTitleColor:KHexRGB(0x303030) forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(formatAction:) forControlEvents:UIControlEventTouchUpInside];
        [iconBg3 addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(formatLab);
            make.top.mas_equalTo(formatLab.mas_bottom).offset(18);
            make.width.mas_equalTo(82);
            make.height.mas_equalTo(34);
            make.bottom.mas_equalTo(iconBg3.mas_bottom).offset(-35);
        }];
        leftBtn;
    });
    
    
    self.rightBtn = ({
        UIButton *rightBtn = [UIButton new];
        rightBtn.titleLabel.font = KFont(12);
        rightBtn.layer.cornerRadius = 2;
        rightBtn.layer.borderWidth = 1.f;
        rightBtn.layer.borderColor =[UIColor clearColor].CGColor;
        rightBtn.layer.masksToBounds = YES;
        rightBtn.backgroundColor = KHexRGB(0xf1f2f3);
        [rightBtn setTitle:@"PDF+word" forState:UIControlStateNormal];
        [rightBtn setTitleColor:KHexRGB(0xd41124) forState:UIControlStateSelected];
        [rightBtn setTitleColor:KHexRGB(0x303030) forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(formatAction:) forControlEvents:UIControlEventTouchUpInside];
        [iconBg3 addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_leftBtn.mas_right).offset(22);
            make.top.width.height.mas_equalTo(_leftBtn);
        }];
        rightBtn.hidden = YES;
        rightBtn;
    });
    
    
    UIView *footerBar = [UIView new];
    footerBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerBar];
    [footerBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(53);
    }];
    
    UILabel *priceTitle = [UILabel new];
    priceTitle.font = KFont(16);
    priceTitle.textColor = KHexRGB(0x303030);
    priceTitle.text = @"待支付：";
    [footerBar addSubview:priceTitle];
    [priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footerBar);
        make.left.mas_equalTo(footerBar).offset(20);
    }];
    
    self.priceLab = ({
        UILabel *view = [UILabel new];
        [footerBar addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(footerBar);
            make.left.mas_equalTo(priceTitle.mas_right);
        }];
        view.font = KFont(12);
//        view.text = [NSString stringWithFormat:@"￥%@",_price];
        view.text = @"￥0";
        view.textColor = KHexRGB(0xd20b1e);
        view;
    });
    
    UIButton *sendBtn = [UIButton new];
    sendBtn.titleLabel.font = KFont(16);
    sendBtn.backgroundColor = KHexRGB(0xd31023);
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [footerBar addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(footerBar);
        make.width.mas_equalTo(125);
    }];

}

- (void)formatAction:(UIButton *)sender{
    if ([sender isEqual:_leftBtn]) {
        _leftBtn.selected = YES;
        _rightBtn.selected = NO;
        _leftBtn.backgroundColor = KHexRGB(0xffefe9);
        _rightBtn.backgroundColor = KHexRGB(0xf1f2f3);
        
        _leftBtn.layer.borderColor = KHexRGB(0xd31023).CGColor;
        _rightBtn.layer.borderColor = [UIColor clearColor].CGColor;

    }else{
        _rightBtn.selected = YES;
        _leftBtn.selected = NO;
        _rightBtn.backgroundColor = KHexRGB(0xffefe9);
        _leftBtn.backgroundColor = KHexRGB(0xf1f2f3);
        
        _rightBtn.layer.borderColor = KHexRGB(0xd31023).CGColor;
        _leftBtn.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

- (void)sendAction{
    
    if (!_emailField.text.length) {
        [MBProgressHUD showHint:@"请输入接收邮箱！" toView:self.view];
        return;
    }
    if (![Tools isEmailAddress:_emailField.text]) {
        [MBProgressHUD showHint:@"请输入正确的邮箱地址！" toView:self.view];
        return;
    }

    [MBProgressHUD showMessag:@"" toView:self.view];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_companyName forKey:@"companyName"];
    [params setObject:@(_reportType) forKey:@"type"];
    [params setObject:_emailField.text forKey:@"url"];

    [RequestManager postWithURLString:KSendCreditReport parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            ReportSendSuccessController *vc = [ReportSendSuccessController new];
            vc.msg = responseObject[@"data"][@"message"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

@end
