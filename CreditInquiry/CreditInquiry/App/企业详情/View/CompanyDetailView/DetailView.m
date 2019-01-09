//
//  DetailView.m
//  EnterpriseInquiry
//
//  Created by WangZhipeng on 17/9/4.
//  Copyright © 2017年 王志朋. All rights reserved.
//

#import "DetailView.h"
#import "ReportTypeView.h"
#import "ReportTypeModel.h"
#import "UIButton+WebCache.h"

#define KFoldBtnTag 89463

@interface DetailView()<ReportTypeDelegate>
{
    UIButton *phoneBtn;
    BOOL isShowPhone;//联系信息
    BOOL isShowRisk;//风险信息
    BOOL isShowManage;//经营状况
    BOOL isShowMoney;//无形资产
    
    NSArray *riskArray;
    NSArray *manageArray;
    NSArray *moneyArray;
    
    BOOL isShowCompanyRisk;//企业风险
    BOOL isShowHoldel;//股东
    BOOL isShowMap;//国信企业图谱
    
    NSMutableArray *headArray;
    
    
}
@property (nonatomic, strong) UIButton *reportBtn;
@property (nonatomic ,strong) UIImageView *reportImageView;
@property (nonatomic ,strong) UIView *toolBar;//底部工具条
@property (nonatomic ,strong) ReportTypeView *reportTypeView;
@property (nonatomic ,strong) ReportTypeModel *selectedModel;

@end

@implementation DetailView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        isShowPhone = NO;
        isShowRisk = NO;
        isShowManage = NO;
        isShowMoney = NO;
        isShowCompanyRisk = NO;
        isShowHoldel = NO;
        isShowMap = NO;
        headArray = [NSMutableArray arrayWithObjects:@"企业详情",@"联系信息",@"股东",@"企业风险",@"国信企业图谱",@"企业背景",@"风险信息",@"企业风险预警",@"经营状况", @"无形资产",nil];
        
        [self addSubview:self.backTableView];
        [self reportView];
    }
    return self;
}

#pragma mark - 打电话
-(void)call
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(callCompany:)])
    {
        [self.delegate callCompany:[[self.detailModel.companyphonelist objectAtIndex:0] objectForKey:@"number"]];
    }
}
-(void)downContact
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(downContact)])
    {
        [self.delegate downContact];
    }
}

-(void)refreshCompany
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(refreshCompany)])
    {
        [self.delegate refreshCompany];
    }
}

-(void)gridButtonClick:(GridButton *)button cellSection:(int)section
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(gridButtonClick: cellSection:)])
    {
        ItemModel *sqModel = [ItemModel mj_objectWithKeyValues:button.buttonDic];
        [self.delegate gridButtonClick:sqModel cellSection:section];
    }
}

-(void)detailMapButtonClick:(UIButton *)button
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(detailMapButtonClick:)])
    {
        
        [self.delegate detailMapButtonClick:button];
    }
}


-(void)setDetailModel:(CompanyDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    [self.backTableView reloadData];
}

