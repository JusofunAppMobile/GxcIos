//
//  MonitorDynamicCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorDynamicCell.h"
#import "MonitorListModel.h"

@interface MonitorDynamicCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *dynamicLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) UIButton *monitorBtn;
@end

@implementation MonitorDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.width.height.mas_equalTo(40);
                make.left.mas_equalTo(10);
            }];
            view.backgroundColor = [UIColor greenColor];
            view;
        });
        
        self.monitorBtn = ({
            UIButton *view = [UIButton new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.height.mas_equalTo(26);
                make.width.mas_equalTo(50);
            }];
            view.layer.borderWidth = .5f;
            view.layer.borderColor = KHexRGB(0xd93947).CGColor;
            view.layer.cornerRadius = 2;
            view.layer.masksToBounds = YES;
            view.titleLabel.font = KFont(12);
            [view setTitle:@"监控" forState:UIControlStateNormal];
            [view setTitle:@"取消监控" forState:UIControlStateSelected];
            [view setTitleColor:KHexRGB(0xd93947) forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0x909090) forState:UIControlStateSelected];
            [view addTarget:self action:@selector(monitorAction) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_iconView);
                make.left.mas_equalTo(_iconView.mas_right).offset(15);
                make.right.mas_lessThanOrEqualTo(_monitorBtn.mas_left).offset(-10);
            }];
            view.font = KFont(15);
            view.text = @"小米科技有限责任公司";
            view;
        });
        
        self.dynamicLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_nameLab.mas_bottom).offset(10);
                make.left.mas_equalTo(_nameLab);
            }];
            view.font = KFont(12);
            view.text = @"共3条动态";
            view.textColor = KHexRGB(0x909090);
            view;
        });
        
        self.dateLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_dynamicLab);
                make.left.mas_equalTo(_dynamicLab.mas_right).offset(17);
            }];
            view.font = KFont(12);
            view.text = @"2019-09-08";
            view.textColor = KHexRGB(0x909090);
            view;
        });
        
    }
    return self;
}

- (void)setModel:(MonitorListModel *)model{
    _model = model;
    _nameLab.text = model.companyName;
    _dateLab.text = model.changeDate;
    [self setMonitorButtonState:[model.isUserMonitor boolValue]];
    
    NSString *dynamicStr = [NSString stringWithFormat:@"共%@条动态",model.changeNum];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:dynamicStr];
    [attr addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xe8603b) range:NSMakeRange(1, dynamicStr.length - 4)];
    _dynamicLab.attributedText = attr;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.companyIcon] placeholderImage:KImageName(@"")];//test
}

- (void)monitorAction{
    if ([self.delegate respondsToSelector:@selector(didClickMonitorButton:monitor:)]) {
        [self.delegate didClickMonitorButton:_model monitor:!_monitorBtn.selected];
    }
}

- (void)setMonitorButtonState:(BOOL)selected{
    _monitorBtn.selected = selected;
    if (_monitorBtn.selected) {
        _monitorBtn.layer.borderColor = KHexRGB(0x909090).CGColor;
        [_monitorBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
        }];
    }else{
        _monitorBtn.layer.borderColor = KHexRGB(0xd93947).CGColor;
        [_monitorBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
        }];
    }
}

@end
