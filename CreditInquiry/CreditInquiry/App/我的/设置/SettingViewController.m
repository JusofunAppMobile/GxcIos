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
static NSString *CellID = @"SettingCell";

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
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
        view.tableFooterView = self.footer;
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

#pragma mark - lazy load
- (SettingFooterView *)footer{
    if (!_footer) {
        _footer = [[SettingFooterView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 70)];
    }
    return _footer;
}


@end
