//
//  ComCertificationController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ComCertificationController.h"

@interface ComCertificationController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UILabel *messageLabel;
    UITableView *backTableView;
   
    NSMutableArray *dataArray;
    UIButton *submitBtn;
 
    NSInteger chooseIndex;
    
    NSString *imagePath1;
    NSString *imagePath2;
    
    BRProvinceModel *provinceModel;
    BRCityModel *cityModel;
    
    
}

@property (nonatomic ,strong) NSArray *proviceArray;
@property (nonatomic ,strong) NSString *message;
@property (nonatomic ,strong) UIView *footerBg;

@end

@implementation ComCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"企业认证"];
    [self setBlankBackButton];
    [self drawTableView];
    
    if([KUSER.authStatus intValue] == 1||[KUSER.authStatus intValue] == 2||[KUSER.authStatus intValue] == 3)
    {
        [self loadData];
    }
    
}

-(void)loadData{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:KUSER.userId forKey:@"userId"];
  
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KGetCertification parameters:paraDic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            
            CertificationCell *cell1 = [self.view viewWithTag:KCertificationCellTag+0];
            CertificationCell *cell2 = [self.view viewWithTag:KCertificationCellTag+1];
            CertificationCell *cell3 = [self.view viewWithTag:KCertificationCellTag+2];
            CertificationCell *cell4 = [self.view viewWithTag:KCertificationCellTag+3];
            CertificationCell *cell5 = [self.view viewWithTag:KCertificationCellTag+4];
            CertificationCell *cell6 = [self.view viewWithTag:KCertificationCellTag+5];
            CertificationCell *cell7 = [self.view viewWithTag:KCertificationCellTag+6];
            CertificationCell *cell8 = [self.view viewWithTag:KCertificationCellTag+7];
            
            cell1.textFld.text = [dic objectForKey:@"companyname"];
            cell2.textFld.text = [dic objectForKey:@"idcard"];
            cell3.textFld.text = [dic objectForKey:@"name"];
            cell4.textFld.text = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"provinceName"],[dic objectForKey:@"cityName"]] ;
            cell5.textFld.text = [dic objectForKey:@"phone"];
            cell6.textFld.text = [dic objectForKey:@"email"];
            
            [cell7.addBtn sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"licenseImage"]] forState:UIControlStateNormal placeholderImage:KImageName(@"home_LoadingPic")];
            [cell8.addBtn sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"idcardImage"]] forState:UIControlStateNormal placeholderImage:KImageName(@"home_LoadingPic")];
            imagePath1 = responseObject[@"data"][@"licenseimgpath"];
            imagePath2 = responseObject[@"data"][@"idcardImgpath"];
            
            [self initProvinceData:responseObject[@"data"]];
            
            KUSER.authStatus = [[responseObject objectForKey:@"data"] objectForKey:@"status"];
            _message = responseObject[@"data"][@"promptxt"];
            NSLog(@"____%@",_message);
             [self setStatusLabel];
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
    }];
    
}

- (void)initProvinceData:(NSDictionary *)result{
    
    NSString *proName = result[@"provinceName"];
    NSString *cityName = result[@"cityName"];
    [self.proviceArray enumerateObjectsUsingBlock:^(NSDictionary *province, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([proName isEqualToString:province[@"name"]]) {
            provinceModel = [BRProvinceModel new];
            provinceModel.code = province[@"id"];
            provinceModel.name = proName;
            NSArray *cityList = province[@"children"];
            [cityList enumerateObjectsUsingBlock:^(NSDictionary * city, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([cityName isEqualToString:city[@"name"]]) {
                    cityModel = [BRCityModel new];
                    cityModel.code = city[@"id"];
                    cityModel.name = cityName;
                    *stop = YES;
                }
            }];
            *stop = YES;
        }
    }];
    
}


