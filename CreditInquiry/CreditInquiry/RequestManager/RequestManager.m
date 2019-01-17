//
//  RequestManager.m
//  JuXinReview
//
//  Created by WangZhipeng on 16/4/20.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RequestManager.h"
#import <AFNetworkActivityIndicatorManager.h>
//#import "FileModel.h"

@implementation RequestManager


+(AFHTTPSessionManager*)sharedHTTPSessionManager:(BOOL)isJSONRequest
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求参数设置

    if(isJSONRequest)
    {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else
    {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }

    //返回参数设置
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置请求头
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"AppType"];
    [manager.requestSerializer setValue:@"AppStore" forHTTPHeaderField:@"Channel"];
    [manager.requestSerializer setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forHTTPHeaderField:@"Deviceid"];
    [manager.requestSerializer setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Version"];
    [manager.requestSerializer setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"versionnum"];
    [manager.requestSerializer setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forHTTPHeaderField:@"did"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"from"];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[
                                                                              @"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*",
                                                                              @"application/x-www-form-urlencoded; charset=UTF-8"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = 60;
    
    return manager;
}


+(AFHTTPSessionManager*)QXBSharedHTTPSessionManager
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求参数设置
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    //返回参数设置
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置请求头
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"AppType"];
    [manager.requestSerializer setValue:@"AppStore" forHTTPHeaderField:@"Channel"];
    [manager.requestSerializer setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forHTTPHeaderField:@"Deviceid"];
    [manager.requestSerializer setValue:@"3.0.0" forHTTPHeaderField:@"Version"];
    
    
    [manager.requestSerializer setValue:@"3.0.0" forHTTPHeaderField:@"versionnum"];
    [manager.requestSerializer setValue:[UIDevice currentDevice].identifierForVendor.UUIDString forHTTPHeaderField:@"did"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"from"];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = 60;
    
    return manager;
}


#pragma mark -- GET请求 --
+ (NSURLSessionDataTask *)QXBGetWithURLString:(NSString *)URLString
                                parameters:(id)parameters
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure {
    
    //给每个接口添加t跟m字段
    NSMutableDictionary *tmpDic = [Tools QXBAddDictionary:parameters];
    
    AFHTTPSessionManager *manager = [self QXBSharedHTTPSessionManager];
    
    NSURLSessionDataTask *session = [manager GET:URLString parameters:tmpDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
           [self getDateWithTask:task];
            NSLog(@"\nGET请求：Request success, URL: %@\n params:%@\n ",
                  [self generateGETAbsoluteURL:URLString params:tmpDic],
                  tmpDic);
            success( responseObject );
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
          [self getDateWithTask:task];
            NSLog(@"\nGET请求：Request failure, URL: %@\n params:%@\n",
                  [self generateGETAbsoluteURL:URLString params:tmpDic],
                  tmpDic);
            failure(error);
        }
    }];
    
    return session;
}

+ (NSURLSessionDataTask*)QXBGetHttpResponseWithURLString:(NSString *)URLString
                                           parameters:(id)parameters
                                              success:(void (^)(id responseObject))success
                                              failure:(void (^)(NSError *error))failure
{
    //给每个接口添加t跟m字段
    NSMutableDictionary *tmpDic = [Tools QXBAddDictionary:parameters];
    
    AFHTTPSessionManager *manager = [self QXBSharedHTTPSessionManager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *session = [manager GET:URLString parameters:tmpDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
           [self getDateWithTask:task];
            NSLog(@"\nGET请求：Request success, URL: %@\n params:%@\n ",
                  [self generateGETAbsoluteURL:URLString params:tmpDic],
                  tmpDic);
            success( responseObject );
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
           [self getDateWithTask:task];
            NSLog(@"\nGET请求：Request success, URL: %@\n params:%@\n",
                  [self generateGETAbsoluteURL:URLString params:tmpDic],
                  tmpDic);
            failure(error);
        }
    }];
    
    return session;
}


