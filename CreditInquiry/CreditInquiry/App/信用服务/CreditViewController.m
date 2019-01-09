//
//  CreditViewController.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/3.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditViewController.h"
#import "CreditServiceHeader.h"
#import "CreditCollectionCell.h"
#import "CreditSectionHeader.h"
#import "ULBCollectionViewFlowLayout.h"
#import "CreditChartLineCell.h"
#import "CreditInfoInputController.h"
#import "CreditReportController.h"

static NSString *CellID = @"CreditCollectionCell";
static NSString *HeaderID = @"CreditSectionHeader";
static NSString *ChartID = @"CreditChartLineCell";

@interface CreditViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ULBCollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) NSDictionary *companyInfo;
@property (nonatomic ,strong) UICollectionView *collectionview;
@end

@implementation CreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"信用服务" andTextColor:[UIColor whiteColor]];
    self.companyInfo = @{@"companyName":@"阿里巴巴科技有限公司",@"code":@"91441400696419503L",@"type":@"非上市、自然人投资或控股",@"companyId":@"15",@"state":@"1",@"changeNum":@"5"};
    [self initView];
}

#pragma mark - initView
- (void)initView{
    
    self.view.backgroundColor = KHexRGB(0xedeef3);
    
    CreditServiceHeader *creditHeader = [[CreditServiceHeader alloc]initWithFrame:KFrame(0, KNavigationBarHeight, KDeviceW, 115+5+10)];
    creditHeader.companyInfo = _companyInfo;
    [self.view addSubview:creditHeader];
    
    
    ULBCollectionViewFlowLayout *layout = [ULBCollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0.2;
    layout.minimumLineSpacing = 0;
    
    self.collectionview = ({
        UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(creditHeader.mas_bottom);
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-KTabBarHeight);
        }];
        view.backgroundColor = [UIColor clearColor];
        view.delegate = self;
        view.dataSource = self;
        view;
    });
    [_collectionview registerClass:[CreditCollectionCell class] forCellWithReuseIdentifier:CellID];
    [_collectionview registerClass:[CreditChartLineCell class] forCellWithReuseIdentifier:ChartID];
    [_collectionview registerClass:[CreditSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_companyInfo[@"state"] intValue] ==1 ?3:1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 2) {
        return 1;
    }
    return 12;//test
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==2) {
        CreditChartLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ChartID forIndexPath:indexPath];
        return cell;
    }else{
        CreditCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];//test设置内容
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CreditSectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
    [header setupHeader:[_companyInfo[@"state"] intValue] section:indexPath.section];//test
    return header;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return CGSizeMake(KDeviceW, 210);
    }else{
        CGFloat width = (KDeviceW-10*2-0.2*3)/4;
        return CGSizeMake(width, 75);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    int state = [_companyInfo[@"state"] intValue];//test
    return CGSizeMake(KDeviceW, state == 1?60:50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 2) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 10, 20, 10);
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    return [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CreditReportController *vc = [CreditReportController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        CreditInfoInputController *vc = [CreditInfoInputController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
 
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //state 0未认证 1已认证 2审核中
    if ([_companyInfo[@"state"] intValue] == 0) {
        [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor whiteColor]];
        [self setNavigationBarTitle:@"信用服务" andTextColor:[UIColor blackColor]];
    }else{
        [self.navigationController.navigationBar fs_setBackgroundColor:KHexRGB(0xd51424)];
        [self setNavigationBarTitle:@"信用服务" andTextColor:[UIColor whiteColor]];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar fs_clearBackgroudCustomColor];
}

@end
