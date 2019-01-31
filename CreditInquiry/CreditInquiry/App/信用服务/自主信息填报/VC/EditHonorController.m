//
//  EditHonorController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "EditHonorController.h"
#import "CreditEditLabelCell.h"
#import "CreditEditTextCell.h"
#import "CreditEditImageCell.h"
#import "GetPhoto.h"

static NSString *LabelCellID = @"CreditEditLabelCell";
static NSString *ImageCellID = @"CreditEditImageCell";
static NSString *TextCellID = @"CreditEditTextCell";

@interface EditHonorController ()<UITableViewDataSource,UITableViewDelegate,CreditEditImageCellDelegate>
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,assign) BOOL canEdit;
@property (nonatomic ,strong) NSMutableDictionary *dataDic;


@end

@implementation EditHonorController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"企业荣誉"];
    [self setBlankBackButton];
    [self setRightNaviButton];
    
    [self initView];
    [self loadData];
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];;
        [self.view addSubview:view];
        view.delegate = self;
        view.dataSource = self;
        view.rowHeight = UITableViewAutomaticDimension;
        view.estimatedRowHeight = 50;
        view;
    });
    [_tableview registerClass:[CreditEditLabelCell class] forCellReuseIdentifier:LabelCellID];
    [_tableview registerClass:[CreditEditImageCell class] forCellReuseIdentifier:ImageCellID];
    [_tableview registerClass:[CreditEditTextCell class] forCellReuseIdentifier:TextCellID];
}

- (void)setRightNaviButton{
    _rightBtn = [[UIButton alloc]initWithFrame:KFrame(0, 0, 35, 40)];
    _rightBtn.titleLabel.font = KFont(15);
    [_rightBtn setTitle:@"编辑" forState: UIControlStateNormal];
    [_rightBtn setTitle:@"完成" forState: UIControlStateSelected];
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [barView addSubview:_rightBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - loadData
- (void)loadData{
    if (!_honorId.length) {
        return;
    }
    [self showLoadDataAnimation];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_honorId forKey:@"honorId"];

    [RequestManager postWithURLString:KGetCompanyHonor parameters:params success:^(id responseObject) {
        [self hideLoadDataAnimation];
        if ([responseObject[@"result"] intValue] == 0) {
            [self.dataDic setDictionary:responseObject[@"data"]];
            [_tableview reloadData];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:_tableview.frame];
    }];
}

- (void)uploadHeadImage:(UIImage *)image{
    [MBProgressHUD showMessag:@"" toView:self.view];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"honor" forKey:@"type"];
    
    [RequestManager uploadWithURLString:KUploadImage parameters:params progress:nil image:image success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            NSString *filepath = responseObject[@"data"][@"filepath"];
            NSString *imageURL = responseObject[@"data"][@"filehttp"];
            [self.dataDic setObject:filepath forKey:@"urlComplete"];
            [self.dataDic setObject:imageURL forKey:@"image"];
            [_tableview reloadData];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

- (void)commitEditInfo{
    if (_honorId) {
        [self.dataDic setObject:_honorId forKey:@"honorId"];
    }
    if (!_dataDic[@"honor"]) {
        [MBProgressHUD showHint:@"请输入荣誉名称" toView:self.view];
        return;
    }
    
    if (!_dataDic[@"urlComplete"]) {
        [MBProgressHUD showHint:@"请上传荣誉图片" toView:self.view];
        return;
    }
    
    if (!_dataDic[@"introduce"]) {
        [MBProgressHUD showHint:@"请输入荣誉简介" toView:self.view];
        return;
    }
    
    [self.dataDic setObject:_dataDic[@"urlComplete"] forKey:@"image"];
    
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KEditCompanyHonor parameters:self.dataDic success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            _canEdit = _rightBtn.selected = NO;
            [self back];
            if (_reloadBlock) {
                _reloadBlock();
            }
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CreditEditLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:LabelCellID forIndexPath:indexPath];
            [cell setContent:self.dataDic row:indexPath.row editType:EditTypeHonor enable:_canEdit];
            return cell;
        }else{
            CreditEditImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCellID forIndexPath:indexPath];
            [cell setContent:self.dataDic type:EditTypeHonor];
            cell.delegate = self;
            return cell;
        }
    }else{
        CreditEditTextCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellID forIndexPath:indexPath];
        [cell setContent:self.dataDic type:EditTypeHonor editable:_canEdit];
        return cell;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


#pragma mark - 提交
- (void)rightAction{//对齐标签的bug
    [self.view endEditing:YES];
    if (_rightBtn.selected) {
        [self commitEditInfo];
    }else{
        _canEdit = _rightBtn.selected = YES;
        [_tableview reloadData];
    }
}
#pragma mark - CreditEditImageCellDelegate 添加图片
- (void)didClickAddImageView{
    [self.view endEditing:YES];
    [[GetPhoto sharedGetPhoto] getPhotoWithTarget:self success:^(UIImage *image, NSString *imagePath) {
        [self uploadHeadImage:image];
    }];
}

#pragma mark - 网络异常
- (void)abnormalViewReload{
    [self loadData];
}

#pragma mark - lazy load
- (NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
        [_dataDic setObject:KUSER.userId forKey:@"userId"];
    }
    return _dataDic;
}

@end
