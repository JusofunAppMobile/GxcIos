//
//  CreditChartLineCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditChartLineCell.h"
#import "XXLineChartView.h"
#import "CreditVisitorModel.h"

@interface CreditChartLineCell ()
@property (nonatomic ,strong) XXLineChartView *chartView;
@end
@implementation CreditChartLineCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.chartView];
    }
    return self;
}

- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;

    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *xTitles = [NSMutableArray array];

    for (int i = 0; i<dataList.count; i++) {
        CreditVisitorModel *model = _dataList[i];
        [values addObject:model.count];
        [xTitles addObject:model.date];
    }
    [self .chartView setXTittles:xTitles values:values];
}

- (XXLineChartView *)chartView{
    if (!_chartView) {
        _chartView = [[XXLineChartView alloc]initWithValues:nil xTittles:nil yTittles:@[@"175",@"150",@"125",@"100",@"75",@"50",@"25",@"0"]];
        _chartView.frame = CGRectMake(0, 0, self.width, 200);
    }
    return _chartView;
}


@end
