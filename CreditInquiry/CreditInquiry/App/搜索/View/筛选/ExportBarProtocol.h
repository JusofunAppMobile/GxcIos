//
//  ExportBarProtocol.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/7/23.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ExportBarProtocol <NSObject>
@required
- (void)exportBarSelectAllAction:(BOOL)selected;
- (void)exportBarExportAction;

@optional
- (void)sortByDate:(BOOL)selected;
@end
