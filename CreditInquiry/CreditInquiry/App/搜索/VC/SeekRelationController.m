//
//  SeekRelationController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SeekRelationController.h"
#import "SearchController.h"
#import "BigPicWebController.h"

@interface SeekRelationController ()<UITextFieldDelegate,UIWebViewDelegate>
{
    UITextField *fromTextFld;
    UITextField *toTextFld;
    
    UIButton *bigBtn;
    
}
@property (nonatomic ,assign) int textIndex;
@property (nonatomic ,strong) UIWebView *webView;
@property (nonatomic ,copy) NSString *urlStr;
@property (nonatomic ,strong) UIView *backView;
@end

@implementation SeekRelationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"查关系"];
    [self setBlankBackButton];
    
    [self drawView];
    
    [self addObserver];
}


-(void)drawView
{
    self.view.backgroundColor = KRGB(240, 242, 245);

    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.textColor = KRGB(153, 153, 153);
    label1.font = KFont(14);
    label1.text = @"从";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15+KNavigationBarHeight);
    }];
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"查关系" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = KFont(14);
    button.backgroundColor = KRGB(238, 37, 32);
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(30+KNavigationBarHeight);
        make.right.mas_equalTo(self.view).offset(-15);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = KRGB(219, 219, 219);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(button.mas_left).offset(-15);
    }];
    
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.textColor = KRGB(153, 153, 153);
    label2.font = KFont(14);
    label2.text = @"到";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
    }];
    
    fromTextFld = [[UITextField alloc]init];
    fromTextFld.textColor = KRGB(51, 51, 51);
    fromTextFld.font = KFont(14);
    fromTextFld.placeholder = @"请分别添加两个公司";
    fromTextFld.delegate = self;
    //[view setValue:KFont(14) forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:fromTextFld];
    [fromTextFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(10);
        make.right.mas_equalTo(lineView);
        make.top.mas_equalTo(label1);
    }];
    
    toTextFld = [[UITextField alloc]init];
    toTextFld.textColor = KRGB(51, 51, 51);
    toTextFld.font = KFont(14);
    toTextFld.placeholder = @"请分别添加两个公司";
    toTextFld.delegate = self;
    //[view setValue:KFont(14) forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:toTextFld];
    [toTextFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(10);
        make.right.mas_equalTo(lineView);
        make.top.mas_equalTo(label2);
        
    }];
    
   
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(KNavigationBarHeight);
        make.bottom.mas_equalTo(toTextFld.mas_bottom).offset(15);
    }];
    
    [label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [fromTextFld setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [toTextFld setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    
   
    
    
    UIImageView *bgView = [UIImageView new];
    bgView.image = KImageName(@"relation");
    [self.view addSubview:bgView];
   
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        //make.top.mas_equalTo(backView.mas_bottom).offset(50);
    }];
    
    [self.view layoutIfNeeded];
    
    
    if(bgView.y<=_backView.maxY)
    {
        [bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(_backView.mas_bottom).offset(30);
        }];
    }
    
    
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.textColor = KRGB(153, 153, 153);
    label3.font = KFont(16);
    label3.numberOfLines = 0;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"请分别添加2个公司\n再点击\"查关系\"发现关系";
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(45);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    
  
    
    bigBtn = [[UIButton alloc]init];
    [bigBtn setTitle:@"  点击查看大图" forState:UIControlStateNormal];
    [bigBtn setTitleColor:KRGB(231, 0, 11) forState:UIControlStateNormal];
    bigBtn.titleLabel.font = KFont(12);
    [bigBtn setImage:KImageName(@"fangda-2") forState:UIControlStateNormal];
    bigBtn.layer.cornerRadius = 5;
    bigBtn.clipsToBounds = YES;
    [bigBtn addTarget:self action:@selector(showBig) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bigBtn];
    bigBtn.layer.borderWidth = 1;
    bigBtn.layer.borderColor = KRGB(229, 229, 229).CGColor;
    bigBtn.layer.shadowOpacity = 0.5;// 阴影透明
    bigBtn.layer.shadowColor = KRGB(229, 229, 229).CGColor;// 阴影的颜色
    bigBtn.layer.shadowRadius = 1;// 阴影扩散的范围控制
    bigBtn.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    
    [bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(130);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-30);
        make.right.mas_equalTo(self.view).offset(-15);
    }];
    
//    fromTextFld.text = @"北京市通州区国有资本运营有限公司";
//    toTextFld.text = @"北京市民望房地产开发有限责任公司";
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:fromTextFld]) {
        _textIndex = 0;
    }else{
        _textIndex = 1;
    }
    SearchController *vc = [SearchController new];
    vc.searchType = SearchSeekRelationType;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

#pragma mark - 通知

- (void)addObserver{
    [KNotificationCenter addObserver:self selector:@selector(didSelectSearchResult:) name:KSelectSearchResultNoti object:nil];
}

- (void)didSelectSearchResult:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    
    
    if (_textIndex == 0) {
        fromTextFld.text = dic[@"companyName"];
    }else{
        toTextFld.text = dic[@"companyName"];
    }
}



#pragma mark - 按钮
-(void)search
{
    if (!fromTextFld.text.length||!toTextFld.text.length) {
        [MBProgressHUD showHint:@"请分别添加2个公司！" toView:self.view];
        return;
    }
    [self hideNetFailView];
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@(SearchSeekRelationType) forKey:@"type"];
    [params setObject:fromTextFld.text forKey:@"name_one"];
    [params setObject:toTextFld.text forKey:@"name_two"];
    [params setObject:@"3" forKey:@"route_num"];

    [RequestManager postWithURLString:KGETH5URL parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            _urlStr = responseObject[@"data"][@"H5Address"];
            [self loadURL];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:self.webView.frame];
    }];
    
}

-(void)showBig{//test
    
    if (!_urlStr) {
        [MBProgressHUD showHint:@"请先查关系" toView:self.view];
        return;
    }
    
    BigPicWebController *vc = [BigPicWebController new];
    vc.urlStr = _urlStr;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 网页加载
- (void)loadURL{
    self.webView = ({
        UIWebView *view = [UIWebView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_backView.mas_bottom).offset(5);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
        view.delegate = self;
        view.hidden = YES;
        view;
    });
    
    self.webView.hidden = NO;
    NSURL*url=[NSURL URLWithString:_urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showLoadDataAnimation];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideLoadDataAnimation];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self hideLoadDataAnimation];
    [self showNetFailViewWithFrame:self.webView.frame];
}

- (void)abnormalViewReload{
    if (_urlStr) {
        [self loadURL];
    }else{
        [self search];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar fs_setBackgroundColor: KNavigationBarBackGroundColor];
}

@end
