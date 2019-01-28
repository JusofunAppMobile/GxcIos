//
//  MyMonitorCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MyMonitorCell.h"
#import "MyMonitorListModel.h"
#import <UIButton+LXMImagePosition.h>

@interface MyMonitorCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) MyMonitorListModel *model;
@property (nonatomic ,assign) ListType type;
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
                make.width.height.mas_equalTo(33);
            }];
            view;
        });
        
        self.monitorBtn = ({
            UIButton *view = [UIButton new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView).offset(-15);
                make.height.mas_equalTo(50);
                make.width.mas_equalTo(50);
            }];
            view.titleLabel.font = KFont(11);
            [view setTitleColor:KHexRGB(0xd93947) forState:UIControlStateNormal];
            [view setTitleColor:KHexRGB(0x909090) forState:UIControlStateSelected];
            [view addTarget:self action:@selector(monitorAction) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
        
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(_iconView.mas_right).offset(5);
                make.right.mas_lessThanOrEqualTo(_monitorBtn.mas_left).offset(-5);
            }];
            view.font = KFont(16);
            view.textColor = KHexRGB(0x303030);
            view;
        });
    }
    return self;
}


- (void)setModel:(MyMonitorListModel *)model type:(ListType)type{
    _model = model;
    _type = type;
    
    _nameLab.text = model.companyName;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:KImageName(@"home_icon_gongsi")];
    [self setMonitorButtonState:YES];
}

- (void)monitorAction{
    if ([self.delegate respondsToSelector:@selector(didClickMonitorButton:)]) {
        [self.delegate didClickMonitorButton:_model];
    }
}

- (void)setMonitorButtonState:(BOOL)selected
{
    _monitorBtn.selected = selected;
    
    if(_monitorBtn.selected)
    {
        NSString *title = _type == ListTypeMyMonitor?@"取消监控":@"取消收藏";
        NSString *imageName = _type == ListTypeMyMonitor?@"icon_monitor":@"shoucang";
        
        
        [_monitorBtn setTitle:title forState:UIControlStateNormal];
        [_monitorBtn setImage:KImageName(imageName) forState:UIControlStateNormal];
    }
    else
    {
        NSString *title = _type == ListTypeMyMonitor?@"监控":@"收藏";
        NSString *imageName = _type == ListTypeMyMonitor?@"icon_monitor_sel":@"shoucang";
        
        [_monitorBtn setTitle:title forState:UIControlStateNormal];
        [_monitorBtn setImage:KImageName(imageName) forState:UIControlStateNormal];
    }
    [_monitorBtn setImagePosition:LXMImagePositionTop spacing:7];
    
}




@end
