//
//  ReportTypeView.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/8/9.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "ReportTypeView.h"
#import "ReportTypeModel.h"
#import "ReportTypeCell.h"

@interface ReportTypeView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) UIImageView *bgView;
@property (nonatomic ,strong) NSMutableArray *listModels;

@end
@implementation ReportTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.bgView = ({
            UIImageView *view = [UIImageView new];
            view.layer.shadowOpacity = .5;
            view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            view.layer.shadowOffset =  CGSizeMake(0.1, .1);
            view.image = KImageName(@"小弹窗背景图");
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(2, 2, 2, 2));
            }];
            view.userInteractionEnabled = YES;
            view;
        });
    }
    return self;
}

- (void)setModels:(NSArray *)models{
//    _models = models;
    _models = [self testData];//test
    [self updateModelWithType:@"1"];//
    [self.tableview reloadData];
}

- (void)updateModelWithType:(NSString *)type{
    
    [self.listModels removeAllObjects];
    for (NSInteger i = _models.count-1; i>=0; i--) {
        ReportTypeModel *model = _models[i];
        if (![model.type isEqualToString:type]) {
            [self.listModels addObject:model];
        }else{
            if ([self.delegate respondsToSelector:@selector(didSwitchReportType:)]) {
                [self.delegate didSwitchReportType:model];
            }
        }
    }
}

- (NSArray *)testData{//test
    NSArray *names = @[@"企业报告",@"股东权结构分析",@"企业风险分析报告"];
    NSMutableArray *data = [NSMutableArray array];
    for (int i= 0; i<3; i++) {
        ReportTypeModel *model = [ReportTypeModel new];
        model.name = names[i];
        model.icon = nil;
        model.type = [NSString stringWithFormat:@"%d",i+1];
        [data addObject:model];
    }
    return data;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"ReportTypeCell";
    ReportTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ReportTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setModel:_listModels[indexPath.row] hideLine: indexPath.row == _listModels.count-1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ReportTypeModel *model = _listModels[indexPath.row];
    [self updateModelWithType:model.type];
    [_tableview reloadData];
}

#pragma mark - lazy load
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView new];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_bgView addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
        }];
    }
    return _tableview;
}

- (NSMutableArray *)listModels{
    if (!_listModels) {
        _listModels = [NSMutableArray arrayWithCapacity:3];
    }
    return _listModels;
}

@end



