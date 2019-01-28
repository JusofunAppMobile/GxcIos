//
//  BigPicWebController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/24.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BigPicWebController.h"
#import <UIButton+LXMImagePosition.h>

@interface BigPicWebController ()

@end

@implementation BigPicWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightNaviButton];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self loadWithUrl];
    [self hengshuping:true];
}

- (void)setRightNaviButton{
    
    UIButton *leftBtn = [UIButton new];
    leftBtn.titleLabel.font = KFont(14);
    leftBtn.layer.cornerRadius = 4;
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.borderColor = KHexRGB(0xdfdfdf).CGColor;
    [leftBtn setTitle:@"退出" forState: UIControlStateNormal];
    [leftBtn setImage:KImageName(@"quit") forState:UIControlStateNormal];
    [leftBtn setTitleColor:KHexRGB(0xeb101e) forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(10);
        make.left.mas_equalTo(self.view).offset(15);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(33);
    }];
    
    UIButton *rightBtn = [UIButton new];
    rightBtn.titleLabel.font = KFont(14);
    rightBtn.layer.cornerRadius = 4;
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = KHexRGB(0xdfdfdf).CGColor;
    [rightBtn setTitle:@"保存" forState: UIControlStateNormal];
    [rightBtn setImage:KImageName(@"quit") forState:UIControlStateNormal];
    [rightBtn setTitleColor:KHexRGB(0xeb101e) forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-15);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(33);
    }];
    
    [leftBtn setImagePosition:LXMImagePositionLeft spacing:5];
    [rightBtn setImagePosition:LXMImagePositionLeft spacing:5];
}

- (void)rightAction {
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(self.webView.scrollView.contentSize, YES, 0.0);
    
    //保存collectionView当前的偏移量
    CGPoint savedContentOffset = self.webView.scrollView.contentOffset;
    CGRect saveFrame = self.webView.frame;
    
    //将collectionView的偏移量设置为(0,0)
    self.webView.scrollView.contentOffset = CGPointZero;
    self.webView.frame = CGRectMake(0, 0, self.webView.scrollView.contentSize.width, self.webView.scrollView.contentSize.height);
    
    //在当前上下文中渲染出collectionView
    [self.webView.layer renderInContext: UIGraphicsGetCurrentContext()];
    //截取当前上下文生成Image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //恢复collectionView的偏移量
    self.webView.scrollView.contentOffset = savedContentOffset;
    self.webView.frame = saveFrame;
    
    UIGraphicsEndImageContext();
    
    
    UIImageWriteToSavedPhotosAlbum(image,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        [MBProgressHUD showSuccess:@"保存失败" toView:self.view];
        // Show error message…
    }
    else  // No errors
    {
        [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
        // Show message image successfully saved
    }
}
#pragma mark -
-(void)loadWithUrl{
    NSURL*url=[NSURL URLWithString:self.urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
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

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return ( UIInterfaceOrientationPortrait |UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
}



// 不自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

//
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return ( UIInterfaceOrientationPortrait |UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    self.navigationController.navigationBarHidden = YES;

    [self hengshuping:true];
}

-(void)viewWillDisappear:(BOOL)animated{

    [self hengshuping:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    self.navigationController.navigationBarHidden = NO;
}


@end
