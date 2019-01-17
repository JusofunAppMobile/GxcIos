//
//  EditMemberController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "EditMemberController.h"
#import "CreditEditLabelCell.h"
#import "CreditEditTextCell.h"
#import "CreditEditImageCell.h"
#import "GetPhoto.h"

static NSString *LabelCellID = @"CreditEditLabelCell";
static NSString *ImageCellID = @"CreditEditImageCell";
static NSString *TextCellID = @"CreditEditTextCell";

@interface EditMemberController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,assign) BOOL canEdit;
@property (nonatomic ,strong) NSMutableDictionary *dataDic;

@end

@implementation EditMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"企业成员"];
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
    [MBProgressHUD showMessag:@"" toView:self.view];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    
    [RequestManager postWithURLString:KGetCompanyMember parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [self.dataDic setDictionary:responseObject[@"data"]];
            [_tableview reloadData];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)uploadHeadImage:(UIImage *)image{
    [MBProgressHUD showMessag:@"" toView:self.view];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"member" forKey:@"type"];
    
    [RequestManager uploadWithURLString:KUploadImage parameters:params progress:nil image:image success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            NSString *filepath = responseObject[@"data"][@"filepath"];
            NSString *imageURL = responseObject[@"data"][@"filehttp"];
            [self.dataDic setObject:filepath forKey:@"image"];
            [self.dataDic setObject:imageURL forKey:@"imageHttp"];
            [_tableview reloadData];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

- (void)commitEditInfo{
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KEditCompanyInfo parameters:self.dataDic success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            _canEdit = _rightBtn.selected = NO;
            [_tableview reloadData];
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
        return 3;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            CreditEditImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCellID forIndexPath:indexPath];
            [cell setContent:self.dataDic type:EditTypeMember];
            return cell;
        }else{
            CreditEditLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:LabelCellID forIndexPath:indexPath];
            [cell setContent:self.dataDic row:indexPath.row editType:EditTypeMember enable:_canEdit];
            return cell;
        }
    }else{
        CreditEditTextCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellID forIndexPath:indexPath];
        [cell setContent:self.dataDic type:EditTypeMember editable:_canEdit];
        return cell;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)rightAction{//对齐标签的bug
    [self.view endEditing:YES];
    if (_rightBtn.selected) {
        NSLog(@"b内容___%@",self.dataDic);
        [self commitEditInfo];
    }else{
        _canEdit = _rightBtn.selected = YES;
        [_tableview reloadData];
    }
}
#pragma mark - CreditEditImageCellDelegate 添加图片
- (void)didClickAddImageView{
    [[GetPhoto sharedGetPhoto] getPhotoWithTarget:self success:^(UIImage *image, NSString *imagePath) {
        [self uploadHeadImage:image];
    }];
}

#pragma mark - lazy load
- (NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
        [_dataDic setObject:_companyName forKey:@"companyName"];
        [_dataDic setObject:KUSER.userId forKey:@"userId"];
    }
    return _dataDic;
}

@end
