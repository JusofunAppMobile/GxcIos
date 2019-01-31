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
    [self setTabBarAppearance];
}

- (void)setCustomBar{
    CustomTabBar *tabBar = [[CustomTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setTabControllers{
    
    self.homeVc= [HomeViewController new];
    _homeVc.tabBarItem.title = @"首页";
    _homeVc.tabBarItem.selectedImage =[self getOriginalImage:@"icon_home_sel"];
    _homeVc.tabBarItem.image =[self getOriginalImage:@"icon_home"];
    
    BasicNavigationController *homeNavi=[[BasicNavigationController alloc]initWithRootViewController:_homeVc];
    
    self.monitorVc=[[MonitorViewController alloc]init];
    _monitorVc.title = @"监控动态";
    _monitorVc.tabBarItem.selectedImage =[self getOriginalImage:@"icon_monitor_sel"];
    _monitorVc.tabBarItem.image =[self getOriginalImage:@"icon_monitor"];
    
    BasicNavigationController *monitorNavi=[[BasicNavigationController alloc]initWithRootViewController:_monitorVc];
    
    self.creditVc=[[CreditViewController alloc]init];
    _creditVc.title = @"企业服务";
    _creditVc.tabBarItem.selectedImage = [self getOriginalImage:@"icon_service_sel"];
    _creditVc.tabBarItem.image =[self getOriginalImage:@"icon_service"];
    
    BasicNavigationController *creditNavi=[[BasicNavigationController alloc]initWithRootViewController:_creditVc];

    
    self.meVc=[[MeViewController alloc]init];
    _meVc.title = @"我的";
    _meVc.tabBarItem.selectedImage = [self getOriginalImage:@"icon_mine_sel"];
    _meVc.tabBarItem.image =[self getOriginalImage:@"icon_mine"];
    
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
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:KHexRGB(0x9d9d9d)}
                                            forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:KHexRGB(0xd60010)}
                                            forState:UIControlStateSelected];
}


// 不自动旋转
-(BOOL)shouldAutorotate{

    return [self.selectedViewController shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{

    return [self.selectedViewController supportedInterfaceOrientations];
}


-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}


@end