#pragma mark -- POST请求 --
+ (NSURLSessionDataTask *)QXBPostWithURLString:(NSString *)URLString
                                 parameters:(id)parameters
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure {
    
    //给每个接口添加t跟m字段
    NSMutableDictionary *tmpDic = [Tools QXBAddDictionary:parameters];
    
    AFHTTPSessionManager *manager = [self QXBSharedHTTPSessionManager];
    
    NSURLSessionDataTask *session = [manager POST:URLString parameters:tmpDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
          [self getDateWithTask:task];
            NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n 返回内容：%@",
                  [self generateGETAbsoluteURL:URLString params:tmpDic],
                  tmpDic,responseObject);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
           [self getDateWithTask:task];
            NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n",
                  [self generateGETAbsoluteURL:URLString params:tmpDic],
                  tmpDic);
            failure(error);
        }
    }];
    
    
    return session;
}

#pragma mark -- POST请求 --
+ (NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
                                    parameters:(id)parameters
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSError *error))failure {
    
    //给每个接口添加t跟m字段
    NSMutableDictionary *tmpDic = [self addDictionary:parameters];
    
    AFHTTPSessionManager *manager = [self sharedHTTPSessionManager:NO];
    
    NSURLSessionDataTask *session = [manager POST:URLString parameters:tmpDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            [self verifyToekn:responseObject];
            [self getDateWithTask:task];
            NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n 返回内容：%@",
                  [self generateGETAbsoluteURL:URLString params:tmpDic],
                  tmpDic,responseObject);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            [self getDateWithTask:task];
            NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n",
                  [self generateGETAbsoluteURL:URLString params:tmpDic],
                  tmpDic);
            failure(error);
        }
    }];
    
    
    return session;
}



#pragma mark -- POST/GET网络请求 --
+ (NSURLSessionDataTask *)QXBRequestWithURLString:(NSString *)URLString
                                    parameters:(id)parameters
                                          type:(HttpRequestType)type
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSError *error))failure {
    //给每个接口添加t跟m字段
    NSMutableDictionary *tmpDic = [Tools QXBAddDictionary:parameters];
    AFHTTPSessionManager *manager = [self QXBSharedHTTPSessionManager];
    NSURLSessionDataTask *session = nil;
    switch (type) {
        case HttpRequestTypeGet:
        {
            session = [manager GET:URLString parameters:tmpDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    [self getDateWithTask:task];
                    NSLog(@"\nget请求：Request success, URL: %@\n params:%@\n 返回内容：%@",
                          [self generateGETAbsoluteURL:URLString params:parameters],
                          parameters,responseObject);
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                   [self getDateWithTask:task];
                    NSLog(@"\nGET请求：Request success, URL: %@\n params:%@\n",
                          [self generateGETAbsoluteURL:URLString params:parameters],
                          parameters);
                    
                    failure(error);
                }
            }];
            
            
        }
            break;
        case HttpRequestTypePost:
        {
            session = [manager POST:URLString parameters:tmpDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    
                   [self getDateWithTask:task];
                    NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n 返回内容：%@",
                          [self generateGETAbsoluteURL:URLString params:parameters],
                          parameters,responseObject);
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                [self getDateWithTask:task];
                    NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n",
                          [self generateGETAbsoluteURL:URLString params:parameters],
                          parameters);
                    failure(error);
                }
            }];
            
            
            
        }
            break;
    }
    
    
    
    return session;
}

#pragma mark -- 上传图片 --
+ (NSURLSessionDataTask *)uploadWithURLString:(NSString *)URLString
                                   parameters:(id)parameters
                                     progress:(RequestProgress)progress
                                  uploadParam:(NSString *)uploadParam
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure {
    //给每个接口添加t跟m字段
    NSMutableDictionary *tmpDic = [Tools QXBAddDictionary:parameters];
    AFHTTPSessionManager *manager = [self QXBSharedHTTPSessionManager];
    NSURLSessionDataTask *session = [manager POST:URLString parameters:tmpDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSURL *filepath = [NSURL fileURLWithPath:uploadParam];
        [formData appendPartWithFileURL:filepath name:@"file" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress){
        if(progress){
            progress(uploadProgress);
        }
        
    }
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              if (success) {
                                                  [self verifyToekn:responseObject];
                                                 [self getDateWithTask:task]; success(responseObject);
                                              }
                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                              if (failure) {
                                                  [self getDateWithTask:task];
                                                  failure(error);
                                              }
                                          }];
    
    return session;
}


