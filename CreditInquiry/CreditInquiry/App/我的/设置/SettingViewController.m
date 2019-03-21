//
//  SettingViewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "SettingFooterView.h"
#import "MsgSettingController.h"
#import "NewCommonWebController.h"
static NSString *CellID = @"SettingCell";

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,SettingFooterViewDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) SettingFooterView *footer;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"设置"];
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
        if (KUSER.userId.length) {
            view.tableFooterView = self.footer;
        }
        view;
    });
    [_tableview registerClass:[SettingCell class] forCellReuseIdentifier:CellID];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?2:3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MsgSettingController *vc = [MsgSettingController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self clearCache];
        }
    }else{
        NSString *title = nil;
        NSString *addr = nil;
        if (indexPath.row == 0) {
            title = @"服务协议";
            addr = KUserProtocol;
        }else if (indexPath.row == 1){
            title = @"隐私政策";
            addr = KPrivacy;
        } else {
            title = @"关于我们";
            addr = KAboutUS;
        }
        NSString *url = [NSString stringWithFormat:@"%@?VersionCode=%@&AppType=1",addr,[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];

        
        NewCommonWebController *vc = [NewCommonWebController new];
        vc.urlStr = url;
        vc.titleStr = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//清除缓存
- (void)clearCache{//test
    KWeakSelf
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSFileManager defaultManager]removeItemAtPath:[weakSelf getPhotoCachePath] error:nil];
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [MBProgressHUD showSuccess:@"清除完成" toView:weakSelf.view];
        }];
    });
}

//相册选取路径
- (NSString *)getPhotoCachePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
    return imageDocPath;
}

#pragma mark - 退出登录
- (void)didClickLoginout{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KLoginoutMethod parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            KUSER.userId = @"";
            KUSER.token = nil;
            [User clearTable];
            [KNotificationCenter postNotificationName:KLoginOutNoti object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            [MBProgressHUD showSuccess:@"退出成功！" toView:self.view];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

#pragma mark - lazy load
- (SettingFooterView *)footer{
    if (!_footer) {
        _footer = [[SettingFooterView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 70)];
        _footer.delegate = self;
    }
    return _footer;
}


@end
