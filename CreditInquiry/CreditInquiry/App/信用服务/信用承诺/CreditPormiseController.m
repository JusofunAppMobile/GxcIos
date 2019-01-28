//
//  CreditPormiseController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditPormiseController.h"
#import "GetPhoto.h"
#import <UIButton+AFNetworking.h>
#import "CustomAlert.h"
#import "Tools.h"

@interface CreditPormiseController ()
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UIButton *promiseView;
@end

@implementation CreditPormiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"信用承诺书"];
    [self setBlankBackButton];
    // Do any additional setup after loading the view.
    [self initView];
}
#pragma mark - initView
- (void)initView{
    
    self.rightBtn = ({
        UIButton *view = [UIButton new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(KNavigationBarHeight+15);
            make.right.mas_equalTo(-15);
        }];
        view.titleLabel.font = KFont(14);
        [view setTitleColor:KHexRGB(0xed2a30) forState:UIControlStateNormal];
        [view setTitle:@"获取模版" forState:UIControlStateNormal];
        [view addTarget:self action:@selector(getSampleAction) forControlEvents:UIControlEventTouchUpInside];
        view;
    });
    
    self.promiseView = ({
        UIButton *view = [UIButton new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(KNavigationBarHeight+45);
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(185);
            make.height.mas_equalTo(125);
        }];
        [view addTarget:self action:@selector(pickImageAction) forControlEvents:UIControlEventTouchUpInside];
        [view setImage:KImageName(@"uploadDefault") forState:UIControlStateNormal];
        view;
    });
    
    UIButton *uploadBtn = [UIButton new];
    uploadBtn.titleLabel.font = KFont(15);
    [uploadBtn setTitle:@"上传信用承诺书" forState:UIControlStateNormal];
    [uploadBtn setTitleColor:KHexRGB(0x303030) forState:UIControlStateNormal];
    [self.view addSubview:uploadBtn];
    [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_promiseView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
}

#pragma mark - 获取模版
- (void)getSampleAction{
    KWeakSelf
    CustomAlert *alert = [[CustomAlert alloc]initWithTitle:@"发送至" style:1 placeholder:@"请输入模版接收邮箱" cancelButtonTitle:@"取消" otherButtonTitle:@"发送" callBack:^(NSString *text) {
        [weakSelf sendSampleTo:text];
    }];
    [alert showInView:self.view];
}

- (void)sendSampleTo:(NSString *)email{
    if (![Tools isEmailAddress:email]) {
        [MBProgressHUD showHint:@"" toView:self.view];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_companyName forKey:@"companyname"];
    [params setObject:email forKey:@"email"];

    
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KGetPromiseSample parameters:params success:^(id responseObject) {
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"发送成功！" toView:self.view];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
    
   
}

#pragma mark - 选取图片
- (void)pickImageAction{
    KWeakSelf
    [[GetPhoto sharedGetPhoto] getPhotoWithTarget:self success:^(UIImage *image, NSString *imagePath) {
        [weakSelf uploadImage:image];
    }];
}

- (void)uploadImage:(UIImage *)image{

    [MBProgressHUD showMessag:@"" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"promise" forKey:@"type"];
    
    [RequestManager uploadWithURLString:KUploadImage parameters:params progress:nil image:image success:^(id responseObject) {
        if ([responseObject[@"result"] intValue] == 0) {
            NSString *filepath = responseObject[@"data"][@"filepath"];
            [self commitEditInfo:filepath];
            [self.promiseView setImage:image forState:UIControlStateNormal];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

- (void)commitEditInfo:(NSString *)filePath{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:filePath forKey:@"Image"];
    [params setObject:_companyName forKey:@"companyname"];

    [RequestManager postWithURLString:KUploadPromise parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}


@end
