//
//  VipPrivilegeController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/17.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "VipPrivilegeController.h"

@interface VipPrivilegeController ()

@end

@implementation VipPrivilegeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.url = @"https://www.baidu.com/";//test
    
    self.webView.frame = KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight);
    [self loadWithUrl];
}

-(void)loadWithUrl{
    NSString *urlStr = [self.url  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL*url=[NSURL URLWithString:urlStr];
    NSURLRequest*request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [self.webView loadRequest:request];
}


@end
