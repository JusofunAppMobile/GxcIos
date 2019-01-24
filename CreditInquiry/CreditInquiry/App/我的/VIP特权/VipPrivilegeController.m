//
//  VipPrivilegeController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/17.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "VipPrivilegeController.h"
#import "BuyVipController.h"

@interface VipPrivilegeController ()

@end

@implementation VipPrivilegeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.url = @"https://www.baidu.com/";//test
    
    self.webView.frame = KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight);
    [self loadWithUrl];
}

-(void)loadWithUrl{
    NSString *urlStr = [self.url  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL*url=[NSURL URLWithString:self.url];
    NSURLRequest*request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;

//    if ([urlStr hasPrefix:@"gxc://vip"]) {
//        BuyVipController *vc = [BuyVipController new];
//        vc.fromType = _fromType;
//        [self.navigationController pushViewController:vc animated:YES];
//        return NO;
//    }
    return YES;
}


@end
