//
//  AddressBookModel.h
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/5/4.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchBaseModel.h"

@interface AddressBookModel : SearchBaseModel

@property (nonatomic ,assign) BOOL expand;//展开收起
//@property (nonatomic ,assign) BOOL selected;//选中导出
//@property (nonatomic ,copy) NSString *companyname;
//@property (nonatomic ,copy) NSString *companylightname;
//@property (nonatomic ,copy) NSString *companyid;
//@property (nonatomic ,copy) NSString *companystate;
//@property (nonatomic ,copy) NSString *legal;
//@property (nonatomic ,copy) NSString *cratedate;
@property (nonatomic ,strong) NSArray *phoneArr;


@property (nonatomic ,copy) NSString *phone;
//@property (nonatomic ,copy) NSString *entId;//id
@property (nonatomic ,copy) NSString *operatingPeriodStart;
@property (nonatomic ,copy) NSString *type;
@property (nonatomic ,copy) NSString *legalPerson;
//@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *establishDate;
@property (nonatomic ,copy) NSString *companystate;

@end
//phone : 028-83336055,
//id : 35009358,
//operatingPeriodStart : <null>,
//type : 有限责任公司分公司(自然人投资或控股),
//legalPerson : 黎万强,
//name : 小米科技有限责任公司成都分公司,
//establishDate : 1328716800000

