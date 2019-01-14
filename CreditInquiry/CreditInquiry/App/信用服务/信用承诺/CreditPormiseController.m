//
//  CreditPormiseController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditPormiseController.h"
#import "GetPhoto.h"

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
        view.backgroundColor = [UIColor greenColor];
        [view setImage:KImageName(@"") forState:UIControlStateNormal];
        view;
    });
    
    UIButton *uploadBtn = [UIButton new];
    uploadBtn.titleLabel.font = KFont(15);
    [uploadBtn setTitle:@"上传信用承诺书" forState:UIControlStateNormal];
    [uploadBtn setTitleColor:KHexRGB(0x303030) forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadBtn];
    [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_promiseView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view);
    }];

}

- (void)pickImageAction{
    KWeakSelf
    [[GetPhoto sharedGetPhoto] getPhotoWithTarget:self success:^(UIImage *image, NSString *imagePath) {
        NSLog(@"图片___%@",imagePath);
        [weakSelf.promiseView setImage:image forState:UIControlStateNormal];
    }];
}

- (void)uploadAction{

    NSLog(@"上传");
}

@end
