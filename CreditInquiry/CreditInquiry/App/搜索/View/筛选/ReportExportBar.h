//
//  ReportExportBar.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/7/23.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExportBarProtocol.h"

@interface ReportExportBar : UIView

@property (nonatomic ,weak) id <ExportBarProtocol>delegate;
@property (nonatomic ,strong) UIButton *selectAllBtn;
@property (nonatomic ,assign) int barType;//0显示导出按钮，1不显示导出
@property (nonatomic ,assign) NSInteger exportNum;

- (void)setTipsWithNum:(NSString *)num type:(SearchType)type;

@end
