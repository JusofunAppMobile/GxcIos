//
//  MonitorMoreController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorMoreController.h"

@interface MonitorMoreController ()

@end

@implementation MonitorMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"动态详情" andTextColor:[UIColor whiteColor]];
    [self setBackBtn:nil];
    // Do any additional setup after loading the view.
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar fs_setBackgroundColor:KHexRGB(0xd51424)];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar fs_clearBackgroudCustomColor];
}


@end
