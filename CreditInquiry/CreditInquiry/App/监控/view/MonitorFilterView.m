//
//  MonitorFilterView.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/5.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorFilterView.h"
#import "UIView+BorderLine.h"
#import "MonitorFilterCell.h"
#import "MonitorFilterHeader.h"

#define KChooseWidth KDeviceW*330/375

@interface MonitorFilterView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,MonitorCellDelegate>
@property (nonatomic ,strong) UICollectionView *collectionview;
@property (nonatomic ,strong) UIView *footerView;
@property (nonatomic ,strong) UIButton *resetBtn;
@property (nonatomic ,strong) UIButton *confirmBtn;



@end

@implementation MonitorFilterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0];
        
        _saveArray = [NSMutableArray array];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideChooseView)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    
        [self addSubview:self.collectionview];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionview reloadData];
}


#pragma mark - 重置 确定
- (void)resetAction{
    [_collectionview reloadData];
    [_saveArray removeAllObjects];
}

- (void)confirmAction{
    
    if ([self.delegate respondsToSelector:@selector(didSelectFilterView:)]) {
        [self.delegate didSelectFilterView:_saveArray];
    }
    [self hideChooseView];
}

- (void)selectCollectionViewCell:(NSDictionary *)dic selected:(BOOL)isSelected
{
    if(!isSelected)
    {
        [_saveArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isEqual:dic])
            {
                *stop = YES;
                [_saveArray removeObject:obj];
            }
        }];
    }
    else
    {
        [_saveArray addObject:dic];
    }
}


-(void)showChooseView{
    [KeyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        CGRect frame = _collectionview.frame;
        frame.origin.x = KDeviceW- KChooseWidth;
        _collectionview.frame = frame;
        
        CGRect frame2 = _footerView.frame;
        frame2.origin.y = self.height - frame2.size.height;
        _footerView.frame = frame2;
    }];
}

-(void)hideChooseView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _collectionview.frame;
        frame.origin.x = KDeviceW ;
        _collectionview.frame = frame;
        
        CGRect frame2 = _footerView.frame;
        frame2.origin.y = self.frame.size.height ;
        _footerView.frame = frame2;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UICollectionViewDataSource

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return [_dataArray count];
//}
//
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MonitorFilterCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MonitorFilterCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    cell.dataDic = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MonitorFilterHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MonitorFilterHeader" forIndexPath:indexPath];
    
    return header;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *str = [dic objectForKey:@"monitor_condition_name"];
    
    return CGSizeMake([self getTextWidth:str]+12*2, 30);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KChooseWidth, 75);
}

- (CGFloat)getTextWidth:(NSString *)text{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.width;
}

#pragma mark - lazy load
- (UICollectionView *)collectionview{
    if (!_collectionview) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 5;
        
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(KDeviceW, 0, KChooseWidth, KDeviceH-44) collectionViewLayout:layout];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.backgroundColor = [UIColor whiteColor];
        _collectionview.contentInset = UIEdgeInsetsMake(KStatusBarHeight+10, 10, 0, 10);
        _collectionview.allowsMultipleSelection = YES;
        [_collectionview registerClass:[MonitorFilterCell class] forCellWithReuseIdentifier:@"MonitorFilterCell"];
        [_collectionview registerClass:[MonitorFilterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MonitorFilterHeader"];
        //        [_collectionview registerClass:[FilterPlainSeionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterPlainSeionHeader"];
        
        
        self.footerView = [[UIView alloc]initWithFrame:KFrame(KDeviceW- KChooseWidth, self.height, KChooseWidth, 44)];
        _footerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_footerView];
        
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetBtn.frame = KFrame(0, 0, KChooseWidth/2, 44);
        _resetBtn.backgroundColor = [UIColor whiteColor];
        _resetBtn.titleLabel.font = KFont(16);
        [_resetBtn setBorderWithTop:YES left:NO bottom:NO right:NO borderColor:KHexRGB(0xc8c8c8) borderWidth:.5];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:KHexRGB(0x666666) forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_resetBtn];
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = KFrame(_resetBtn.maxX, 0 , KChooseWidth/2, 44);
        _confirmBtn.titleLabel.font = KFont(16);
        _confirmBtn.backgroundColor = KHexRGB(0xDA222A);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_confirmBtn];
        
    }
    return _collectionview;
}

@end
