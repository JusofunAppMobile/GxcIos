//
//  CommonWebView.m
//  EnterpriseInquiry
//
//  Created by WangZhipeng on 16/8/11.
//  Copyright © 2016年 王志朋. All rights reserved.
//

#import "CommonWebViewController.h"


@implementation CommonWebViewController
{
    NSString  *_firstUrl;
    NSString  *_nowUrl;
    BOOL      _isFirst;
    UIButton  *shareBarButton;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBackBtn:@"blankBack"];
    [self setNavigationBarTitle:self.titleStr ];
    
    self.webView.frame = KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight);
    
    [self loadWithUrl];
    
    if(self.dataDic){
        KWeakSelf;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC)); dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
            NSString *jsStr = [NSString stringWithFormat:@"setDetailsData(%@)",[Tools dictionaryConvertToJsonData:self.dataDic]];
            [weakSelf.webView stringByEvaluatingJavaScriptFromString:jsStr];
        
        });
    }
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    NSString *URLStr =[self URLDecodedString: [[request URL] absoluteString]];

    if (URLStr.length >= Md5Encryption.length) {
        NSString *demoStr = [URLStr substringWithRange:NSMakeRange(0, Md5Encryption.length)];
        if ([demoStr isEqualToString:Md5Encryption]) {
            return NO;
        }
    }
    //    _nowUrl = [NSString stringWithFormat:@"%@",request.URL.absoluteString];
    NSString *urlStr = request.URL.absoluteString;
    _nowUrl = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (_isFirst) {
        _isFirst = NO;
        _firstUrl = _nowUrl;
    }
    
   

    return YES;
}


/**
 *  加载失败动画点击重新加载方法
 */
-(void)abnormalViewReload
{
    [self loadWithUrl];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar fs_setBackgroundColor:KHomeNavigationBarBackGroundColor];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showLoadDataAnimation];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideLoadDataAnimation];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideLoadDataAnimation];
    [self showNetFailViewWithFrame:self.webView.frame];
}




-(NSString *)URLDecodedString:(NSString*)stringURL
{
    return (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)stringURL,CFSTR(""),kCFStringEncodingUTF8);
}

-(void)loadWithUrl
{
    
    NSString *urlStr = [self.urlStr  stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL*url=[NSURL URLWithString:urlStr];
    NSURLRequest*request;
    if (!url) {
        NSString  *theUrl = [self.urlStr  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _firstUrl = theUrl;
        NSURL*nowUrl=[NSURL URLWithString:theUrl];
        request=[NSURLRequest requestWithURL:nowUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    }else{
        request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    }
    
    [self.webView loadRequest:request];
    
}


//点击返回
-(void)back
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;

    }
}

//右滑返回
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        if (![self.webView canGoBack]) {
            return YES;
        }else{
            return NO;
        }
    }else if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]&& [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        
        return YES;
    }else{
        return  NO;
    }
}




@end
