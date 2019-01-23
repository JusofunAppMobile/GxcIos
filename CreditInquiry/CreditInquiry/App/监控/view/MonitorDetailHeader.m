//
//  MonitorDetailHeader.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "MonitorDetailHeader.h"
#import "ContentInsetsLabel.h"

@interface MonitorDetailHeader ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) ContentInsetsLabel *tagLab;
@property (nonatomic ,strong) UILabel *numLab;
@end

@implementation MonitorDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView *vectorLine = [UIView new];
        vectorLine.backgroundColor = KHexRGB(0xda2632);
        vectorLine.layer.cornerRadius = 2;
        vectorLine.layer.masksToBounds = YES;
        [self.contentView addSubview:vectorLine];
        [vectorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(17);
            make.width.mas_equalTo(4);
            make.left.mas_equalTo(15);
        }];
        
        self.titleLab = ({
            UILabel *titleLab = [UILabel new];
            titleLab.font = KFont(16);
            [self.contentView addSubview:titleLab];
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(vectorLine.mas_right).offset(7);
            }];
            titleLab;
        });
        
        self.tagLab = ({
            ContentInsetsLabel *titleLab = [ContentInsetsLabel new];
            [self.contentView addSubview:titleLab];
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(_titleLab.mas_right).offset(10);
            }];
            titleLab.layer.borderWidth = .5f;
            titleLab.layer.cornerRadius = 2;
            titleLab.contentInsets = UIEdgeInsetsMake(3, 4, 3, 4);
            titleLab.font = KFont(12);
            titleLab;
        });
        
        self.numLab = ({
            UILabel *titleLab = [UILabel new];
            [self.contentView addSubview:titleLab];
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView).offset(-15);
            }];
            titleLab.font = KFont(14);
            titleLab.textColor = KHexRGB(0x878787);
            titleLab;
        });
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreAction)];
        [self.contentView addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)moreAction{
    if ([self.delegate respondsToSelector:@selector(didClickMoreButton:)]) {
        [self.delegate didClickMoreButton:_model];
    }
}

-(void)setModel:(MDSectionModel *)model
{
    _model = model;
    _titleLab.text = model.monitor_name;
    _numLab.text = [NSString stringWithFormat:@"共%@条",model.total];
    if([model.icon intValue] == 2)//1：变更信息    2：警示信息 3：利好信息
    {
        _tagLab.textColor = KHexRGB(0xDC212A);
        _tagLab.layer.borderColor = KHexRGB(0xDC212A).CGColor;
        _tagLab.text = @"警示信息";
    }
    else if ([model.icon intValue] == 3)
    {
        _tagLab.textColor = KHexRGB(0x4FB037);
        _tagLab.layer.borderColor = KHexRGB(0x4FB037).CGColor;
        _tagLab.text = @"利好信息";
    }
    else
    {
        _tagLab.textColor = KHexRGB(0x1187E4);
        _tagLab.layer.borderColor = KHexRGB(0x1187E4).CGColor;
        _tagLab.text = @"提示信息";
    }
}


@end
