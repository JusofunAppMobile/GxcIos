//
//  DetailView.h
//  EnterpriseInquiry
//
//  Created by WangZhipeng on 17/9/4.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailInfoCell.h"
#import "DetailGridCell.h"
#import "CompanyDetailModel.h"
#import "ItemModel.h"
#import "DetailRiskCell.h"
#import "DetailMapCell.h"
#import <UIButton+LXMImagePosition.h>
#import "DetailHolderCell.h"
#define KDetailOperationTag  6452

//搜索的类型
typedef NS_ENUM(NSInteger, Headerype) {
    HeaderRiskType = 5638, //风险信息
    HeaderManageType  ,//经营状况
    HeaderMoneyType, //无形资产
    HeaderHodelType,//股东
    HeaderGGType//高管
};


@protocol DetailViewDelegate <NSObject>

-(void)callCompany:(NSString*)phoneStr;

-(void)companyAdress;

-(void)refreshCompany;

-(void)CompanyUrl:(NSString*)urlStr;

-(void)gridButtonClick:(ItemModel*)model cellSection:(int)section;

-(void)headerClick:(Headerype)type;

-(void)checkReport:(UIButton*)button;

-(void)downContact;

-(void)detailMapButtonClick:(UIButton *)button;

-(void)checkDetailRisk;

-(void)checkDetailMoreInfo;

-(void)detailHolderCheckMore:(DetailHolderType)type;

@end



@interface DetailView : UIView<UITableViewDelegate,UITableViewDataSource,DetailGridDelegate,DetailMapDelegate,DetailHolderDelegate>

@property(nonatomic,assign)id<DetailViewDelegate>delegate;

@property(nonatomic,strong)UITableView *backTableView;

@property(nonatomic,strong)CompanyDetailModel *detailModel;

@property(nonatomic,strong)NSDictionary *holderDic;//股东信息


-(void)reloadViewWithType:(Headerype)type gridArray:(NSArray*)array animate:(BOOL)animate;

-(void)beginRefreshAnimation;

-(void)stopRefreshAnimation;


@end