-(void)certification
{
    [self.view endEditing:YES];
    
    CertificationCell *cell1 = [self.view viewWithTag:KCertificationCellTag+0];
    CertificationCell *cell2 = [self.view viewWithTag:KCertificationCellTag+1];
    CertificationCell *cell3 = [self.view viewWithTag:KCertificationCellTag+2];
    CertificationCell *cell4 = [self.view viewWithTag:KCertificationCellTag+3];
    CertificationCell *cell5 = [self.view viewWithTag:KCertificationCellTag+4];
    CertificationCell *cell6 = [self.view viewWithTag:KCertificationCellTag+5];
    

    if (cell1.textFld.text.length == 0) {
        [MBProgressHUD showError:@"请输入企业名称" toView:self.view];
        return;
    }
    if (cell2.textFld.text.length == 0) {
        [MBProgressHUD showError:@"请输入身份证号码" toView:self.view];
        return;
    }
    if (![Tools verifyIDCardString:cell2.textFld.text]) {
        [MBProgressHUD showError:@"请输入正确身份证号码" toView:self.view];
        return;
    }
    if (cell3.textFld.text.length == 0) {
        [MBProgressHUD showError:@"请输入您的真实姓名" toView:self.view];
        return;
    }
    if (cell4.textFld.text.length == 0) {
        [MBProgressHUD showError:@"请输入您的职位" toView:self.view];
        return;
    }
    
    if (cell5.textFld.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:self.view];
        return;
    }
    if (![Tools validatePhoneNumber:cell5.textFld.text]) {
        [MBProgressHUD showError:@"请输入正确手机号" toView:self.view];
        return;
    }
    
    if (cell6.textFld.text.length == 0) {
        [MBProgressHUD showError:@"请输入邮箱地址" toView:self.view];
        return;
    }
    if (![Tools isEmailAddress:cell6.textFld.text]) {
        [MBProgressHUD showError:@"请输入正确邮箱地址" toView:self.view];
        return;
    }
    if (imagePath1.length == 0) {
        [MBProgressHUD showError:@"请上传营业执照" toView:self.view];
        return;
    }
    if (imagePath2.length == 0) {
        [MBProgressHUD showError:@"请上传身份证" toView:self.view];
        return;
    }
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:KUSER.userId forKey:@"userId"];
    [paraDic setObject:cell1.textFld.text forKey:@"companyname"];
    [paraDic setObject:cell2.textFld.text forKey:@"idcard"];
    [paraDic setObject:cell3.textFld.text forKey:@"name"];
    [paraDic setObject:provinceModel.code forKey:@"provinceId"];
    [paraDic setObject:cityModel.code forKey:@"cityId"];
    [paraDic setObject:cell5.textFld.text forKey:@"phone"];
    [paraDic setObject:cell6.textFld.text forKey:@"email"];
    [paraDic setObject:imagePath1 forKey:@"licenseImage"];
    [paraDic setObject:imagePath2 forKey:@"idcardImage"];
    [MBProgressHUD showMessag:@"" toView:self.view];
    
    [RequestManager postWithURLString:KCertification parameters:paraDic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            [MBProgressHUD showSuccess:@"提交信息成功，请等待审核" toView:nil];
            [KNotificationCenter postNotificationName:KCertificationNoti object:nil];
            [self back];
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
       [MBProgressHUD showError:@"请求失败" toView:self.view];
    }];
    
}