#pragma mark -- 上传图片 --
+ (NSURLSessionDataTask *)uploadWithURLString:(NSString *)URLString
                                   parameters:(id)parameters
                                     progress:(RequestProgress)progress
                                  image:(UIImage *)image
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure {
    //给每个接口添加t跟m字段
    NSMutableDictionary *tmpDic = [self addDictionary:parameters];
    AFHTTPSessionManager *manager = [self sharedHTTPSessionManager:NO];
    NSURLSessionDataTask *session = [manager POST:URLString parameters:tmpDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData*imageData =UIImageJPEGRepresentation(image,1);
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
          name:@"file" fileName:fileName mimeType:@"image/jpeg"];
       
    } progress:^(NSProgress * _Nonnull uploadProgress){
        if(progress){
            progress(uploadProgress);
        }
        
    }
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              if (success) {
                                                  [self verifyToekn:responseObject];
                                                  [self getDateWithTask:task]; success(responseObject);
                                                  NSLog(@"\nPOST请求：Request success, URL: %@\n params:%@\n 返回内容：%@",
                                                        [self generateGETAbsoluteURL:URLString params:parameters],
                                                        parameters,responseObject);
                                              }
                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                              if (failure) {
                                                  [self getDateWithTask:task];
                                                  failure(error);
                                              }
                                          }];
    
    return session;
}

+ (NSURLSessionDataTask *)uploadWithURLString:(NSString *)URLString
                                   parameters:(id)parameters
                                     progress:(RequestProgress)progress
                                    imagePath:(NSString *)imagePath
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure {
    //给每个接口添加t跟m字段
    //给每个接口添加t跟m字段
    NSMutableDictionary *tmpDic = [self addDictionary:parameters];
    AFHTTPSessionManager *manager = [self sharedHTTPSessionManager:NO];
    NSURLSessionDataTask *session = [manager POST:URLString parameters:tmpDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSURL *filepath = [NSURL fileURLWithPath:imagePath];
        [formData appendPartWithFileURL:filepath name:@"file" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress){
        if(progress){
            progress(uploadProgress);
        }
        
    }
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              if (success) {
                                                  [self getDateWithTask:task]; success(responseObject);
                                              }
                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                              if (failure) {
                                                  [self getDateWithTask:task];
                                                  failure(error);
                                              }
                                          }];
    
    return session;
}


//加密
+ (NSMutableDictionary*)addDictionary:(NSMutableDictionary*)dic
{
    NSDate *cdate = [Tools getCurrentTime];
    CGFloat Offset = [[KUserDefaults objectForKey:KCurrentTimeToServerOffset] floatValue];
    cdate = [NSDate dateWithTimeInterval:-Offset sinceDate:cdate];
    
    int t = (int)[Tools getCurrentTimeStamp:cdate];
    
    NSMutableDictionary *changeDic = [NSMutableDictionary dictionaryWithDictionary:dic];
   
    [changeDic setObject:[NSString stringWithFormat:@"%d",t] forKey:@"t"];
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:changeDic options:NSJSONWritingPrettyPrinted error:&parseError];
    
   NSString *jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSMutableDictionary *returnDic = [NSMutableDictionary dictionary];
    
     [returnDic setObject:[NSString stringWithFormat:@"%@",jsonStr] forKey:@"data"];
    
    [returnDic setObject:[JAddField encryptWithJsonString:jsonStr] forKey:@"m"];
    
    return returnDic;
    
}

+(void)getDateWithTask:(NSURLSessionDataTask*)task
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
    NSString *serverDate =response.allHeaderFields[@"Date"];
    NSDate *serverTime = [JAddField convertHeaderDateToNSDate:serverDate];
    NSDate *currentTime = [NSDate date];
    CGFloat timeoffset = currentTime.timeIntervalSince1970 -serverTime.timeIntervalSince1970;
    [KUserDefaults setValue:[NSString stringWithFormat:@"%f",timeoffset] forKey:KCurrentTimeToServerOffset];
}


+(void)verifyToekn:(id)responseObject
{
    if([[responseObject objectForKey:@"result"] intValue] == 2019)
    {
        [KNotificationCenter postNotificationName:KTokenInvalid object:nil];
    }
}


// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(id)params {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}



@end


@implementation FileModel



@end
