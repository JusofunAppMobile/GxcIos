//
//  CenterButton.h
//  JuXin
//
//  Created by clj on 16/7/28.
//  Copyright © 2016年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterButton : UIButton

//- (void)centerImageAndTitle;


@property(nonatomic,assign)BOOL isNew;

@property(nonatomic,strong)UIImageView *tipImageView;

@property(nonatomic,strong)NSDictionary *dataDic;

@end
