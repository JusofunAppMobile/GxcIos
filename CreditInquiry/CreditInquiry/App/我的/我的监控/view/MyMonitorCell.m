//
//  MyMonitorCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyMonitorCell.h"
#import "MyMonitorListModel.h"

@interface MyMonitorCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UIButton *monitorBtn;
@end
@implementation MyMonitorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(15);
                make.width.height.mas_equalTo(25);
            }];
            view.backgroundColor = [UIColor grayColor];
            view;
        });
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(_iconView.mas_right).offset(15);
            }];
            view.font = KFont(16);
            view.text = @"小米科技股份有限公司";
            view.textColor = KHexRGB(0x303030);
            view;
        });
        
        self.monitorBtn = ({
            UIButton *view = [UIButton new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.height.mas_equalTo(26);
                make.width.mas_equalTo(65);
            }];
            view.selected = YES;
            view.layer.borderWidth = .5f;
            view.layer.borderColor = KHexRGB(0x909090).CGColor;
            view.layer.cornerRadius = 2;
            view.layer.masksToBounds = YES;
            view.titleLabel.font = KFont(14);
            [view setTitle:@"监控" forState:UIControlStateNormal];
            [view setTitle:@"取消监控" forState:UIControlStateSelected];
            [view setTitleColor:KHexRGB(0xd93947) forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0x909090) forState:UIControlStateSelected];
            [view addTarget:self action:@selector(monitorAction) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
        
    }
    return self;
}

- (void)setModel:(MyMonitorListModel *)model{
    _model = model;
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];//test,model.companyicon?
    _nameLab.text = model.companyname;
}

- (void)monitorAction{
    _monitorBtn.selected = !_monitorBtn.selected;
    if (_monitorBtn.selected) {
        _monitorBtn.layer.borderColor = KHexRGB(0x909090).CGColor;
        [_monitorBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(65);
        }];
    }else{
        _monitorBtn.layer.borderColor = KHexRGB(0xd93947).CGColor;
        [_monitorBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
        }];
    }
    
}



@end
