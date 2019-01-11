//
//  SettingPlainCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SettingPlainCell.h"

@interface SettingPlainCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UITextField *contentLab;
@end

@implementation SettingPlainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.titleLab = ({
            UILabel *titleLab = [UILabel new];
            titleLab.font = KFont(15);
            titleLab.textColor = KHexRGB(0x303030);
            [self.contentView addSubview:titleLab];
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView).offset(19);
                make.bottom.mas_equalTo(self.contentView).offset(-19);
                make.left.mas_equalTo(self.contentView).offset(15);
            }];
            titleLab;
        });
       
        self.contentLab = ({
            UITextField *view = [UITextField new];
            view.font = KFont(15);
            view.textColor = KHexRGB(0x878787);
            view.enabled = NO;
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_equalTo(self.contentView);
            }];
            view;
        });
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            _titleLab.text = @"手机";
            _contentLab.placeholder = @"请输入手机号码";
        }else if (indexPath.row == 2){
            _titleLab.text = @"密码";
            _contentLab.placeholder = @"修改密码";
        }else if (indexPath.row == 3){
            _titleLab.text = @"邮箱";
            _contentLab.placeholder = @"请输入邮箱";
        }
    }else{
        if (indexPath.row == 0) {
            _titleLab.text = @"公司";
            _contentLab.placeholder = @"填写公司";
        }else if (indexPath.row == 1){
            _titleLab.text = @"部门";
            _contentLab.placeholder = @"填写部门";
        }else if (indexPath.row == 2){
            _titleLab.text = @"职务";
            _contentLab.placeholder = @"填写职务";
        }else{
            _titleLab.text = @"行业";
            _contentLab.placeholder = @"填写行业";
        }
    }
}

- (NSString *)title{
    return _titleLab.text;
}

@end
