//
//  BrowseController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/16.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "BrowseController.h"
#import "UITableView+NoData.h"

@interface BrowseController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *backTableView;
    int pageIndex;
    NSMutableArray *dataArray;
    UILabel *countLabel;
}

@end

@implementation BrowseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KHexRGB(0xF0F2F5);
    [self setNavigationBarTitle:@"浏览记录"];
    [self setBlankBackButton];
    [self setRightNaviButton];
    
    [self drawTableView];
    
    [self setCountLabel:@"3"];
    
}

-(void)loadData:(BOOL)loading
{
    if (loading) {
        [self showLoadDataAnimation];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@"20" forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"pageIndex"];
    [RequestManager postWithURLString:KBrowseList parameters:params  success:^(id responseObject) {
        [self hideLoadDataAnimation];
        [self endRefresh];
        if ([responseObject[@"result"] integerValue] == 0) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            if (pageIndex == 1) {
                [dataArray removeAllObjects];
                dataArray = [NSMutableArray array];
            }
            
            [dataArray addObjectsFromArray:[dataDic objectForKey:@"list"]];
            
            [self setCountLabel:[[responseObject objectForKey:@"data"] objectForKey:@"totalCount"]];
            [backTableView nd_reloadData];
            
            int count = [[dataDic objectForKey:@"totalCount"] intValue];
            if(dataArray.count>=count)
            {
                [backTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            pageIndex++;
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [self showNetFailViewWithFrame:backTableView.frame];
        [self endRefresh];
    }];
}

-(void)deleteList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KDelBrowseList parameters:params  success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:NO];
        [self endRefresh];
        if ([responseObject[@"result"] integerValue] == 0) {
            
            [MBProgressHUD showSuccess:@"清空成功" toView:self.view];
            [dataArray removeAllObjects];
            [backTableView reloadData];
        
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:self.view];
        [self endRefresh];
    }];
}


-(void)endRefresh
{
    [backTableView.mj_header endRefreshing];
    [backTableView.mj_footer endRefreshing];
}


-(void)setCountLabel:(NSString *)string
{
    
    NSString *str1 = @"数量：";
    NSString *str3 = @"条";
    NSString *allStr = [NSString stringWithFormat:@"%@%@%@",str1,string,str3];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, allStr.length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:KHexRGB(0x999999)
                          range:NSMakeRange(0, str1.length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:KHexRGB(0xEA0015)
                          range:NSMakeRange(str1.length,string.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:KHexRGB(0x999999)
                          range:NSMakeRange(str1.length+string.length,str3.length)];
    
    countLabel.attributedText = attributedStr;
}
-(void)rightAction
{
    UIAlertView *WXinstall=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认清空浏览历史吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [WXinstall show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self deleteList];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    BrowseCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        cell = [[BrowseCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideterfir ];
    }
    
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.section];
    
    
    cell.nameLabel.text = [dic objectForKey:@"companyname"];
   // [cell.nameImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@""]] placeholderImage:KImageName(@"")];;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(void)drawTableView
{
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = KHexRGB(0xF0F2F5);
    label.font = KFont(14);
    label.textColor = KHexRGB(0x999999);
    label.text = @"";
    [self.view addSubview:label];
    countLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavigationBarHeight);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
    }];
    
    
    backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    backTableView.backgroundColor = [UIColor clearColor];
    backTableView.delegate = self;
    backTableView.dataSource = self;
    backTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    backTableView.estimatedRowHeight = 50;
    backTableView.showsVerticalScrollIndicator = NO;
    backTableView.rowHeight  = UITableViewAutomaticDimension;
    backTableView.estimatedSectionHeaderHeight = 0;
    backTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:backTableView];
    [backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    backTableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageIndex = 1;
        [self loadData:NO];
    }];
    [backTableView.mj_header beginRefreshing];
    backTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData:NO];
    }];
    
}

- (void)setRightNaviButton{
    UIButton *button = [[UIButton alloc]initWithFrame:KFrame(0, 0, 35, 40)];
    button.titleLabel.font = KFont(16);
    [button setTitle:@"清空" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [barView addSubview:button];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - 网络异常
- (void)abnormalViewReload{
    [self loadData:YES];
}

@end
