//
//  CreditEditImageCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CreditEditImageCell.h"
#import "GetPhoto.h"

@interface CreditEditImageCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *tipLab;
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) NSMutableDictionary *data;
@property (nonatomic ,assign) CreditEditType editType;
@end

@implementation CreditEditImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(20);
            }];
            view.font = KFont(15);
            view.textColor = KHexRGB(0x303030);
            view;
        });
        
        
        self.tipLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(30);
                make.right.mas_equalTo(self.contentView).offset(-30);
                make.top.mas_equalTo(_titleLab.mas_bottom).offset(15);
            }];
            view.numberOfLines = 2;
            view.textColor = KHexRGB(0x828282);
            view.font = KFont(12);
            view.textAlignment = NSTextAlignmentJustified;
            view;
        });
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            view.userInteractionEnabled = YES;
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
                make.bottom.mas_equalTo(self.contentView).offset(-16);
                make.width.mas_equalTo(185*(KDeviceW/375.f));
                make.height.mas_equalTo(125*(KDeviceW/375.f));
            }];
            view.contentMode = UIViewContentModeScaleAspectFit;
            view;
        });
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageAction)];
        [_iconView addGestureRecognizer:tap];
    }
    return self;
}

- (void)setContent:(NSMutableDictionary *)data type:(CreditEditType)type{
    _data = data;
    _editType = type;
    
    NSString *string = type == EditTypeInfo?data[@"logo"]:data[@"image"];
//    if (![string hasPrefix:@"http://"]) {
//        string = type == EditTypeInfo?data[@"logoHttp"]:data[@"imageHttp"];
//    }
    [_iconView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:KImageName(@"uploadDefault")];
    
    if (type == EditTypeInfo) {
        _titleLab.text = @"LOGO：";
    }else if (type == EditTypeProduct){
        _titleLab.text = @"产品图片：";
    }else if (type == EditTypeHonor){
        _titleLab.text = @"荣誉图片：";
        _tipLab.text = @"仅支持JPG、JPEG和PNG格式，大小不超过5M。文字应清晰可辨。企业名称必须与您填写的名称一致";
    }else if (type == EditTypePartner){
        _titleLab.text = @"合作伙伴图片：";
        _tipLab.text = @"仅支持JPG、JPEG和PNG格式，大小不超过5M。";
    }else{
        _titleLab.text = @"企业成员图片：";
        _tipLab.text = @"仅支持JPG、JPEG和PNG格式，大小不超过5M。";
    }
    
    if (type != EditTypeInfo&&type!=EditTypeProduct) {
        [_tipLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(13);
        }];
        [_iconView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_tipLab.mas_bottom).offset(25);
        }];
        _tipLab.hidden = NO;
    }else{
        [_tipLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        [_iconView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_tipLab.mas_bottom).offset(0);
        }];
        _tipLab.hidden = YES;
    }
}

#pragma mark - 添加图片
- (void)addImageAction{
    if ([self.delegate respondsToSelector:@selector(didClickAddImageView)]) {
        [self.delegate didClickAddImageView];
    }
}
@end
