//
//  CreditChartLineCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditChartLineCell.h"
#import "XXLineChartView.h"

@implementation CreditChartLineCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor cyanColor];
        XXLineChartView *chartView = [[XXLineChartView alloc]initWithValues:@[@52,@64,@35,@100,@78,@70,@61] xTittles:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月"] yTittles:@[@"175",@"150",@"125",@"100",@"75",@"50",@"25",@"0"]];//test
        chartView.frame = CGRectMake(0, 0, self.width, 200);
        [self.contentView addSubview:chartView];
    }
    return self;
}

@end
