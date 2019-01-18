//
//  User.h
//  EnterpriseInquiry
//
//  Created by LEZ on 16/8/12.
//  Copyright © 2016年 王志朋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JKDBModel.h>

#define KUSER [User sharedUser]

typedef enum : NSInteger{

    WeChatLogin = 1,
    WeiboLogin = 4,

}OtherLoginType;

@interface User : JKDBModel

SingletonH(User);


@property(nonatomic,assign)BOOL isUserLogin;

///用户userid
@property(nonatomic,copy)NSString *userId;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *email;

@property(nonatomic,copy)NSString *company;

@property(nonatomic,copy)NSString *department;

@property(nonatomic,copy)NSString *job;

@property(nonatomic,copy)NSString *trade;//行业

@property(nonatomic,copy)NSString *headIcon;

/**
 // 0：未认证 1：审核中 2：审核失败 3：审核成功
 */
@property(nonatomic,copy)NSString *authStatus;

//用户vip状态 0：普通用户 1：vip用户
@property(nonatomic,copy)NSString *vipStatus;

//消息推送开关状态 0：开 1：关
@property(nonatomic,copy)NSString *pushStatus;


@property(nonatomic,copy)NSString*token;




@end