-(void)foldAction:(UIButton*)button
{
    
    Headerype type;
    
    
    BOOL isShow;
    NSArray *array;
    NSInteger section ;
    if (button.tag == KFoldBtnTag +3)//风险信息
    {
        type = HeaderRiskType;
        isShow = isShowRisk;
        array = riskArray;
        section = [headArray indexOfObject:@"风险信息"];
    }
    else if (button.tag == KFoldBtnTag +4)//经营状况
    {
        type = HeaderManageType;
        isShow = isShowManage;
        array = manageArray;
        section = [headArray indexOfObject:@"经营状况"];
    }
    else //if (button.tag == KFoldBtnTag +5)//无形资产
    {
        type = HeaderMoneyType;
        isShow = isShowMoney;
        array = moneyArray;
        section = [headArray indexOfObject:@"无形资产"];
    }
    
    
    if(!isShow)
    {
        if(array.count == 0)
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(headerClick:)])
            {
                [self.delegate headerClick:type];
            }

        }
        else
        {
            [self changeOpen:button];
            [self.backTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
            [self.backTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
    }
    else
    {
        [self changeOpen:button];
        [self.backTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

-(void)changeOpen:(UIButton*)button
{
    if (button.tag == KFoldBtnTag +3)//风险信息
    {
        
        isShowRisk = !isShowRisk;
        
    }
    else if (button.tag == KFoldBtnTag +4)//经营状况
    {
        
        isShowManage = !isShowManage;
        
    }
    else //if (button.tag == KFoldBtnTag +5)//无形资产
    {
       
        isShowMoney = !isShowMoney;
        
    }

}

-(void)reloadViewWithType:(Headerype)type gridArray:(NSArray *)array animate:(BOOL)animate
{
    
    NSInteger section ;
    if (type == HeaderRiskType)//风险信息
    {
        isShowRisk = !isShowRisk;
        section = [headArray indexOfObject:@"风险信息"];
        riskArray = array;
    }
    else if (type == HeaderManageType)//经营状况
    {
        isShowManage = !isShowManage;
        section =  [headArray indexOfObject:@"经营状况"];;
        manageArray = array;
    }
    else //if (button.tag == KFoldBtnTag +5)//无形资产
    {
        isShowMoney = !isShowMoney;
        section =  [headArray indexOfObject:@"无形资产"];;
        moneyArray = array;
    }
    
    [self.backTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    if(animate)
    {
         [self.backTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }

}

-(void)beginRefreshAnimation
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    DetailInfoCell *cell = (DetailInfoCell*)[self.backTableView cellForRowAtIndexPath:indexPath];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.6;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [cell.refreshBtn.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

-(void)stopRefreshAnimation
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    DetailInfoCell *cell = (DetailInfoCell*)[self.backTableView cellForRowAtIndexPath:indexPath];
    [cell.refreshBtn.imageView.layer removeAllAnimations];
}

-(void)checkReport:(UIButton*)button
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(checkReport:)])
    {
        [self.delegate checkReport:button];
    }
}

#pragma mark - 展开联系方式
-(void)showPhone
{
//    isShowPhone = !isShowPhone;
//
//    [self.backTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    if(self.delegate && [self.delegate respondsToSelector:@selector(checkDetailMoreInfo)])
    {
        [self.delegate checkDetailMoreInfo];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *headStr = [headArray objectAtIndex:indexPath.section];
    if([headStr isEqualToString:@"联系信息"])
    {
        if(indexPath.row == 0)
        {
            if(self.detailModel.latitude.length == 0||[self.detailModel.latitude isEqualToString:@"-"]||self.detailModel.longitude.length == 0||[self.detailModel.longitude isEqualToString:@"-"])
            {
                return ;
            }
            if(self.delegate && [self.delegate respondsToSelector:@selector(companyAdress)])
            {
                [self.delegate companyAdress];
            }
        }
        else if (indexPath.row == 1)
        {
            if (self.detailModel.neturl.count > 0) {
                NSString *addressURL = [NSString stringWithFormat:@"%@",[[self.detailModel.neturl objectAtIndex:0] objectForKey:@"url"]];
                if (addressURL.length > 0) {//地址不为空才跳转
                    
                    if(self.delegate && [self.delegate respondsToSelector:@selector(CompanyUrl:)])
                    {
                        [self.delegate CompanyUrl:addressURL];
                    }
                }

        }
        }
    }
    else if ([headStr isEqualToString:@"企业风险"])
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(checkDetailRisk)])
        {
            [self.delegate checkDetailRisk];
        }
    }
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return headArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *headStr = [headArray objectAtIndex:section];
    
    if([headStr isEqualToString:@"企业详情"])
    {
        return 1;
    }
    else if ([headStr isEqualToString:@"联系信息"])
    {
        if(isShowPhone)
        {
            return 2;
        }
        else
        {
            return 0;
        }
    }
    else if ([headStr isEqualToString:@"股东"])
    {
        return 1;
    }
    else if ([headStr isEqualToString:@"企业风险"])
    {
        return 1;
    }
    else if ([headStr isEqualToString:@"国信企业图谱"])
    {
        return 1;
    }
    else if ([headStr isEqualToString:@"企业背景"])
    {
        return 1;
    }
    else if ([headStr isEqualToString:@"风险信息"])
    {
        if(isShowRisk)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else if ([headStr isEqualToString:@"企业风险预警"])
    {
        return 0;
    }
    else if ([headStr isEqualToString:@"经营状况"])
    {
        if(isShowManage)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else if ([headStr isEqualToString:@"无形资产"])
    {
        if(isShowMoney)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    
    return 0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"%d%did",(int)indexPath.section,(int)indexPath.row];
    
    NSString *headStr = [headArray objectAtIndex:indexPath.section];
    
    if([headStr isEqualToString:@"企业详情"])
    {
        DetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell = [[DetailInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.refreshBtn addTarget:self action:@selector(refreshCompany) forControlEvents:UIControlEventTouchUpInside];
        cell.detailModel = _detailModel;
        
        return cell;
    }
    else if ([headStr isEqualToString:@"联系信息"])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if(indexPath.row == 1)
            {
                UIView *lineView = [[UIView alloc]initWithFrame:KFrame(0, 1, KDeviceW, 1)];
                lineView.tag = 34751;
                lineView.backgroundColor =KHexRGB(0xebebeb);
                [cell.contentView addSubview:lineView];
                
                UIView *lineView2 = [[UIView alloc]initWithFrame:KFrame(0, 44, KDeviceW, 1)];
                lineView.tag = 34752;
                lineView2.backgroundColor =KHexRGB(0xebebeb);
                [cell.contentView addSubview:lineView2];
            }
            
        }
        
        cell.textLabel.font = KFont(13);
        cell.textLabel.textColor = KHexRGB(0x666666);
        cell.textLabel.numberOfLines = 0;
        if(indexPath.row == 0)
        {
            cell.imageView.image = KImageName(@"地址icon");
            cell.textLabel.text = self.detailModel.address;
            
        }
        else
        {
            cell.imageView.image = KImageName(@"网址icon");
            cell.textLabel.text = self.detailModel.neturl.count>0?[[self.detailModel.neturl objectAtIndex:0] objectForKey:@"url"]:@"--";
        }
        
        return cell;
    }
    else if ([headStr isEqualToString:@"股东"])
    {
        
    }
    else if ([headStr isEqualToString:@"企业风险"])
    {
        DetailRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell = [[DetailRiskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.detailGridDelegate = self;
        }
       
        return cell;
    }
    else if ([headStr isEqualToString:@"国信企业图谱"])
    {
        DetailMapCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell = [[DetailMapCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        
        return cell;
    }
    else if ([headStr isEqualToString:@"企业背景"])
    {
        DetailGridCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell = [[DetailGridCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailGridDelegate = self;
        }
        cell.section = (int)indexPath.section;
        [cell setCellData:self.detailModel.subclassMenu];
        return cell;
    }
    else if ([headStr isEqualToString:@"风险信息"])
    {
        DetailGridCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell = [[DetailGridCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailGridDelegate = self;
            
        }
        cell.section = (int)indexPath.section;
        [cell setCellData:riskArray];
        return cell;
    }
    else if ([headStr isEqualToString:@"企业风险预警"])
    {
        
    }
    else if ([headStr isEqualToString:@"经营状况"])
    {
        DetailGridCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell = [[DetailGridCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailGridDelegate = self;
            
        }
        cell.section = (int)indexPath.section;
        [cell setCellData:manageArray];
        return cell;
    }
    else //if ([headStr isEqualToString:@"无形资产"])
    {
        DetailGridCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell = [[DetailGridCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailGridDelegate = self;
            
        }
        cell.section = (int)indexPath.section;
        [cell setCellData:moneyArray];
        return cell;
    }
    
    return [UITableViewCell new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *headStr = [headArray objectAtIndex:indexPath.section];
    
    if([headStr isEqualToString:@"企业详情"])
    {
        DetailInfoCell *cell = (DetailInfoCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    }
    else if ([headStr isEqualToString:@"联系信息"])
    {
        if(indexPath.row == 0)
        {
            NSString *adress = self.detailModel.address;
            
            CGFloat hight = [Tools getHeightWithString:adress fontSize:13 maxWidth:KDeviceW - 50 - 15]+ 20;
            
            return hight >45 ? hight:45;
        }
        else
        {
            return 45;
        }
    }
    else if ([headStr isEqualToString:@"股东"])
    {
        return 120;
    }
    else if ([headStr isEqualToString:@"企业风险"])
    {
        return 80;
    }
    else if ([headStr isEqualToString:@"国信企业图谱"])
    {
        return 110;
    }
    else if ([headStr isEqualToString:@"企业背景"])
    {
        NSArray *array = self.detailModel.subclassMenu;
        if(array.count >0)
        {
            return KDetailGridWidth* (array.count%4>0?(array.count/4+1):array.count/4);
        }
        else
        {
            return KDetailGridWidth *3;
        }
    }
    else if ([headStr isEqualToString:@"风险信息"])
    {
        if(self.detailModel)
        {
            return KDetailGridWidth* (riskArray.count%4>0?(riskArray.count/4+1):riskArray.count/4);
        }
        else
        {
            return KDetailGridWidth ;
        }
    }
    else if ([headStr isEqualToString:@"企业风险预警"])
    {
        return 0;
    }
    else if ([headStr isEqualToString:@"经营状况"])
    {
        if(self.detailModel)
        {
            return KDetailGridWidth* (manageArray.count%4>0?(manageArray.count/4+1):manageArray.count/4);
        }
        else
        {
            return KDetailGridWidth ;
        }
    }
    else if ([headStr isEqualToString:@"无形资产"])
    {
        if(self.detailModel)
        {
            return KDetailGridWidth* (moneyArray.count%4>0?(moneyArray.count/4+1):moneyArray.count/4);
        }
        else
        {
            return KDetailGridWidth ;
        }
    }
   
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headStr = [headArray objectAtIndex:section];
    
    if([headStr isEqualToString:@"企业详情"])
    {
        return nil;
    }
    else if ([headStr isEqualToString:@"联系信息"])
    {
        UIView *phoneView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 45)];
        phoneView.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        
        phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *str = [ NSString stringWithFormat:@"  %@",self.detailModel.companyphonelist.count >0?[[self.detailModel.companyphonelist objectAtIndex:0] objectForKey:@"number"]:@"--"];
        if([str isEqualToString:@"  --"]||[str isEqualToString:@"  "])
        {
            phoneBtn.enabled = NO;
        }
        CGFloat phoneWidth = [Tools getWidthWithString:str fontSize:13 maxHeight:45]+30;
        phoneBtn.frame = KFrame(15, 0, phoneWidth, 45);
        [phoneBtn setImage:KImageName(@"电话icon") forState:UIControlStateNormal];
        [phoneBtn setTitle:str forState:UIControlStateNormal];
        [phoneBtn setTitleColor:KHexRGB(0x666666) forState:UIControlStateNormal];
        phoneBtn.titleLabel.font = KFont(13);
        phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [phoneBtn addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
        [phoneView addSubview:phoneBtn];
        
        if(phoneBtn.enabled)
        {
            //            UILabel*contactLabel = [[UILabel alloc]initWithFrame:KFrame(phoneBtn.maxX +10, 10.5, 45, 24)];
            //            contactLabel.text = @"导出";
            //            contactLabel.textColor = KRGB(249, 127, 51);
            //            contactLabel.font = KFont(13);
            //            contactLabel.textAlignment = NSTextAlignmentCenter;
            //            contactLabel.layer.cornerRadius = 12;
            //            contactLabel.layer.borderColor = KRGB(245, 145, 108).CGColor;
            //            contactLabel.layer.borderWidth  = 1;
            //            [phoneView addSubview:contactLabel];
            //
            //            UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            contactBtn.frame = KFrame(phoneBtn.maxX +10, 0, contactLabel.width, 45);
            //            [contactBtn addTarget:self action:@selector(downContact) forControlEvents:UIControlEventTouchUpInside];
            //            [phoneView addSubview:contactBtn];
            
        }
        
        UILabel*label = [[UILabel alloc]initWithFrame:KFrame(KDeviceW - 80, 0, 80, 45)];
        label.text = @"更多信息 >";
        label.textColor = KHexRGB(0x666666);
        label.font = KFont(13);
        [phoneView addSubview:label];
        
        UIButton *phoneFoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        phoneFoldBtn.frame = label.frame;
        [phoneFoldBtn addTarget:self action:@selector(showPhone) forControlEvents:UIControlEventTouchUpInside];
        [phoneView addSubview:phoneFoldBtn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:KFrame(0, 44, KDeviceW, 1)];
        lineView.backgroundColor =KHexRGB(0xebebeb);
        [phoneView addSubview:lineView];
        
        
        return phoneView;
    }
    else if ([headStr isEqualToString:@"股东"])
    {
        return nil;
    }
    else if ([headStr isEqualToString:@"企业风险"])
    {
        return nil;
    }
    else if ([headStr isEqualToString:@"国信企业图谱"])
    {
        return [self headViewWithTitle:@"国信企业图谱"];
    }
    else if ([headStr isEqualToString:@"企业背景"])
    {
        return [self headViewWithTitle:@"企业背景"];
    }
    else if ([headStr isEqualToString:@"风险信息"])
    {
        return [self headViewWithTitle:@"风险信息"];
    }
    else if ([headStr isEqualToString:@"企业风险预警"])
    {
        return [self headViewWithTitle:@"企业风险预警"];
    }
    else if ([headStr isEqualToString:@"经营状况"])
    {
        return [self headViewWithTitle:@"经营状况"];
    }
    else if ([headStr isEqualToString:@"无形资产"])
    {
        return [self headViewWithTitle:@"无形资产"];
    }
    
    return nil;
}


-(UIView*)headViewWithTitle:(NSString *)headTitle
{
    UIView *view = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *kongView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 5)];
    kongView.backgroundColor = KRGB(241, 242, 246);
    [view addSubview:kongView];
    
    
    UIView *kuanView = [[UIView alloc]initWithFrame:KFrame(15, kongView.maxY + 15, 5, 15)];
    kuanView.backgroundColor = KRGB(214, 0, 0);
    kuanView.layer.cornerRadius = 2;
    kuanView.clipsToBounds = YES;
    [view addSubview:kuanView];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:KFrame(KDeviceW -15-15, kongView.maxY +15, 15, 15)];
    
    imageView.tag = KFoldBtnTag *100;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    UIButton *phoneFoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneFoldBtn.frame = view.frame;
    
    [phoneFoldBtn addTarget:self action:@selector(foldAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:phoneFoldBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:KFrame(0, kongView.maxY +44, KDeviceW, 1)];
    lineView.backgroundColor =KHexRGB(0xebebeb);
    [view addSubview:lineView];
  
    BOOL isShow = NO;
    
    int tag = KFoldBtnTag;
    
    if([headTitle isEqual: @"企业背景"])
    {
        tag = KFoldBtnTag;
        [imageView removeFromSuperview];
        [phoneFoldBtn removeFromSuperview];
    }
    else if ([headTitle isEqual: @"风险信息"])
    {
        tag = KFoldBtnTag+3;
        isShow = isShowRisk;
    }
    else if ([headTitle isEqual: @"经营状况"])
    {
       tag = KFoldBtnTag+4;
        isShow = isShowManage;
    }
    else if ([headTitle isEqual: @"无形资产"])
    {
        tag = KFoldBtnTag+5;
        isShow = isShowMoney;
    }
    else if ([headTitle isEqual: @"企业风险预警"])
    {
        tag = KFoldBtnTag+6;
        [imageView removeFromSuperview];
    }
    else if ([headTitle isEqual:@"国信企业图谱"])
    {
        tag = KFoldBtnTag+7;
        [imageView removeFromSuperview];
        //lineView.hidden = YES;
    }
    
    phoneFoldBtn.tag = tag;
    
    
    
    if (isShow)
    {
        imageView.image = KImageName(@"橙色上拉小三角");
        
    }
    else
    {
        imageView.image = KImageName(@"灰色三角下拉");
    }

    
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(kuanView.maxX + 10, kongView.maxY +5, KDeviceW - 100, view.height-15)];
    label.text = headTitle;
    label.textColor = KHexRGB(0x333333);
    label.font = KBlodFont(14);
    [view addSubview:label];
    
    
    
    
    

    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *headStr = [headArray objectAtIndex:section];
   
    if([headStr isEqualToString:@"企业详情"])
    {
        return  0.0001;
    }
    else if ([headStr isEqualToString:@"联系信息"])
    {
       return 50;
    }
    else if ([headStr isEqualToString:@"股东"])
    {
        return  0.0001;
    }
    else if ([headStr isEqualToString:@"企业风险"])
    {
        return  0.0001;
    }
    else if ([headStr isEqualToString:@"国信企业图谱"])
    {
         return 50;
    }
    else if ([headStr isEqualToString:@"企业背景"])
    {
        return 50;;
    }
    else if ([headStr isEqualToString:@"风险信息"])
    {
        return 50;
    }
    else if ([headStr isEqualToString:@"企业风险预警"])
    {
        return 50;
    }
    else if ([headStr isEqualToString:@"经营状况"])
    {
        return 50;
    }
    else if ([headStr isEqualToString:@"无形资产"])
    {
        return 50;
    }
   return  0.0001;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}




-(UITableView *)backTableView
{
    if(!_backTableView)
    {
        _backTableView = [[UITableView alloc]initWithFrame:KFrame(0, 0, self.width, KDeviceH -KNavigationBarHeight-55 -KBottomHeight) style:UITableViewStyleGrouped];
        _backTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _backTableView.delegate = self;
        _backTableView.dataSource = self;
        _backTableView.backgroundColor = [UIColor clearColor];
        _backTableView.estimatedRowHeight = 0;//禁用self-sizing 计算完整contentsize
        _backTableView.estimatedSectionHeaderHeight = 0;
        _backTableView.estimatedSectionFooterHeight = 0;
    }
    
    return _backTableView;
}


-(void)reportView
{
    self.toolBar = [[UIView alloc]initWithFrame:KFrame(0, KDeviceH - 55-KBottomHeight-KNavigationBarHeight, KDeviceW, 55+KBottomHeight)];
    self.toolBar.backgroundColor = KRGB(223, 43, 46);
    self.toolBar.layer.shadowOpacity = 0.5;// 阴影透明度
    self.toolBar.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    self.toolBar.layer.shadowRadius = 3;// 阴影扩散的范围控制
    self.toolBar.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    [self addSubview:self.toolBar  ];
    
   
    UIView *view = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 55)];
    view.backgroundColor = [UIColor whiteColor];
    [self.toolBar addSubview:view];
    
    NSArray *array = @[@"获取报告",@"纠错",@"监控",@"认证"];
    
    NSArray *imageArray = @[@"icon_vip",@"icon_vip",@"icon_vip",@"icon_vip"];
    for(int i = 0;i<array.count;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = KFrame(KDeviceW/4*i+0.5*i, 0, KDeviceW/4, 55);
        button.backgroundColor = KRGB(220, 39, 42);;
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = KFont(15);
        [button setImage:KImageName(imageArray[i]) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(checkReport:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = KDetailOperationTag + i;
        [button setImagePosition:LXMImagePositionTop spacing:5];
        [_toolBar addSubview:button];
    }

    
    
    
}

- (void)reportBtnAction{
//    if (_detailModel.reportTypeList.count < 2) {//test
//        return;
//    }
    _reportBtn.selected = !_reportBtn.selected;
    [self reportListShow:_reportBtn.selected];//test
    NSLog(@"弹出／隐藏");
}

- (void)reportListShow:(BOOL)show{
    if (show) {
        [self addSubview:self.reportTypeView];
    }else{
        [_reportTypeView removeFromSuperview];
    }
}

#pragma mark - ReportTypeDelegate
- (void)didSwitchReportType:(ReportTypeModel *)model{
    _selectedModel = model;
    [_reportBtn setTitle:model.name forState:UIControlStateNormal];
    [_reportImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:KImageName(@"企业报告")];
    _reportBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_reportBtn.imageView.width, 0, _reportBtn.imageView.width);
    _reportBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _reportBtn.titleLabel.width+5, 0, -_reportBtn.titleLabel.width-5);
}

#pragma mark - lazy load
- (ReportTypeView *)reportTypeView{
    if (!_reportTypeView) {
        CGFloat height = 48*2+10;//三角高度
        //    CGFloat height = 48*(_detailModel.reportTypeList.count-1)+10;//test
        _reportTypeView = [[ReportTypeView alloc]initWithFrame: KFrame(5, _toolBar.y-height, 200, height)];
        _reportTypeView.models = _detailModel.reportTypeList;
        _reportTypeView.delegate = self;
    }
    return _reportTypeView;
}



@end
