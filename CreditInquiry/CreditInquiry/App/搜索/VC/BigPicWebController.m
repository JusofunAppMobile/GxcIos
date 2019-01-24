//
//  BigPicWebController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/24.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BigPicWebController.h"

@interface BigPicWebController ()

@end

@implementation BigPicWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self setBackBtn:@"icon_back"];
    

    self.webView.frame = self.view.frame;
    [self loadWithUrl];
    [self hengshuping:true];

}


#pragma mark -
-(void)loadWithUrl{
    NSURL*url=[NSURL URLWithString:self.urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self hengshuping:NO];
    self.navigationController.navigationBarHidden = NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}


-(void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

//横屏
- (void)hengshuping:(BOOL)m_bScreen {
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        NSNumber *num = [[NSNumber alloc] initWithInt:(m_bScreen?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait)];
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)num];
        [UIViewController attemptRotationToDeviceOrientation];//这行代码是关键
    }
    
    SEL selector=NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation =[NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val =m_bScreen?UIInterfaceOrientationLandscapeRight:UIInterfaceOrientationPortrait;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}





@end
