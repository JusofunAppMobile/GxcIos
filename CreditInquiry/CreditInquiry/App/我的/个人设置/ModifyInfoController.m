//
//  ModifyInfoController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ModifyInfoController.h"
#import "ModifyInfoCell.h"

static NSString *CellID = @"ModifyInfoCell";

@interface ModifyInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) UITextField *textField;
@end

@implementation ModifyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlankBackButton];
    [self setRightNaviButton];
    
    [self initView];
}
#pragma mark - unit
- (void)setTypeStr:(NSString *)typeStr{
    _typeStr = typeStr;
    [self setNavigationBarTitle:[NSString stringWithFormat:@"修改%@",typeStr]];
    [_tableview reloadData];
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:view];
        view.delegate =self;
        view.dataSource = self;
        view.rowHeight = 55;
        view;
    });
    [_tableview registerClass:[ModifyInfoCell class] forCellReuseIdentifier:CellID];
}

- (void)setRightNaviButton{
    UIButton *button = [[UIButton alloc]initWithFrame:KFrame(0, 0, 35, 40)];
    button.titleLabel.font = KFont(15);
    [button setTitle:@"保存" forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [barView addSubview:button];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModifyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.typeStr = _typeStr;
    self.textField = cell.textfield;
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark -
- (void)rightAction{
    [self.view endEditing:YES];
    if (!_textField.text.length) {
        [MBProgressHUD showHint:[NSString stringWithFormat:@"请输入%@",_typeStr] toView:self.view];
        return;
    }
    [MBProgressHUD showMessag:@"" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    if ([_typeStr isEqualToString:@"邮箱"]) {
        [params setObject:_textField.text forKey:@"email"];
    }else if ([_typeStr isEqualToString:@"公司"]){
        [params setObject:_textField.text forKey:@"company"];
    }else if ([_typeStr isEqualToString:@"部门"]){
        [params setObject:_textField.text forKey:@"department"];
    }else if ([_typeStr isEqualToString:@"职务"]){
        [params setObject:_textField.text forKey:@"job"];
    }else{
        [params setObject:_textField.text forKey:@"trade"];
    }
    
    [RequestManager postWithURLString:KChangeUserInfo parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view];
            [self updateUserInfo];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"哎呀，服务器开小差啦，请您稍等，马上回来~" toView:self.view];
    }];
    
}

- (void)updateUserInfo{
    
    if ([_typeStr isEqualToString:@"邮箱"]) {
        KUSER.email = _textField.text;
    }else if ([_typeStr isEqualToString:@"公司"]){
        KUSER.company = _textField.text;
    }else if ([_typeStr isEqualToString:@"部门"]){
        KUSER.department = _textField.text;
    }else if ([_typeStr isEqualToString:@"职务"]){
        KUSER.job = _textField.text;
    }else{
        KUSER.trade = _textField.text;
    }
    [KUSER update];
    if (_reloadBlock) {
        _reloadBlock();
    }
    [self back];    
}

@end
