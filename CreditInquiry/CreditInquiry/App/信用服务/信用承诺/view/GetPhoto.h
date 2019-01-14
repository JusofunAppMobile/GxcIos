//
//  GetPhoto.h
//  RecruitOnline
//
//  Created by WangZhipeng on 17/6/20.
//  Copyright © 2017年 JUSFOUN. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^GetPhotoBlock)(UIImage*image,NSString*imagePath);

@interface GetPhoto : NSObject<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

SingletonH(GetPhoto);


-(void)getPhotoWithTarget:(id)target success:(GetPhotoBlock)block;


@end
