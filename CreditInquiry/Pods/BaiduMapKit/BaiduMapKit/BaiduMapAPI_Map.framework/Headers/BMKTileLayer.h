//
//  BMKTileLayer.h
//  MapComponent
//
//  Created by wzy on 15/8/7.
//  Copyright © 2015年 baidu. All rights reserved.
//

#ifndef BMKTileLayer_h
#define BMKTileLayer_h
#import "BMKOverlay.h"

/**
 @brief 该类是覆盖在球面墨卡托投影上的图片tiles的数据源，是抽象类，不能直接使用该类添加瓦片图，需要使用其子类（BMKURLTileLayer或BMKSyncTileLayer）
 *瓦片图片是jpeg或者png格式，size为256x256
 */
@interface BMKTileLayer : NSObject <BMKOverlay>

/// tileLayer的可见最小Zoom值，默认3
@property (nonatomic, assign) NSInteger minZoom;

/// tileLayer的可见最大Zoom值，默认21，且不能小于minZoom
@property (nonatomic, assign) NSInteger maxZoom;

/// tileOverlay的可渲染区域，默认世界范围
@property (nonatomic) BMKMapRect visibleMapRect;

@end

/**
 @brief 通过提供url模板的方法，提供数据源。不应该继承该类，且必须通过 initWithURLTemplate: 来初始化
 *瓦片图片是jpeg或者png格式，size为256x256
 */
@interface BMKURLTileLayer : BMKTileLayer

/// 同initWithURLTemplate:中的URLTemplate
@property (readonly) NSString *URLTemplate;


- (id)initWithURLTemplate:(NSString *)URLTemplate;

/**
 @brief 清除当前瓦片图层缓存图片
 */
- (BOOL)cleanTileDataCache;

@end

/**
 @brief 通过同步方法获取瓦片数据，是一个抽象类，需要通过继承该类，并重载 tileForX:y:zoom: 方法
 *瓦片图片是jpeg或者png格式，size为256x256
 */
@interface BMKSyncTileLayer : BMKTileLayer


- (UIImage *)tileForX:(NSInteger)x y:(NSInteger)y zoom:(NSInteger)zoom;

@end

/**
 @brief 通过异步方法获取瓦片数据，是一个抽象类，需要通过继承该类，并重载 loadTileForX:y:zoom:result: 方法
 *瓦片图片是jpeg或者png格式，size为256x256
 */
@interface BMKAsyncTileLayer : BMKTileLayer


- (void)loadTileForX:(NSInteger)x y:(NSInteger)y zoom:(NSInteger)zoom result:(void (^)(UIImage *tileImage, NSError *error))result;

@end

#endif /* BMKTileLayer_h */
