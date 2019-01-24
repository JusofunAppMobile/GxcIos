//
//  AppDelegate.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/2.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "AppDelegate.h"
#import "BasicTabBarController.h"
#import <IQKeyboardManager.h>
#import "LoginController.h"
#import "BasicNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [KNotificationCenter addObserver:self selector:@selector(tokenInvalid) name:KTokenInvalid object:nil];

    [self setIQKeyboardManager];
    [self setTabControllers];
    return YES;
}



- (void)setTabControllers{
    NSArray *array = [User findAll];
    if(array.count>0){
        User *user ;
        user = [array objectAtIndex:0];
    }
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController= [[BasicTabBarController alloc]init];
    self.window.rootViewController = _tabBarController;
}

#pragma mark - 失效
-(void)tokenInvalid
{
    [MBProgressHUD showHint:@"token失效，请重新登录" toView:nil];
    KUSER.userId = @"";
    [User clearTable];
}

#pragma mark - 自动隐藏键盘的第三方类库
-(void)setIQKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.shouldShowToolbarPlaceholder = NO;
    manager.keyboardDistanceFromTextField = 120;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    KWeakSelf
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [weakSelf postPayDoneNotification:resultDic];
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        KWeakSelf
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
             [weakSelf postPayDoneNotification:resultDic];
        }];
    }
    return YES;
}

- (void)postPayDoneNotification:(NSDictionary *)resultDic{
    BOOL result = [resultDic[@"resultStatus"] intValue]==9000?YES:NO;//0表示成功，1表示失败
    NSDictionary *dic=@{@"result":@(result)};
    [KNotificationCenter postNotificationName:KPaySuccess object:nil userInfo:dic];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
