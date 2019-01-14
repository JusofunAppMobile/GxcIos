//
//  MonitorDetailCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorDetailCell.h"
#import "MonitorDetailModel.h"

@interface MonitorDetailCell ()
@property (nonatomic ,strong) UILabel *contentLab;
@property (nonatomic ,strong) UILabel *dateLab;
@end

@implementation MonitorDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(self.contentView).offset(15);
                make.right.mas_equalTo(-15);
            }];
            view.text = @"新增专利：一种控制只能家居设备的方法及装置控制只能家居的方法及装备与设置";
            view.numberOfLines = 0;
            view.font = KFont(15);
            view.textColor = KHexRGB(0x303030);
            view.textAlignment = NSTextAlignmentJustified;
            view;
        });
        
        self.contentLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_contentLab);
                make.top.mas_equalTo(_contentLab.mas_bottom).offset(10);
                make.bottom.mas_equalTo(self.contentView).offset(-15);
            }];
            view.text = @"2018-12-30";
            view.font = KFont(10);
            view.textColor = KHexRGB(0x909090);
            view;
        });
    }
    return self;
}

- (void)setModel:(MonitorDetailModel *)model{
    _model = model;
    _contentLab.text = model.contont;
    _dateLab.text = model.time;
    
}


@end
