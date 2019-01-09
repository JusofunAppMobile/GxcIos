//
//  ExportBar.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/5/2.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExportBarProtocol.h"

//@protocol ExportBarDelegate<NSObject>
//
//- (void)exportBarSelectAllAction:(BOOL)selected;
//- (void)exportBarExportAction;
//- (void)sortByDate:(BOOL)selected;
//@end

@interface ExportBar : UIView
@property (nonatomic ,weak) id <ExportBarProtocol>delegate;
@property (nonatomic ,strong) UIButton *selectAllBtn;
@end
