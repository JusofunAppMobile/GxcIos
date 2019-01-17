//
//  VisitorController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "VisitorController.h"

@interface VisitorController ()
{
    UITableView* backTableView;
    UILabel *countLabel;
    int pageIndex;
    NSMutableArray *dataArray;
}

@end

@implementation VisitorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavigationBarTitle:@"访客" andTextColor:[UIColor whiteColor]];
    [self setWhiteBackButton];
    [self drawTableView];
    

}


-(void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@"20" forKey:@"pageSize"];
    [params setObject:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"pageIndex"];
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KVisitorRecord parameters:params  success:^(id responseObject) {
        [MBProgressHUD hideHudToView:self.view animated:NO];
        [self endRefresh];
        if ([responseObject[@"result"] integerValue] == 0) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            if (pageIndex == 1) {
                [dataArray removeAllObjects];
                dataArray = [NSMutableArray array];
            }
            
            [dataArray addObjectsFromArray:[dataDic objectForKey:@"news"]];
          
            [self setCount:[[responseObject objectForKey:@"data"] objectForKey:@"count"]];
            [backTableView reloadData];
            
            int count = [[dataDic objectForKey:@"count"] intValue];
            if(dataArray.count>=count)
            {
                [backTableView.mj_footer endRefreshingWithNoMoreData];
            }
            pageIndex++;
            
        }else{
            [MBProgressHUD showHint:responseObject[@"msg"] toView:self.view];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"哎呀，服务器开小差啦，请您稍等，马上回来~" toView:self.view];
        [self endRefresh];
    }];
}


-(void)endRefresh
{
    [backTableView.mj_header endRefreshing];
    [backTableView.mj_footer endRefreshing];
}

-(void)setCount:(NSString *)count
{
    NSString *str1 = @"用户访问：";
    NSString *countStr = [NSString stringWithFormat:@"%@",count];
    NSString *str2  = @"次";
    
    NSString *str3 = [NSString stringWithFormat:@"%@%@%@",str1,countStr,str2];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str3];
    
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0]
                          range:NSMakeRange(0, str1.length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor whiteColor]
                          range:NSMakeRange(0, str1.length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xFFDE5D) range:NSMakeRange(str1.length, str3.length- str1.length)];
    
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:30.0]
                          range:NSMakeRange(str1.length, countStr.length)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:16.0]
                          range:NSMakeRange(str3.length-1, 1)];
    countLabel.attributedText = AttributedStr;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ideterfir = @"ideterfir";
    
    VistorCell *cell = [tableView dequeueReusableCellWithIdentifier:ideterfir];
    if(!cell)
    {
        cell = [[VistorCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideterfir ];
    }
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [dic objectForKey:@"name"];
    cell.timeLabel.text = [dic objectForKey:@"date"];
   
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(dataArray.count == 0)
    {
        return nil;
    }
    
    //把 view2 的 左下角 和 右下角的直角切成圆角
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15,0,KDeviceW-30,10)];
    view.backgroundColor = [UIColor whiteColor];
    

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;

    return view;
    
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)drawTableView
{
    
    UIImageView*backView = [UIImageView new];
    backView.image = KImageName(@"index_topbg");
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(210);
        make.width.mas_equalTo(KDeviceW);
    }];
    
    countLabel = [[UILabel alloc]initWithFrame:KFrame(15, KNavigationBarHeight + 25, self.view.width - 30, 25)];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:countLabel];
    
    
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, countLabel.maxY+ 10, countLabel.width, 10)];
//    view.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:view];
    
    
    backTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    backTableView.backgroundColor = [UIColor clearColor];
    backTableView.delegate = self;
    backTableView.dataSource = self;
    backTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    backTableView.estimatedRowHeight = 50;
    backTableView.showsVerticalScrollIndicator = NO;
    backTableView.rowHeight  = UITableViewAutomaticDimension;
    backTableView.estimatedSectionHeaderHeight = 0;
    backTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:backTableView];
    [backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(countLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.view).mas_equalTo(-15);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    backTableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageIndex = 1;
        [self loadData];
    }];
    [backTableView.mj_header beginRefreshing];
    backTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar fs_setBackgroundColor:[UIColor clearColor]];
}



@end
