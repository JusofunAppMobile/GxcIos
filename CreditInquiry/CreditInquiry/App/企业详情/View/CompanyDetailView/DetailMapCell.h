//
//  DetailMapCell.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/7.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIButton+LXMImagePosition.h>
NS_ASSUME_NONNULL_BEGIN

#define KDetailMapBtnTag 6342

@protocol DetailMapDelegate <NSObject>

-(void)detailMapButtonClick:(UIButton*)button;

@end


@interface DetailMapCell : UITableViewCell

@property(nonatomic,assign)id<DetailMapDelegate>delegate;



@end

NS_ASSUME_NONNULL_END
