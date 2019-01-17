//
//  MsgSettingController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MsgSettingController.h"

@interface MsgSettingController ()
@property (nonatomic ,strong) UISwitch *switchView;
@end

@implementation MsgSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"消息推送"];
    [self setBlankBackButton];
    
    [self initView];
}

- (void)initView{

    self.view.backgroundColor = KHexRGB(0xf5f6f8);
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight+10);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(52);
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"接收新消息提醒";
    titleLab.font = KFont(15);
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView);
        make.left.mas_equalTo(bgView).offset(15);
    }];
    
    self.switchView = ({
        UISwitch *mySwitch = [UISwitch new];
        mySwitch.on = KUSER.pushStatus.intValue == 0 ? YES : NO;
        [mySwitch addTarget:self action:@selector(valueChanged) forControlEvents:(UIControlEventValueChanged)];
        [bgView addSubview:mySwitch];
        [mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgView);
            make.right.mas_equalTo(bgView).offset(-15);
        }];
        mySwitch;
    });
   
}

- (void)valueChanged{//加接口
    [MBProgressHUD showMessag:@"" toView:self.view];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_switchView.on?@(0):@(1) forKey:@"pushStatus"];
    
    [RequestManager postWithURLString:KChangeUserInfo parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
    }];

}

@end
