//
//  PersonalSettingController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "PersonalSettingController.h"
#import "SettingPlainCell.h"
#import "SettingAvatarCell.h"
#import "ModifyPhoneController.h"
#import "ModifyInfoController.h"
#import "GetPhoto.h"
#import "ChangePwdController.h"
#import "UIImage+Wechat.h"

static NSString *CellID1 = @"SettingAvatarCell";
static NSString *CellID2 = @"SettingPlainCell";

@interface PersonalSettingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;
@end

@implementation PersonalSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"个人设置"];
    [self setBlankBackButton];

    [self initView];
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];;
        [self.view addSubview:view];
        view.delegate = self;
        view.dataSource = self;
        view.rowHeight = UITableViewAutomaticDimension;
        view.estimatedRowHeight = 52;
        view;
    });
    [_tableview registerClass:[SettingAvatarCell class] forCellReuseIdentifier:CellID1];
    [_tableview registerClass:[SettingPlainCell class] forCellReuseIdentifier:CellID2];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&indexPath.row == 0) {
        SettingAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID1 forIndexPath:indexPath];
        [cell reloadHead];
        return cell;
    }else{
        SettingPlainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID2 forIndexPath:indexPath];
        cell.indexPath = indexPath;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0&&indexPath.row ==0) {
        KWeakSelf
        [[GetPhoto sharedGetPhoto] getPhotoWithTarget:self success:^(UIImage *image, NSString *imagePath) {
            UIImage *tempImage = [image wcSessionCompress];
            [weakSelf uploadHeadImage:tempImage];
        }];
        
    }else if (indexPath.section == 0&&indexPath.row == 1){
        KWeakSelf
        ModifyPhoneController *vc = [ModifyPhoneController new];
        vc.reloadBlock = ^{
            [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:vc animated:YES];
       
    }else if (indexPath.section == 0&&indexPath.row == 2){
        ChangePwdController *vc = [ChangePwdController new];
        [self.navigationController pushViewController:vc animated:YES];        
    }else{
        if ((indexPath.section==1&&indexPath.row == 0) && KUSER.company.length) {
            return;
        }
        
        KWeakSelf
        SettingPlainCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ModifyInfoController *vc = [ModifyInfoController new];
        vc.typeStr = cell.title;
        vc.reloadBlock = ^{
            [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)uploadHeadImage:(UIImage *)image{
    
    [MBProgressHUD showMessag:@"" toView:self.view];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"Icon" forKey:@"type"];
    
    [RequestManager uploadWithURLString:KUploadImage parameters:params progress:nil image:image success:^(id responseObject) {
        if ([responseObject[@"result"] intValue] == 0) {
            NSString *tempURL = responseObject[@"data"][@"filepath"];
            [self commitImageURLToService:tempURL];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)commitImageURLToService:(NSString *)tempURL{
    if (!tempURL) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:tempURL forKey:@"headIcon"];
    
    [RequestManager postWithURLString:KChangeUserInfo parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
            [self updateUserInfo:responseObject[@"data"][@"headUrl"]];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"哎呀，服务器开小差啦，请您稍等，马上回来~" toView:self.view];
    }];
}

- (void)updateUserInfo:(NSString *)tempURL{
    KUSER.headIcon = tempURL;
    [KUSER update];
    [_tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [KNotificationCenter postNotificationName:KModifyUserInfoSuccessNoti object:nil];
}


@end
