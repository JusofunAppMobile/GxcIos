//
//  ExportBar.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/5/2.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "ExportBar.h"

@interface ExportBar()

@property (nonatomic ,strong) UIButton *exportBtn;
@property (nonatomic ,strong) UIButton *editBtn;

@end

@implementation ExportBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initViews];
    }
    return self;
}

- (void)initViews{
    
    UIImage *icon = KImageName(@"botom");
    CGFloat imageWidth = icon.size.width;
    CGFloat padding = KDeviceW == 320?15:30;
    
    UIButton *dateBtn = [UIButton new];
    dateBtn.titleLabel.font = KFont(16);
    [dateBtn setTitle:@"注册时间" forState:UIControlStateNormal];
    [dateBtn setTitleColor:KHexRGB(0x333333) forState:UIControlStateNormal];
    [dateBtn setImage:icon forState:UIControlStateNormal];
    [dateBtn setImage:KImageName(@"top") forState:UIControlStateSelected];
    [dateBtn.titleLabel sizeToFit];
    [dateBtn addTarget:self action:@selector(dateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dateBtn];
    [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, dateBtn.titleLabel.width+5, 0, -dateBtn.titleLabel.width-5);
    
    
    self.editBtn = ({
        UIButton *view = [UIButton new];
        view.titleLabel.font = KFont(14);
        [view addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        [view setTitle:@"导出通讯录" forState:UIControlStateNormal];
        [view setTitle:@"取消导出" forState:UIControlStateSelected];
        [view setTitleColor:KHexRGB(0xff710f) forState:UIControlStateNormal];
        [view setTitleColor:KHexRGB(0x666666) forState:UIControlStateSelected];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(dateBtn.mas_right).offset(padding+5);
            make.centerY.mas_equalTo(self);
        }];
        view;
    });
    
   
    self.exportBtn = ({
        UIButton *exportBtn  = [UIButton new];
        exportBtn.layer.borderColor = KRGB(245, 145, 108).CGColor;
        exportBtn.layer.borderWidth = 1.f;
        exportBtn.layer.masksToBounds = YES;
        exportBtn.layer.cornerRadius = 13.f;
        exportBtn.titleLabel.font = KFont(14);
        exportBtn.hidden = YES;
        [exportBtn setTitle:@"导出" forState: UIControlStateNormal];
        [exportBtn setTitleColor:KRGB(249, 127, 51) forState:UIControlStateNormal];
        [exportBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [exportBtn addTarget:self action:@selector(exportAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:exportBtn];
        [exportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(27);
            make.width.mas_equalTo(53);
        }];
        exportBtn;
    });
    
    self.selectAllBtn = ({
        UIButton *selectAllBtn = [UIButton new];
        selectAllBtn.hidden = YES;
        selectAllBtn.titleLabel.font = KFont(14);
        selectAllBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        [selectAllBtn setImage:KImageName(@"蓝色未选中") forState:UIControlStateNormal];
        [selectAllBtn setImage:KImageName(@"蓝色选中") forState:UIControlStateSelected];
        [selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [selectAllBtn setTitleColor:KHexRGB(0x666666) forState:UIControlStateNormal];
        [selectAllBtn addTarget:self action:@selector(selectAllAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectAllBtn];
        [selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_exportBtn.mas_left).offset(-padding);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(50);
        }];
        selectAllBtn;
    });
}


#pragma mark - actions
//排序
- (void)dateAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(sortByDate:)]) {
        [self.delegate sortByDate:sender.selected];
    }
}
//编辑
- (void)editAction:(UIButton *)button{
    button.selected = !button.selected;
    _selectAllBtn.hidden = _exportBtn.hidden = !button.selected;
    _selectAllBtn.selected = button.selected?_selectAllBtn.selected:NO;//取消导出，则取消全选状态
    if ([_delegate respondsToSelector:@selector(exportBarSelectAllAction:)]) {
        [_delegate exportBarSelectAllAction:NO];
    }
}

//全选
- (void)selectAllAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(exportBarSelectAllAction:)]) {
        [self.delegate exportBarSelectAllAction:sender.selected];
    }
}

- (void)exportAction{
    if ([self.delegate respondsToSelector:@selector(exportBarExportAction)]) {
        [self.delegate exportBarExportAction];
    }
}



@end
