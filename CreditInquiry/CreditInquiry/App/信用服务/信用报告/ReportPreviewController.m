//
//  ReportPreviewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/17.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ReportPreviewController.h"

@interface ReportPreviewController ()

@end

@implementation ReportPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"企业报告"];
    [self setBlankBackButton];
    
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
