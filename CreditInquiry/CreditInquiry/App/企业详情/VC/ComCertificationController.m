//
//  ComCertificationController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ComCertificationController.h"

@interface ComCertificationController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *backTableView;
   
    NSMutableArray *dataArray;
 
    NSInteger chooseIndex;
    
}
@end

@implementation ComCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"企业认证"];
    [self setBlankBackButton];
    [self drawTableView];
}


-(void)certification
{
    
}

-(void)addImage:(NSInteger)indexPath
{
    chooseIndex = indexPath;
    if(indexPath == 5)//营业执照
    {
        
    }
    else//企业名称
    {
        
    }
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照", @"从相册中选择", nil];
    sheet.tag = 1001;
    [sheet showInView:self.view];
    
}

-(void)loadData
{
    
    KWeakSelf;
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    // [paraDic setObject:self.companyId forKey:@"companyid"];
    //[paraDic setObject:self.companyName forKey:@"companyname"];
    
    [RequestManager QXBGetWithURLString:KGetGuQuan parameters:paraDic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showNetFailViewWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight)];
    }];
    
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
        imagePicker.navigationBar.translucent=NO;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = sourceType;//设置类型
        [self presentViewController:imagePicker animated:YES completion:nil];//弹出模态
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:chooseIndex  inSection:0];
    CertificationCell *cell = [backTableView cellForRowAtIndexPath:indexPath];
    [cell.addBtn setImage:image forState:UIControlStateNormal];

    //_headerImg.image = image;
    UIImage *headImage = [image jm_imageWithRoundedCornersAndSize:CGSizeMake(82, 82) andCornerRadius:41];
   // _heandImageView.image = headImage;
    if (image!=nil)
    {
        NSData *data;
        data = UIImageJPEGRepresentation(image, 0.5);
        
       // data = UIImageJPEGRepresentation([self CompressedImageSize:image.size HeadImage:image], 0.5);
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [path objectAtIndex:0];
        NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYYMMddHHMMSS"];
        NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];
        
//        //保存图片的路径
//        _tempImgPath = [imageDocPath stringByAppendingPathComponent:currentDay];
//        _tempImgPath = [NSString stringWithFormat:@"%@.png",_tempImgPath];
//        [[NSFileManager defaultManager] createFileAtPath:_tempImgPath contents:data attributes:nil];
//
//        [self uploadHeaderImg];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    CertificationCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        if(indexPath.row == 5||indexPath.row == 6)
        {
            cell = [[CertificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir type:1];
            cell.delegate = self;
        }
        else
        {
            cell = [[CertificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir type:0];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.index = indexPath.row;
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(0, 0, KDeviceW, 45)];
    label.backgroundColor = KRGB(252, 244, 244);
    label.textColor = KRGB(238, 37, 32);
    label.font = KFont(14);
    label.text = @"     填写身份证信息，快速认证企业";
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(void)drawTableView
{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:KRGB(238, 37, 32)];
    [button setTitle:@"提交认证" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(KDeviceW-30);
        make.left.mas_equalTo(15);
        
    }];
    [button addTarget:self action:@selector(certification) forControlEvents:UIControlEventTouchUpInside];
    
    

    backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    backTableView.delegate = self;
    backTableView.dataSource = self;
    backTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    backTableView.estimatedRowHeight = 50;
    backTableView.rowHeight  = UITableViewAutomaticDimension;
    backTableView.estimatedSectionHeaderHeight = 0;
    backTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:backTableView];
    [backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(KDeviceW);
        make.bottom.mas_equalTo(button.mas_top).offset(-10);
    }];
    
   
    
    
    
}
@end
