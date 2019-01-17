//
//  ReportExportBar.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/7/23.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "ReportExportBar.h"

@interface ReportExportBar ()

@property (nonatomic ,strong) UILabel *tips;
@property (nonatomic ,strong) UIButton *editBtn;//导出报告
@property (nonatomic ,strong) UIButton *exportBtn;
@property (nonatomic ,strong) UILabel *exportNumLab;//导出数目label

@end

@implementation ReportExportBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KHexRGB(0xf3f3f3);
        
        self.tips = ({
            UILabel *view = [UILabel new];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(15);
            }];
            view.textColor = KHexRGB(0x999999);
            view.font = KFont(12);
            view;
        });
        
        self.editBtn = ({
            UIButton *view = [UIButton new];
            view.hidden = YES;
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(_tips.mas_right).offset(20);
            }];
           // [view setTitle:@"导出报告" forState:UIControlStateNormal];
           // [view setTitle:@"取消导出" forState:UIControlStateSelected];
            [view setTitleColor:KHexRGB(0xfc7b2b) forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0x999999) forState:UIControlStateSelected];
            //[view addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
            view.titleLabel.font = KFont(14);
            view;
        });
    }
    return self;
}

- (void)setBarType:(int)barType{
    _barType = barType;
    
    _editBtn.hidden = _barType;
}

- (void)setExportNum:(NSInteger)exportNum{
    self.exportNumLab.text = [NSString stringWithFormat:@"(%li/%d)",exportNum,KReportExportNum];
}

#pragma mark - action
- (void)editAction{
    _editBtn.selected = !_editBtn.selected;
   self.exportNumLab.hidden = self.exportBtn.hidden = self.selectAllBtn.hidden = !_editBtn.selected;
    
    _selectAllBtn.selected = _editBtn.selected?_selectAllBtn.selected:NO;//取消导出，则取消全选状态
    if ([_delegate respondsToSelector:@selector(exportBarSelectAllAction:)]) {
        [_delegate exportBarSelectAllAction:NO];
    }
    
    if (_editBtn.selected) {
        [_tips removeFromSuperview];
        [_editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.centerY.mas_equalTo(self);
        }];
    }else{
        [self addSubview:_tips];
        [_tips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(15);
        }];
        [_editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_tips.mas_right).offset(20);
            make.centerY.mas_equalTo(self);
        }];
    }
}

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

#pragma mark - setData
- (void)setTipsWithNum:(NSString *)num type:(SearchType)type{
    NSString *tips = @"";
    NSRange range;
    if (type == SearchTaxCodeType) {
        tips = [NSString stringWithFormat:@"搜索到%@家公司",num];
        range = NSMakeRange(3, [num length]);
    }else if(type == SearchJobType){
        tips = [NSString stringWithFormat:@"共搜索到%@个招聘",num];
        range = NSMakeRange(4, [num length]);
    }else{
        tips = [NSString stringWithFormat:@"共匹配到%@家企业",num];
        range = NSMakeRange(4, [num length]);
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:tips];
    [str addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xfc7b2b) range:range];
    _tips.attributedText = str;
}

#pragma mark - lazyLoad
- (UILabel *)exportNumLab{
    if (!_exportNumLab) {
        _exportNumLab = [UILabel new];
        _exportNumLab.font = KFont(14);
        _exportNumLab.textColor = KHexRGB(0x999999);
        _exportNumLab.hidden = YES;
        [self addSubview:_exportNumLab];
        [_exportNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_editBtn.mas_right).offset(10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _exportNumLab;
}

- (UIButton *)selectAllBtn{
    if (!_selectAllBtn) {
        _selectAllBtn = [UIButton new];
        [self addSubview:_selectAllBtn];
        [_selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(50);
            make.right.mas_equalTo(self.exportBtn.mas_left).offset(-34);
        }];
        _selectAllBtn.hidden = YES;
        _selectAllBtn.titleLabel.font = KFont(14);
        _selectAllBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        [_selectAllBtn setImage:KImageName(@"蓝色未选中") forState:UIControlStateNormal];
        [_selectAllBtn setImage:KImageName(@"蓝色选中") forState:UIControlStateSelected];
        [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_selectAllBtn setTitleColor:KHexRGB(0x666666) forState:UIControlStateNormal];
        [_selectAllBtn addTarget:self action:@selector(selectAllAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllBtn;
}

- (UIButton *)exportBtn{
    if (!_exportBtn) {
        _exportBtn = [UIButton new];
        [_exportBtn setImage:KImageName(@"导出按钮") forState: UIControlStateNormal];
        [_exportBtn addTarget:self action:@selector(exportAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_exportBtn];
        [_exportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _exportBtn;
}



@end
