//
//  BasicTabBarController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/3.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BasicTabBarController.h"
#import "BasicNavigationController.h"
#import "HomeViewController.h"
#import "MonitorViewController.h"
#import "CreditViewController.h"
#import "MeViewController.h"
#import "CustomTabBar.h"

@interface BasicTabBarController ()
@property (nonatomic ,strong) HomeViewController *homeVc;
@property (nonatomic ,strong) MonitorViewController * monitorVc;
@property (nonatomic ,strong) CreditViewController *creditVc;
@property (nonatomic ,strong) MeViewController *meVc;

@end

@implementation BasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomBar];
    [self setTabControllers];
}

- (void)setCustomBar{
    CustomTabBar *tabBar = [[CustomTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setTabControllers{
    
    self.homeVc= [HomeViewController new];
    _homeVc.tabBarItem.title = @"首页";
    _homeVc.tabBarItem.selectedImage =[self getOriginalImage:@"tabbar1_h"];
    _homeVc.tabBarItem.image =[self getOriginalImage:@"tabbar1"];
    
    BasicNavigationController *homeNavi=[[BasicNavigationController alloc]initWithRootViewController:_homeVc];
    
    self.monitorVc=[[MonitorViewController alloc]init];
    _monitorVc.title = @"监控动态";
    _monitorVc.tabBarItem.selectedImage =[self getOriginalImage:@"tabbar2_h"];
    _monitorVc.tabBarItem.image =[self getOriginalImage:@"tabbar2"];
    
    BasicNavigationController *monitorNavi=[[BasicNavigationController alloc]initWithRootViewController:_monitorVc];
    
    self.creditVc=[[CreditViewController alloc]init];
    _creditVc.title = @"信用服务";
    _creditVc.tabBarItem.selectedImage = [self getOriginalImage:@"tabbar3_h"];
    _creditVc.tabBarItem.image =[self getOriginalImage:@"tabbar3"];
    
    BasicNavigationController *creditNavi=[[BasicNavigationController alloc]initWithRootViewController:_creditVc];

    
    self.meVc=[[MeViewController alloc]init];
    _meVc.title = @"我的";
    _meVc.tabBarItem.selectedImage = [self getOriginalImage:@"tabbar4_h"];
    _meVc.tabBarItem.image =[self getOriginalImage:@"tabbar4"];
    
    BasicNavigationController *meNavi=[[BasicNavigationController alloc]initWithRootViewController:_meVc];

    NSArray *array=[NSArray arrayWithObjects:homeNavi,monitorNavi,creditNavi,meNavi, nil];
    [self setViewControllers:array];
}


- (UIImage *)getOriginalImage:(NSString *)imageName{
    UIImage *img = [UIImage imageNamed:imageName];
    UIImage *image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (void)setTabBarAppearance{
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:KHexRGB(0xb1b1b1)}
                                            forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:KHexRGB(0xb1b1b1)}
                                            forState:UIControlStateSelected];
    [[UITabBar appearance]setTranslucent:NO];
}


@end