// type: certification:营业执照 idcard:本人身份证
-(void)upLoadImage:(UIImage*)image type:(NSString*)type
{
    UIImage *thumbImage = [image wcSessionCompress];
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
   
    [paraDic setObject:type forKey:@"type"];
   
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager uploadWithURLString:KFileUpload parameters:paraDic progress:^(NSProgress *progress) {
        
    } image:thumbImage success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if([[responseObject objectForKey:@"result"] intValue] == 0)
        {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            if([type isEqual: @"certification"])
            {
                imagePath1 = [dic objectForKey:@"filepath"];
            }else
            {
                imagePath2 = [dic objectForKey:@"filepath"];
            }
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:chooseIndex inSection:0];
            CertificationCell *cell = [backTableView cellForRowAtIndexPath:indexPath];
            [cell setButtonImage:image];
           // [MBProgressHUD showSuccess:@"上传成功" toView:self.view];
        }
        else
        {
            [MBProgressHUD showError:[responseObject objectForKey:@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"上传失败" toView:self.view];
    }];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeCity dataSource:self.proviceArray defaultSelected:nil isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        NSLog(@"%@%@",province.name,city.name);
        provinceModel = province;
        cityModel = city;
        
         CertificationCell *cell4 = [self.view viewWithTag:KCertificationCellTag+3];
        cell4.textFld.text = [NSString stringWithFormat:@"%@%@",province.name,city.name];
    } cancelBlock:^{
        
    }];
    
    
    return NO;
}



-(void)addImage:(NSInteger)indexPath
{
    chooseIndex = indexPath;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照", @"从相册中选择", nil];
    sheet.tag = 1001;
    [sheet showInView:self.view];
    
}

-(void)setStatusLabel
{
    if([KUSER.authStatus intValue] == 1)//1：审核中
    {
        messageLabel.text = @"     资料已提交、审核中";
        _footerBg.hidden = YES;
        [_footerBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    else if ([KUSER.authStatus intValue] == 2)//2：审核失败
    {
//        messageLabel.text = @"     认证状态已被驳回，请重新填写认证信息";
        messageLabel.text = [NSString stringWithFormat:@"%@%@",@"     ",_message];
        [_footerBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(65);
        }];
    }
    else if ([KUSER.authStatus intValue] == 3)//3：审核成功
    {
        messageLabel.text = @"     审核成功";
        _footerBg.hidden = YES;
        [_footerBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    else
    {
        messageLabel.text = @"     填写身份证信息，快速认证企业";
        [_footerBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(65);
        }];
    }
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

    if(chooseIndex == 6)//营业执照
    {
        [self upLoadImage:image type:@"certification"];
    }
    else//企业名称
    {
        [self upLoadImage:image type:@"idcard"];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = [NSString stringWithFormat:@"ideterfir%d",(int)indexPath.row];
    
    CertificationCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    //CertificationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(!cell)
    {
        if(indexPath.row == 7||indexPath.row == 6)
        {
            cell = [[CertificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir type:1];
            cell.delegate = self;
        }
        else
        {
            cell = [[CertificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideterfir type:0];
        }
        
        if(indexPath.row == 0)
        {
            cell.textFld.text = self.companyName;
        }
        if([KUSER.authStatus intValue] == 0||[KUSER.authStatus intValue] == 2)
        {
             cell.editEnable = YES;
        }
        else
        {
            cell.editEnable = NO;
        }
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.index = indexPath.row;
        
        cell.tag = KCertificationCellTag+indexPath.row;
       
        if(indexPath.row == 3&&cell.editEnable)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textFld.delegate = self;
        }
    }
   
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(0, 0, KDeviceW, 45)];
    label.backgroundColor = KRGB(252, 244, 244);
    label.textColor = KRGB(238, 37, 32);
    label.font = KFont(14);
    messageLabel = label;
    
    [self setStatusLabel];
    
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
    self.footerBg = ({
        UIView *view = [UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(65);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    submitBtn = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:KRGB(238, 37, 32)];
        [button setTitle:@"提交认证" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(certification) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 5;
        button.clipsToBounds = YES;
        [_footerBg addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.centerY.mas_equalTo(_footerBg);
            make.width.mas_equalTo(KDeviceW-30);
            make.left.mas_equalTo(_footerBg).offset(15);
        }];
        button;
    });
   
    
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
        make.bottom.mas_equalTo(_footerBg.mas_top);
    }];
    
   

    
    
}

#pragma mark - lazy load
- (NSArray *)proviceArray{
    if (!_proviceArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"provice_city_area" ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // 对数据进行JSON格式化并返回字典形式
        _proviceArray =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    return _proviceArray;
}
@end
