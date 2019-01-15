//
//  HomeHeaderView.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/1/4.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "HomeHeaderView.h"


@interface HomeHeaderView()
{
    UIView *hotKeyView;
    UIView *searchView;
    SDCycleScrollView *cycleView;
    UIView *kongView;
    
    
}

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
    
       
        
        
        UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, KNavigationBarHeight, KDeviceW, 32)];
        logoImageView.contentMode = UIViewContentModeCenter;
        logoImageView.image = KImageName(@"index_logo");
        [self addSubview:logoImageView];
        
        
        
        self.searchBtnView = [[SearchButton alloc] initWithFrame:CGRectMake(15, logoImageView.maxY+ 30, KDeviceW -30, 44) andPlaceText:KSearchPlaceholder];
        self.searchBtnView.searchImageView.image = KImageName(@"icon_search");
        self.searchBtnView.backgroundColor = [UIColor whiteColor] ;
        self.searchBtnView.layer.cornerRadius = 44/2;
        [self addSubview:_searchBtnView];
        
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KDeviceW, _searchBtnView.maxY+25)];
        
        view.image = KImageName(@"index_topbg");
        [self insertSubview:view atIndex:0];
        
        
        hotKeyView = [[UIView alloc]initWithFrame:KFrame(0, _searchBtnView.maxY+25, KDeviceW, 40)];
        [self addSubview:hotKeyView];
        
        [self reloadHotKeyView:@[@"中投国信",@"崔岩莉",@"工信通",@"九次方大数据",@"宁波梅山保税港区玖合"]];
        CGFloat width = (KDeviceW - 30)/4;
        searchView = [[UIView alloc]initWithFrame:KFrame(0, hotKeyView.maxY, KDeviceW, width+40)];
        [self addSubview:searchView];
        
       // [self reloadSearchView:@[@"股东高管",@"主营产品",@"地址电话",@"失信查询"]];
        
        kongView = [[UIView alloc]initWithFrame:KFrame(0, searchView.maxY+20, KDeviceW, 10)];
        kongView.backgroundColor = KRGB(243, 242, 242);
        [self addSubview:kongView];
        
        
        cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, kongView.maxY, KDeviceW, KDeviceW*90/375) delegate:self placeholderImage:[UIImage imageNamed:@"home_banner"]];
        cycleView.delegate = self;
        //cycleView.imageURLStringsGroup = imageUrlArray;
        cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        [self addSubview:cycleView];
        
        [self adjustFrame];
        
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    [self reloadHotKeyView:[dataDic objectForKey:@"keywords"]];
    NSArray *array = [dataDic objectForKey:@"menu"];
    [self reloadSearchView:array];
    
    NSArray *array2 = [dataDic objectForKey:@"adImages"];
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:1];
    for(NSDictionary *dic in array2)
    {
        [imageArray addObject:[dic objectForKey:@"imageURL"]];
    }
    cycleView.imageURLStringsGroup = imageArray;
   
}



-(void)reloadSearchView:(NSArray *)titleArray
{
    [searchView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat orginx = 15;
    CGFloat width = (KDeviceW - 30)/4;
    CGFloat orginy = 15;
    CGFloat hight = 65;
    CGFloat space = 10;
    CenterButton *lastBtn;
    
   // NSArray *imageArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@""];
    
    for (int i = 0; i<[titleArray count]; i++) {
        int col = i%4;//列数
        int row = i/4;//行数
        
        NSDictionary*dic = [titleArray objectAtIndex:i];
        
        CenterButton *centButton = [[CenterButton alloc] initWithFrame:CGRectMake(orginx+ col * width, orginy+row*hight+space*row, width, hight)];
        centButton.tag = 100+ i;
        centButton.titleLabel.font = KFont(13);
        [centButton setTitle:[dic objectForKey:@"menuName"] forState:UIControlStateNormal];
        [centButton setTitleColor:KHexRGB(0x333333) forState:UIControlStateNormal];
        [centButton setTitleColor:KHexRGB(0x666666) forState:UIControlStateDisabled];
        //[centButton setImage:[UIImage imageNamed:@"icon_gudong"] forState:UIControlStateNormal];
        [centButton sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"menuImage"]] forState:UIControlStateNormal placeholderImage:KImageName(@"")];
        [centButton addTarget:self action:@selector(goToSearch:) forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:centButton];
        centButton.dataDic = dic;
        if(i == titleArray.count-1)
        {
            lastBtn = centButton;
        }
    }
    
    CGRect frame = searchView.frame;
    frame.size.height = lastBtn.maxY + 10;
    searchView.frame = frame;
    
    [self adjustFrame];
}


-(void)adjustFrame
{
    
    CGRect frame3 = kongView.frame;
    frame3.origin.y = searchView.maxY+10;
    kongView.frame = frame3;
    
    CGRect frame4 = cycleView.frame;
    frame4.origin.y = kongView.maxY;
    cycleView.frame = frame4;
    
    CGRect frame2 = self.frame;
    frame2.size.height = cycleView.maxY;
    self.frame = frame2;
}


-(void)reloadHotKeyView:(NSArray*)hotKeyArray
{
    [hotKeyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(25, 0, 40, hotKeyView.height)];
    label.text = @"热搜：";
    label.textColor = KRGB(153, 153, 153);
    label.font = KFont(12);
    [hotKeyView addSubview:label];
    
    CGFloat x = label.maxX;
    for(NSString *str in hotKeyArray)
    {
        
        CGFloat width = [Tools getWidthWithString:str fontSize:12 maxHeight:15];
        
        if(x + width + 15 > KDeviceW)
        {
            break;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = KFrame(x, label.y, width+20, label.height);
        button.titleLabel.font = KFont(12);
        [button setTitle:str forState:UIControlStateNormal];
        [button setTitleColor:KRGB(51, 51, 51) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hotKeySearch:) forControlEvents:UIControlEventTouchUpInside];
        [hotKeyView addSubview:button];
        x = button.maxX;
        
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:KFrame(0, hotKeyView.height - 0.5, KDeviceW, 0.5)];
    lineView.backgroundColor = KRGB(224, 224, 224);
    [hotKeyView addSubview:lineView];
    
}


- (void)hotKeySearch:(UIButton *)button
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(hotKeySearch:)])
    {
        [self.delegate hotKeySearch:button.titleLabel.text];
    }
}

- (void)goToSearch:(CenterButton *)button{
    if ([_delegate respondsToSelector:@selector(headerBtnClicked:)]) {
        [_delegate headerBtnClicked:button];
    }
}


-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(adClick:)])
    {
        
        NSArray *array =  [self.dataDic objectForKey:@"adImages"];
        if(array.count >index)
        {
            NSDictionary *dic = array[index];
            [self.delegate adClick:[dic objectForKey:@"webURL"]];
        }
        
    }
}


@end

