//
//  CertificationCell.h
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define KCertificationTag 5321
@protocol CertificationDelegate <NSObject>

- (void)addImage:(NSInteger )indexPath;

@end


@interface CertificationCell : UITableViewCell


@property (nonatomic ,weak) id <CertificationDelegate>delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(int)type;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UITextField *textFld;

@property(nonatomic,strong)UILabel *introLabel;


@property(nonatomic,strong)UIButton*addBtn;

@property(nonatomic,strong)UILabel *reloadLabel;

@property(nonatomic,strong)UIImageView *addImageView;


@property(nonatomic,assign)NSInteger index;


-(void)setButtonImage:(UIImage*)image;


/**
 是否是仅用于展示
 */
@property(nonatomic,assign)BOOL isShow;


@end

NS_ASSUME_NONNULL_END
