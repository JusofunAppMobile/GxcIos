//
//  GetPhoto.m
//  RecruitOnline
//
//  Created by WangZhipeng on 17/6/20.
//  Copyright © 2017年 JUSFOUN. All rights reserved.
//

#import "GetPhoto.h"

@implementation GetPhoto
{
    NSString*tempImgPath;
    
    UIViewController *viewController;
    
    GetPhotoBlock getBolck;
    
}

SingletonM(GetPhoto);


-(void)getPhotoWithTarget:(id)target success:(GetPhotoBlock)block
{
    viewController = target;
    UIActionSheet *choiceSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
    [choiceSheet showInView:KeyWindow];
    
    getBolck = block;
}

#pragma mark -- actionsheet代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 2) {
        
        
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//预置类型相册选取
        //判断是否支持摄像头
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
            }
        }else {
            switch (buttonIndex) {
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 0:
                    return;
            }
        }
        //创建UIImagePickerController
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = sourceType;//设置类型
        [viewController presentViewController:imagePicker animated:YES completion:nil];//弹出模态
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    //[imageView jm_setCornerRadius:30 withImage:image];
    if (image!=nil)
    {
        NSData *data;
        data = UIImageJPEGRepresentation(image, 0.5);
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [path objectAtIndex:0];
        NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYYMMddHHMMSS"];
        NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];
        
        //保存图片的路径
        tempImgPath = [imageDocPath stringByAppendingPathComponent:currentDay];
        tempImgPath = [NSString stringWithFormat:@"%@.png",tempImgPath];
        [[NSFileManager defaultManager] createFileAtPath:tempImgPath contents:data attributes:nil];
        
        
        getBolck(image,tempImgPath);
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (UIImage *)CompressedImageSize:(CGSize)imageSize HeadImage:(UIImage *)image{
    
    
    CGSize headSize;
    if (imageSize.width >= imageSize.height) {
        
        if (imageSize.width > 1000.0) {
            
            headSize = CGSizeMake(1000.0, imageSize.width/1000.0* imageSize.height);
        }else if (imageSize.width < 150.0){
            
            headSize = CGSizeMake(150/imageSize.height * imageSize.width, 150);
        }else{
            
            headSize = imageSize;
        }
    }else{
        
        if (imageSize.height > 1000.0) {
            
            headSize = CGSizeMake(imageSize.height/1000.0*imageSize.width,1000.0);
        }else if (imageSize.height < 150.0){
            
            headSize = CGSizeMake(150,150/imageSize.width * imageSize.height );
        }else{
            
            headSize = imageSize;
        }
    }
    
    UIImage *headImage = [self imageCompressForSize:image targetSize:headSize];
    return headImage;
}

//压缩图片
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


@end
