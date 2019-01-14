//
//  UILabel+Alignment.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/14.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "UILabel+Alignment.h"
#import <CoreText/CoreText.h>

@implementation UILabel (Alignment)

- (void)changeAlignmentLeftAndRight{
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    CGFloat margin = (self.frame.size.width - textSize.width)/(self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attr addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length -1)];
    self.attributedText = attr;
}



@end
