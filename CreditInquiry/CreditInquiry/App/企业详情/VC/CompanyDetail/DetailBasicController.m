//
//  DetailBasicController.m
//  EnterpriseInquiry
//
//  Created by WangZhipeng on 17/9/6.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import "DetailBasicController.h"
#import "ObjectionAppealController.h"
@interface DetailBasicController ()
{
    //item的背景
    UIView *ChoosBackView;
    
    //item点击的背景
    UIView *tapView;
    
    //itme的高度
    CGFloat itemHeight;
    
    //item 是否展开
    BOOL isOpen;

}

@end

@implementation DetailBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    isOpen = NO;
    
    [self setNavigationRightButton];
    [self setBackBtn:@"blankBack"];
    [self setChooseView];
    [self setTitleView];
   
    
}

#pragma mark - view controller

- (void)displayViewController:(UIViewController *)controller {
    
    if (!controller) {
        return;
    }
    
    [self addChildViewController:controller];
    
    //[self.view addSubview:controller.view];
    
    [self.view insertSubview:controller.view belowSubview:ChoosBackView];
    
    [controller didMoveToParentViewController:self];
}

- (void)hideViewController:(UIViewController *)controller {
    
    if (!controller) {
        return;
    }
    [controller willMoveToParentViewController:nil];
    
    [controller.view removeFromSuperview];
    
    [controller removeFromParentViewController];
}


-(void)setDetailNavigationBarTitle:(NSString*)titleStr
{
    [self.titleButton setTitle:titleStr forState:UIControlStateNormal];
    [self.titleButton setImage:[Tools scaleImage:KImageName(@"灰色三角下拉") size:CGSizeMake(13, 7)] forState:UIControlStateNormal];
    [self.titleButton setImagePosition:LXMImagePositionRight spacing:10];
    
}


#pragma mark - 展开关闭选择栏
-(void)showItemView
{
    __block CGRect frameItem = self.itemView.frame;
    if(isOpen)
    {
        isOpen = NO;
        [UIView animateWithDuration:0.4 * 1.5
                              delay:0
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             frameItem.origin.y = - itemHeight;
                             self.itemView.frame = frameItem;
                             ChoosBackView.alpha = 0.0;
                             
                             self.titleButton.imageView.transform = CGAffineTransformIdentity;
                             
                         } completion:^(BOOL finished) {
                            
                         }];
    }
    else
    {
        isOpen = YES;
        [UIView animateWithDuration:0.4 * 1.5
                              delay:0
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             // frameItem.size.height = itemHeight;
                             frameItem.origin.y = KNavigationBarHeight;
                             self.itemView.frame = frameItem;
                             ChoosBackView.alpha = 1.0;
                            
                             self.titleButton.imageView.transform = CGAffineTransformRotate(self.titleButton.imageView.transform, M_PI);
                             
                         } completion:^(BOOL finished) {
                             //
                         }];
    }
    
}



#pragma mark - 纠错
-(void)errorCorrection{
    NSMutableDictionary *companyInfo = [NSMutableDictionary dictionary];
    [companyInfo setObject:_companyName?:@"" forKey:@"companyName"];
    [companyInfo setObject:_creditCode?:@"" forKey:@"code"];
    [companyInfo setObject:_companyNature?:@"" forKey:@"type"];

    ObjectionAppealController *vc = [ObjectionAppealController new];
    vc.companyInfo = companyInfo;
    vc.objectionType = ObjectionTypeError;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)back
{
    if(self.isWebViewPush)
    {
        DetailWebBasicController *vc = (DetailWebBasicController*)_currentVc;
        if([vc.webView canGoBack])
        {
            [vc.webView goBack];
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void)becomeActive
{
    [self.navigationController.navigationBar fs_setBackgroundColor:KHomeNavigationBarBackGroundColor];
}

#pragma mark - 设置下拉选择
-(void)setChooseView
{
    
    int count = (int)(self.itemArray.count%3 == 0?self.itemArray.count/3:self.itemArray.count/3+1);
    itemHeight = (35+0.5)* count;
    
    UIView *backView = [[UIView alloc]initWithFrame:self.view.frame];
    backView.backgroundColor = KRGBA(153, 153, 153, 0.5);
    [self.view addSubview:backView];
    ChoosBackView = backView;
    backView.alpha = 0;

    UIView *tapInstaneGView = [[UIView alloc] init];
    tapInstaneGView.frame = CGRectMake(0,0, backView.frame.size.width, self.view.frame.size.height);
    tapInstaneGView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showItemView)];
    [tapInstaneGView addGestureRecognizer:tapGest];
    tapView = tapInstaneGView;
    [backView addSubview:tapInstaneGView];
    
    ItemView *itemView = [[ItemView alloc] initWithframe:CGRectMake(0, -itemHeight, self.view.frame.size.width, itemHeight) andArray:self.itemArray andThisModel:self.itemModel];
    itemView.delegate = self;
    self.itemView = itemView;
    [backView addSubview:itemView];
}

#pragma mark - 设置self.title
-(void)setTitleView
{

    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.titleButton.frame = KFrame(0 ,0,KDeviceW - 120, 44);
    [self.titleButton setTitle:self.saveTitleStr forState:UIControlStateNormal];
    [self.titleButton setTitleColor:KRGB(51, 51, 51) forState:UIControlStateNormal];
    [self.titleButton setImage:[Tools scaleImage:KImageName(@"灰色三角下拉") size:CGSizeMake(13, 7)] forState:UIControlStateNormal];
    [self.titleButton setImagePosition:LXMImagePositionRight spacing:10];
    [self.titleButton addTarget:self action:@selector(showItemView) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = self.titleButton;
}


-(void)setNavigationRightButton
{
     UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44+10, 40)];
    
    self.errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.errorBtn.frame = CGRectMake(0, 0, 44, 44);
    self.errorBtn.titleLabel.font = KFont(16);
    [self.errorBtn setTitle:@"纠错" forState:UIControlStateNormal];
    [self.errorBtn setTitleColor:KRGB(51, 51, 51) forState:UIControlStateNormal];
    //[self.errorBtn setImage:KImageName(@"纠错") forState:UIControlStateNormal];
    [self.errorBtn addTarget:self action:@selector(errorCorrection) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:self.errorBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barView];

}



-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationController.navigationBar.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive)    name:UIApplicationDidBecomeActiveNotification object:nil];
    [self.navigationController.navigationBar fs_setBackgroundColor:KNavigationBarBackGroundColor];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter ] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
   
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
