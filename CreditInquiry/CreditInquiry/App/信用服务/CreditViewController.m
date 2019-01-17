//
//  CreditViewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/3.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditViewController.h"
#import "CreditCollectionCell.h"
#import "CreditSectionHeader.h"
#import "ULBCollectionViewFlowLayout.h"
#import "CreditChartLineCell.h"
#import "CreditInfoInputController.h"
#import "CreditReportController.h"
#import "ObjectionAppealController.h"
#import "CreditInfoCell.h"
#import "CreditPormiseController.h"
#import "CreditServiceModel.h"
#import "CreditVisitorModel.h"
#import "CreditHomeModel.h"

static NSString *InfoID = @"CreditInfoCell";
static NSString *CellID = @"CreditCollectionCell";
static NSString *HeaderID = @"CreditSectionHeader";
static NSString *ChartID = @"CreditChartLineCell";

@interface CreditViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ULBCollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) NSDictionary *companyInfo;
@property (nonatomic ,strong) UICollectionView *collectionview;
@property (nonatomic ,strong) CreditHomeModel *creditModel;
@end

@implementation CreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.companyInfo = @{@"companyName":@"阿里巴巴科技有限公司",@"code":@"91441400696419503L",@"type":@"非上市、自然人投资或控股",@"companyId":@"15",@"state":@"3",@"changeNum":@"5"};
    [self initView];
    [self loadData];
}

#pragma mark - loadData
- (void)loadData{
    [MBProgressHUD showMessag:@"" toView:self.view];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    
    [RequestManager postWithURLString:KGetCreditHomeInfo parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
        if ([responseObject[@"result"] intValue] == 0) {
//            _creditModel = [CreditHomeModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            _creditModel = [CreditHomeModel new];
            _creditModel.companyInfo = _companyInfo;
            
            //===========
            NSMutableArray *arr1 = [NSMutableArray array];
            NSArray *title1 = @[@"信用报告",@"信用评价",@"信用异议",@"信用修复",@"信用承诺",@"访客",@"自主填报"];
            for (int i = 0; i < 6; i++) {
                CreditServiceModel *model = [CreditServiceModel new];
                model.menuName = title1[i];
                [arr1 addObject:model];
            }
            _creditModel.serviceList = arr1;
            
            //===========
            NSMutableArray *arr2 = [NSMutableArray array];
            NSArray *title2 = @[@"税务案件",@"商标查询",@"著作权查询",@"黑名单",@"信用承诺",@"访客",@"自主填报"];
            
            for (int i = 0; i < 7; i++) {
                CreditServiceModel *model = [CreditServiceModel new];
                model.menuName = title2[i];
                [arr2 addObject:model];
            }
            _creditModel.inquiryList = arr2;
            
            //===========
            
             NSMutableArray *arr3 = [NSMutableArray array];
            NSArray *title3 = @[@"100",@"64",@"75",@"150",@"78",@"70"];
            for (int i = 0; i < 6; i++) {
                CreditVisitorModel *model = [CreditVisitorModel new];
                model.date = [NSString stringWithFormat:@"%d月",i+1];
                model.count = title3[i];
                [arr3 addObject:model];
            }
            _creditModel.VisitorList = arr3;
            
            [_collectionview reloadData];
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:self.view animated:YES];
    }];
}

#pragma mark - initView
- (void)initView{
    
    self.view.backgroundColor = KHexRGB(0xedeef3);
        
    ULBCollectionViewFlowLayout *layout = [ULBCollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionview = ({
        UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(
            KNavigationBarHeight);
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-KTabBarHeight);
        }];
        view.backgroundColor = [UIColor clearColor];
        view.delegate = self;
        view.dataSource = self;
        view;
    });
    [_collectionview registerClass:[CreditInfoCell class] forCellWithReuseIdentifier:InfoID];
    [_collectionview registerClass:[CreditCollectionCell class] forCellWithReuseIdentifier:CellID];
    [_collectionview registerClass:[CreditChartLineCell class] forCellWithReuseIdentifier:ChartID];
    [_collectionview registerClass:[CreditSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_creditModel.companyInfo[@"state"] intValue] == 3 ?4:2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0||section == 3) {
        return 1;
    }else if (section == 1){
        int state = [_creditModel.companyInfo[@"state"] intValue];
        return state == 3? _creditModel.serviceList.count:_creditModel.inquiryList.count;
    }else{
        return _creditModel.inquiryList.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0) {
            CreditInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:InfoID forIndexPath:indexPath];
            cell.companyInfo = _creditModel.companyInfo;
            return cell;
        }if (indexPath.section ==3) {
            CreditChartLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ChartID forIndexPath:indexPath];
            cell.dataList = _creditModel.VisitorList;
            return cell;
        }else{
            CreditCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
            if ([_creditModel.companyInfo[@"state"] intValue] == 3) {//section 1,2
                cell.model = indexPath.section == 1 ?_creditModel.serviceList[indexPath.item]:_creditModel.inquiryList[indexPath.item];
            }else{//section 1
                cell.model = _creditModel.inquiryList[indexPath.item];
            }
            return cell;
        }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        CreditSectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
        [header setupHeader:[_creditModel.companyInfo[@"state"] intValue] section:indexPath.section];
        return header;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat height ;
        int state = [_creditModel.companyInfo[@"state"] intValue];
        if (state == 1) {
            height = 125;
        }else if (state == 3){
            height = 187;
        }else{
            height = 15+(KDeviceW -15*2)*(221.f/688);
        }
        return CGSizeMake(KDeviceW, height);
    }else if (indexPath.section == 3) {
        return CGSizeMake(KDeviceW, 200);
    }else {
        CGFloat width = (KDeviceW-10*2)/4;
        return CGSizeMake(width, 77);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        int state = [_creditModel.companyInfo[@"state"] intValue];
        return CGSizeMake(KDeviceW, state == 3?60:50);
    }else{
        return CGSizeZero;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 3||section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 10, 20, 10);
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    return [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int state = [_creditModel.companyInfo[@"state"] intValue];//test
    if (indexPath.section == 1 && state==3) {
        if (indexPath.row == 0) {
            CreditReportController *vc = [CreditReportController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            CreditInfoInputController *vc = [CreditInfoInputController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            ObjectionAppealController *vc = [ObjectionAppealController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row ==3){
            CreditPormiseController *vc = [CreditPormiseController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
 
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar fs_setBackgroundColor:KHexRGB(0xd51424)];
    [self setNavigationBarTitle:@"信用服务" andTextColor:[UIColor whiteColor]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar fs_clearBackgroudCustomColor];
}

@end
