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
            NSLog(@"图片___%@",imagePath);
            [weakSelf uploadHeadImage:imagePath];
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

- (void)uploadHeadImage:(NSString *)imagePath{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@"type"];
    [params setObject:@"" forKey:@""];
    
    [RequestManager uploadWithURLString:KUploadImage parameters:params progress:nil uploadParam:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
//    [RequestManager postWithURLString:KUploadImage parameters:nil success:^(id responseObject) {
//
//    } failure:^(NSError *error) {
//
//    }];
}


@end
