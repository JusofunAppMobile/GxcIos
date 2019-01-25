//
//  NewCommonWebController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/24.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "NewCommonWebController.h"
#import "EditCompanyInfoController.h"
#import "EditProductController.h"
#import "EditHonorController.h"
#import "EditPartnerController.h"
#import "EditMemberController.h"
#import "BuyVipController.h"

@implementation NewCommonWebController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (_urlStr.length) {
        [self loadWithUrl];
    }else{
        [self getWebURL];
    }
}
#pragma mark - getURL
- (void)getWebURL{
    if (!_params) {
        return;
    }
    [self showLoadDataAnimation];
    [RequestManager postWithURLString:KGETH5URL parameters:_params success:^(id responseObject) {
        [self hideLoadDataAnimation];
        if ([responseObject[@"result"] intValue] == 0) {
            _urlStr = responseObject[@"data"][@"H5Address"];
            _webType = [responseObject[@"data"][@"webType"] intValue];
            [self setupNavi];
            [self loadWithUrl];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:self.webView.frame];
    }];
}
#pragma mark -
-(void)loadWithUrl{
    NSURL*url=[NSURL URLWithString:self.urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    
    NSString *urlStr = [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (urlStr.length >= Md5Encryption.length) {
        NSString *demoStr = [urlStr substringWithRange:NSMakeRange(0, Md5Encryption.length)];
        if ([demoStr isEqualToString:Md5Encryption]) {
            return NO;
        }
    }
   
    NSLog(@"伪链接___%@",urlStr);
    if ([urlStr containsString:@"gxc://edit"]) {
        
        NSDictionary *dic = [self parseString:urlStr];
        int type = [dic[@"type"] intValue];
        if (type == 1) {
            EditCompanyInfoController *vc = [EditCompanyInfoController new];
            vc.companyId = dic[@"id"];
            vc.companyName = _companyName;
            vc.reloadBlock = ^{
                [self.webView reload];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == 2){
            EditProductController *vc = [EditProductController new];
            vc.productId = dic[@"id"];
            vc.companyName = _companyName;
            vc.reloadBlock = ^{
                [self.webView reload];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == 3){
            EditHonorController *vc = [EditHonorController new];
            vc.honorId = dic[@"id"];
            vc.reloadBlock = ^{
                [self.webView reload];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == 4){
            EditPartnerController *vc = [EditPartnerController new];
            vc.partnerId = dic[@"id"];
            vc.reloadBlock = ^{
                [self.webView reload];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (type == 5){
            EditMemberController *vc = [EditMemberController new];
            vc.empId = dic[@"id"];
            vc.reloadBlock = ^{
                [self.webView reload];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        return NO;
    }
    if ([urlStr containsString:@"gxc://vip"]) {
        BuyVipController *vc = [BuyVipController new];
        vc.target = _target;
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    
    
    return YES;
}

#pragma mark - 解析
- (NSDictionary *)parseString:(NSString *)string{
    
    NSString *str = [string stringByReplacingOccurrencesOfString:@"gxc://edit?" withString:@""];
    NSArray *arr = [str componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSArray *typeArr = [arr[0] componentsSeparatedByString:@"="];
    
    if (typeArr[1]) {
        [dic setObject:typeArr[1] forKey:@"type"];
    }
    if (arr.count ==2) {
        NSArray *idArr = [arr[1] componentsSeparatedByString:@"="];
        if (idArr[1]) {
            [dic setObject:idArr[1] forKey:@"id"];
        }
    }
   
    return dic;
}


- (void)setupNavi{
    if (_webType == 1) {//全屏
        [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
        self.webView.frame = self.view.frame;
        [self setBackBtn:@"icon_back"];
    }else{
        //        [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor whiteColor]];
        [self setBackBtn:@"blankBack"];
        self.webView.frame = KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight);
        [self setNavigationBarTitle:self.titleStr ];
    }
}

#pragma mark -
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupNavi];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar
}


@end
