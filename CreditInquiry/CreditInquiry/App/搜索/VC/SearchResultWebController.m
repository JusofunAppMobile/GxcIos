//
//  SearchResultWebController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/24.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SearchResultWebController.h"

@interface SearchResultWebController ()<UISearchBarDelegate>

@end

@implementation SearchResultWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteBackButton];
    [self initView];
    [self loadData];
}

#pragma mark - initView
- (void)initView{
    UIView*searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceW - 20, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, (44-28)/2, KDeviceW - 60-15-15,  28)];
    [[searchBar.subviews[0] subviews][0] removeFromSuperview];
    searchBar.placeholder = KSearchPlaceholder;
    
   
    UITextField * searchField = [searchBar valueForKey:@"_searchField"];
    searchField.font = KFont(14);
    [searchField setValue:KFont(14) forKeyPath:@"_placeholderLabel.font"];
    
    searchBar.backgroundImage = nil;
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.delegate = self;
    searchBar.layer.cornerRadius = 14.f;
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.borderColor = KHexRGB(0xc8c8c8).CGColor;
    searchBar.layer.borderWidth = 1.f;
    [searchBar setImage:[UIImage imageNamed:@"home_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [searchView addSubview:searchBar];
    
    self.navigationItem.titleView = searchView;
    
    self.webView.frame = KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight);
}

- (void)loadData{
    [self showLoadDataAnimation];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_searchType) forKey:@"type"];
    [params setObject:_companyName forKey:@"name_one"];
    
    [RequestManager postWithURLString:KGETH5URL parameters:params success:^(id responseObject) {
        [self hideLoadDataAnimation];
        if ([responseObject[@"result"] intValue] == 0) {
            NSString *url = responseObject[@"data"][@"H5Address"];
            self.url = url;
            [self loadURL];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:self.webView.frame];
    }];
}

- (void)loadURL{
    NSURL*url=[NSURL URLWithString:self.url];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self back];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar fs_setBackgroundColor:KNavigationBarRedColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar fs_clearBackgroudCustomColor];
}

@end
