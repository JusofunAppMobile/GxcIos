//
//  ObjectionAppealController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ObjectionAppealController.h"
#import "ObjectionInfoCell.h"
#import "ObjectionEntCell.h"
#import "ObjectionTypeCell.h"
#import "ObjectionFooterView.h"
#import "ObjectionModel.h"
#import "ObjectionMenuModel.h"

static NSString *CellID1 = @"ObjectionEntCell";
static NSString *CellID2 = @"ObjectionTypeCell";
static NSString *CellID3 = @"ObjectionInfoCell";

@interface ObjectionAppealController ()<UITableViewDelegate,UITableViewDataSource,ObjectionTypeCellDelegate,ObjectionFooterViewDelegate,ObjectionInfoCellDelegate>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) ObjectionFooterView *footer;
@property (nonatomic ,strong) NSArray *objectionList;
@property (nonatomic ,strong) ObjectionModel *selectedTypeModel;

@property (nonatomic ,strong) NSMutableDictionary *selectedMenus;
@property (nonatomic ,strong) NSString *selectedIds;
@property (nonatomic ,strong) NSString *selectedNames;

@property (nonatomic ,strong) NSDictionary *userInfo;
@end

@implementation ObjectionAppealController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:_objectionType == ObjectionTypeError?@"异议纠错":@"异议申诉"];
    [self setBlankBackButton];
    
    [self initView];
    [self loadData];
}

#pragma mark - loadData
- (void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KGetObjectionInfo parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            self.objectionList = [ObjectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"objectionList"]];
            [_tableview reloadData];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

#pragma mark - initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, KDeviceH-KNavigationBarHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:view];
        view.delegate = self;
        view.dataSource = self;
        view.estimatedRowHeight = 90;
        view.rowHeight = UITableViewAutomaticDimension;
        view.tableFooterView = self.footer;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view;
    });
    [_tableview registerClass:[ObjectionEntCell class] forCellReuseIdentifier:CellID1];
    [_tableview registerClass:[ObjectionTypeCell class] forCellReuseIdentifier:CellID2];
    [_tableview registerClass:[ObjectionInfoCell class] forCellReuseIdentifier:CellID3];
}

#pragma mark - initView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
        ObjectionEntCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID1 forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 1){
        ObjectionTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID2 forIndexPath:indexPath];
        cell.typeList = _objectionList;
        cell.delegate = self;
        return cell;
    }else{
        ObjectionInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID3 forIndexPath:indexPath];
        [cell setModel:_selectedTypeModel type:ObjectionTypeCredit];
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - 提交异议
- (void)didClickCommitButton{
    if ([self isParamsEmpty]) {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_companyName forKey:@"CompanyName"];
    [params addEntriesFromDictionary:[self getMenuInfo]];
    [params addEntriesFromDictionary:self.userInfo];
    
    NSString *method = _objectionType == ObjectionTypeCredit?KCommitObjectionCredit:KCommitObjectionError;
    
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:method parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
            [MBProgressHUD showSuccess:@"异议信息已提交，感谢您的反馈意见！" toView:nil];
            [self back];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

- (NSDictionary *)getMenuInfo{
    
    NSMutableString *keyString = [NSMutableString string];
    NSMutableString *nameString = [NSMutableString string];
    [_selectedMenus enumerateKeysAndObjectsUsingBlock:^(NSString *key, ObjectionMenuModel *model, BOOL * _Nonnull stop) {
        [keyString appendFormat:@"%@,",model.menuid];
        [nameString appendFormat:@"%@,",model.menuName];
    }];
    [keyString deleteCharactersInRange:NSMakeRange(keyString.length-1, 1)];
    [nameString deleteCharactersInRange:NSMakeRange(nameString.length-1, 1)];
    
    NSMutableDictionary *menuInfo = [NSMutableDictionary dictionary];
    [menuInfo setObject:keyString forKey:@"menuid"];
    [menuInfo setObject:nameString forKey:@"menuName"];
    return menuInfo;
}

- (BOOL)isParamsEmpty{
    if (!self.selectedMenus.allValues.count) {
        [MBProgressHUD showHint:@"请选择异议类型！" toView:self.view];
        return YES;
    }
    
    if (_objectionType == ObjectionTypeError) {
        if (![(NSString *)_userInfo[@"name"] length]) {
            [MBProgressHUD showHint:@"请填写真实姓名！" toView:self.view];
            return YES;
        }
        
        if (![(NSString *)_userInfo[@"IDCard"] length]) {
            [MBProgressHUD showHint:@"请填写身份证号码！" toView:self.view];
            return YES;
        }
        
        if (![(NSString *)_userInfo[@"phone"] length]) {
            [MBProgressHUD showHint:@"请填写联系电话！" toView:self.view];
            return YES;
        }
        
        if (![(NSString *)_userInfo[@"Email"] length]) {
            [MBProgressHUD showHint:@"请填写电子邮箱！" toView:self.view];
            return YES;
        }
    }
    
    if (![(NSString *)_userInfo[@"errorMsg"] length]) {
        [MBProgressHUD showHint:@"请输入异议内容！" toView:self.view];
        return YES;
    }
    return NO;
}

#pragma mark - 异议类型
- (void)didSelectObjectionTypeMenu:(ObjectionModel *)model{
    _selectedTypeModel = model;
    [_tableview reloadSections:[[NSIndexSet alloc] initWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)infoCellDidClickMenu:(ObjectionMenuModel *)menuModel select:(BOOL)select{
    if (select) {
        [self.selectedMenus setObject:menuModel forKey:menuModel.menuid];
    }else{
        [self.selectedMenus removeObjectForKey:menuModel.menuid];
    }
}

- (void)infoCellDidEndEditing:(NSDictionary *)params{
    self.userInfo = params;
}

#pragma mark -lazy load
- (ObjectionFooterView *)footer{
    if (!_footer) {
        _footer = [[ObjectionFooterView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 120)];
        _footer.delegate = self;
    }
    return _footer;
}

- (NSMutableDictionary *)selectedMenus{
    if (!_selectedMenus) {
        _selectedMenus = [NSMutableDictionary dictionary];
    }
    return _selectedMenus;
}

@end
