//
//  RequestManager.h
//  JuXinReview
//
//  Created by WangZhipeng on 16/4/20.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};


@interface FileModel : NSObject

@property(nonatomic,copy)NSString *filePath;

@property(nonatomic,copy)NSString *fileKey;

@end

@interface RequestManager : NSObject


/**
 *  上传或者下载的进度
 *
 *  @param progress 进度
 */
typedef void (^RequestProgress)(NSProgress *progress);



#pragma mark -- POST请求 --
+ (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
                                 parameters:(id)parameters
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;



/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return NSURLSessionTask实例可以取消请求
 */
+ (NSURLSessionDataTask *)QXBGetWithURLString:(NSString *)URLString
                                parameters:(id)parameters
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure;

+ (NSURLSessionDataTask*)QXBGetHttpResponseWithURLString:(NSString *)URLString
                                           parameters:(id)parameters
                                              success:(void (^)(id responseObject))success
                                              failure:(void (^)(NSError *error))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return NSURLSessionTask实例可以取消请求
 */
+ (NSURLSessionDataTask *)QXBPostWithURLString:(NSString *)URLString
                                 parameters:(id)parameters
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return NSURLSessionTask实例可以取消请求
 */
+ (NSURLSessionDataTask *)QXBRequestWithURLString:(NSString *)URLString
                                    parameters:(id)parameters
                                          type:(HttpRequestType)type
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSError *error))failure;


#pragma mark -- 上传图片 --
+ (NSURLSessionDataTask *)uploadWithURLString:(NSString *)URLString
                                   parameters:(id)parameters
                                     progress:(RequestProgress)progress
                                  uploadParam:(NSString *)uploadParam
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

#pragma mark -- 上传图片 --
+ (NSURLSessionDataTask *)uploadWithURLString:(NSString *)URLString
                                   parameters:(id)parameters
                                     progress:(RequestProgress)progress
                                        image:(UIImage *)image
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

//路径
+ (NSURLSessionDataTask *)uploadWithURLString:(NSString *)URLString
                                   parameters:(id)parameters
                                     progress:(RequestProgress)progress
                                    imagePath:(NSString *)imagePath
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

@end




