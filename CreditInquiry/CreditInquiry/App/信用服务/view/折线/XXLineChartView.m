//
//  XXLineChartView.m
//  NewTest
//
//  Created by 王旭 on 16/5/31.
//  Copyright © 2016年 pitt. All rights reserved.
//

#import "XXLineChartView.h"
#define KHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface XXLineChartView ()



@property (nonatomic, strong) NSArray *yTittles;

@end

@implementation XXLineChartView


- (instancetype)initWithValues:(NSArray *)values xTittles:(NSArray *)xTittles yTittles:(NSArray *)yTittles {
    self = [self init];
    if (self) {
        self.values = values;
        self.xTittles = xTittles;
        self.yTittleCount = yTittles.count;
        self.yTittles = yTittles;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backLineColor = KHexRGB(0xe4e4e4);
        self.circleColor = KHexRGB(0xf80012);
        self.lineColor = KHexRGB(0xee000c);
        self.axisTitleColor = KHexRGB(0x2a2a2a);
        //    self.downColor = [tintColor colorWithAlphaComponent:0.05];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 动画
/**
 *  填充动画过程
 *
 *  @return CABasicAnimation
 */
- (CABasicAnimation *)animation{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = 2;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = @(0.f);
    fillAnimation.toValue = @(1.f);
    
    return fillAnimation;
}

- (void)drawRect:(CGRect)rect {
    if (!self.xTittles.count) {
        return;
    }
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    //画轴线
    CGFloat xAxisX = 15;
    CGFloat xAxisY = height -20 -25;//距底部25
    CGFloat xAxisWidth = width-15*2;

    
    CGFloat yAxisX = 30;
    CGFloat yAxisY = 0;

    
    NSMutableArray *pathArr = [NSMutableArray array];
  
    CGFloat yTittleMargin = (xAxisY - yAxisY)/(self.yTittleCount-1);
    for (int i = 0; i < self.yTittleCount; i++) {
        //绘制背景横线
        CGFloat x = yAxisX;
        CGFloat y = yTittleMargin * (i) + yAxisY;

        [pathArr addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        [pathArr addObject:[NSValue valueWithCGPoint:CGPointMake(xAxisX + xAxisWidth, y)]];

        //y轴标题
        if (i%2 != 0) {
            NSString *str = self.yTittles[i];
            CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
            [str drawInRect:CGRectMake(yAxisX - strSize.width - 3, y - strSize.height, strSize.width, strSize.height)
             withAttributes:@{NSForegroundColorAttributeName : self.axisTitleColor,
                              NSFontAttributeName            : [UIFont systemFontOfSize:10]}];
        }
    
    }
    
    CGPoint pointL =  CGPointMake(xAxisX, xAxisY);
    CGPoint pointR =  CGPointMake(xAxisX+xAxisWidth, xAxisY);
    [pathArr addObject:[NSValue valueWithCGPoint:pointL]];
    [pathArr addObject:[NSValue valueWithCGPoint:pointR]];
    
    for (int i= 0; i<pathArr.count-4; i=i+4) {
    
        CGPoint pointL = [(NSValue *)pathArr[i] CGPointValue];
        CGPoint pointR = [(NSValue *)pathArr[i+1] CGPointValue];

        CGPoint pointL1 = [(NSValue *)pathArr[i+2] CGPointValue];
        CGPoint pointR1 = [(NSValue *)pathArr[i+3] CGPointValue];

        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:pointL];
        [path addLineToPoint:pointR];
        [path addLineToPoint:pointR1];
        [path addLineToPoint:pointL1];

        [KHexRGB(0xf2f2f2) set];//色块颜色
        [path fill];
        [path closePath];
    }
    
    
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    CGFloat margin = 20;//多余露出边界
    CGFloat xTittleMargin = (xAxisX + xAxisWidth - yAxisX - 2 * margin)/(self.xTittles.count - 1);

    [self.xTittles enumerateObjectsUsingBlock:^(NSString *xTittle, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //绘制背景纵线
        [self.backLineColor set];

        CGFloat x = yAxisX + margin + xTittleMargin * idx;
        CGFloat backLineY =  yAxisY ;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x, backLineY)];
        [path addLineToPoint:CGPointMake(x, xAxisY)];
        path.lineWidth = 1;
        [path stroke];
        
        //x轴标题
        //        CGSize strSize = [xTittle sizeWithFont:[UIFont systemFontOfSize:10]];
        CGSize strSize = [xTittle sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
        CGFloat xTittleLeftMargin = strSize.width / 2 > margin? strSize.width/2 - margin + 1 : 0;
        
        [xTittle drawInRect:CGRectMake(x - strSize.width/2 + xTittleLeftMargin, xAxisY + 3, strSize.width, 20)
             withAttributes:@{NSForegroundColorAttributeName  : self.axisTitleColor,
                              NSFontAttributeName             : [UIFont systemFontOfSize:10]}];
        
        if (idx < self.values.count) {
            //画圆
            NSNumber *number = self.values[idx];
            CGFloat y = xAxisY - (number.floatValue / [self.yTittles[0] integerValue] * yTittleMargin * (self.yTittleCount-1));
            
            [self.circleColor set];//圆的颜色
            UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x - 2.5, y - 2.5, 5, 5)];
            [circle fill];
            
            //设置line关键节点
            if (idx == 0) {
                [linePath moveToPoint:CGPointMake(x , y)];
            }else {
                [linePath addLineToPoint:CGPointMake(x , y)];
            }
            
        }
    }];
    linePath.lineJoinStyle = kCGLineJoinRound;
    [self.lineColor set];//线的颜色
    [linePath stroke];
    
   
//    [linePath addLineToPoint:CGPointMake(yAxisX + margin + (self.values.count - 1) * xTittleMargin , xAxisY)];
//    [linePath addLineToPoint:CGPointMake(yAxisX + margin, xAxisY)];
//    [self.downColor set];//线下阴影颜色
//    [linePath fill];
 
}




@end
