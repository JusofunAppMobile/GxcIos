//
//  SearchJobCell.m
//  EnterpriseInquiry
//
//  Created by JUSFOUN on 2018/1/3.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "SearchJobCell.h"
@interface SearchJobCell()
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *JobLab;
@property (nonatomic ,strong) UILabel *moneyLab;
@property (nonatomic ,strong) UILabel *dateLab;
@property (nonatomic ,strong) UILabel *addrLab;
@property (nonatomic ,strong) UILabel *expLab;
@property (nonatomic ,strong) UIImageView *focusView;
@property (nonatomic ,strong) UILabel *focusLab;
@property (nonatomic ,strong) UIImageView *iconView;
@end

@implementation SearchJobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bgView =({
            UIView *bgView = [UIView new];
            bgView.backgroundColor = [UIColor whiteColor];
            bgView.layer.shadowColor =  [UIColor lightGrayColor].CGColor;;
            bgView.layer.shadowOffset = CGSizeMake(0.1, .1);//0,-3
            bgView.layer.shadowRadius = 2;//0,-3
            bgView.layer.shadowOpacity = 0.8;
            bgView.layer.cornerRadius = 5;
            [self.contentView addSubview:bgView];
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(self.contentView.mas_top).offset(8);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-2);
            }];
            bgView;
        });
        
       
        
        self.moneyLab = ({
            UILabel *view = [UILabel new];
            view.font = KFont(16);
            view.textColor = KHexRGB(0x1e9efb);
            view.textAlignment = NSTextAlignmentRight;
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(_JobLab.mas_right).offset(10);
                make.right.mas_equalTo(_bgView).offset(-15);
                make.top.mas_equalTo(_bgView.mas_top).offset(20);
                make.height.mas_equalTo(16);
            }];
            view;
        });
        
        self.JobLab = ({
            UILabel *view = [UILabel new];
            view.font = KFont(16);
            view.textColor = KHexRGB(0x333333);
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_bgView).offset(15);
                make.right.mas_equalTo(_moneyLab.mas_left).offset(-10);
                make.top.mas_equalTo(_moneyLab);
            }];
            view;
        });
        
  
        UILabel *dateTitle = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_JobLab);
                make.top.mas_equalTo(_JobLab.mas_bottom).offset(15);
                make.width.mas_equalTo(72);
                make.height.mas_equalTo(14);
            }];
            view.text = @"发布日期：";
            view.font = KFont(14);
            view.textColor = KHexRGB(0x999999);
            view;
        });
        
        self.dateLab = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(dateTitle.mas_right);
                make.right.mas_equalTo(_bgView).offset(-30);
                make.top.mas_equalTo(dateTitle);
            }];
            view.textColor = KHexRGB(0x333333);
            view.font = KFont(14);
            view;
        });
        
        UILabel *addrTitle = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(dateTitle);
                make.top.mas_equalTo(dateTitle.mas_bottom).offset(15);
                make.height.mas_equalTo(14);
            }];
            view.text = @"地址：";
            view.font = KFont(14);
            view.textColor =  KHexRGB(0x999999);
            view;
        });
        
        self.addrLab = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_dateLab);
                make.top.mas_equalTo(addrTitle);
                make.height.mas_equalTo(14);
            }];
            view.text = @"北京";
            view.textColor = KHexRGB(0x333333);
            view.font = KFont(14);
            view;
        });
        
        UILabel *expTitle = ({
            UILabel *view = [UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(addrTitle);
                make.top.mas_equalTo(addrTitle.mas_bottom).offset(15);
            }];
            view.text = @"经验：";
            view.font = KFont(14);
            view.textColor =  KHexRGB(0x999999);
            view;
        });
        
        self.expLab = ({
            UILabel *view =[UILabel new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_addrLab);
                make.top.mas_equalTo(expTitle);
                make.height.mas_equalTo(14);
            }];
            view.textColor = KHexRGB(0x333333);
            view.font = KFont(14);
            view;
        });
        
        self.focusView = ({
            UIImageView *view = [UIImageView new];
//            view.image = [UIImage imageNamed:@"渐变彩条"];
            view.backgroundColor = KHexRGB(0xfff7ed);
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(_bgView);
                make.top.mas_equalTo(expTitle.mas_bottom).offset(16);
                make.height.mas_equalTo(30);
            }];
            view;
        });
        
        self.focusLab = ({
            UILabel *view = [UILabel new];
            [_focusView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_focusView).offset(15);
                make.centerY.mas_equalTo(_focusView);
                make.right.mas_equalTo(_focusView).offset(-15);
            }];
            view.textColor = KHexRGB(0x999999);
            view.font = KFont(12);
            view;
        });
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [_bgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_bgView).offset(-15);
                make.centerY.mas_equalTo(_bgView);
            }];
            view.image = KImageName(@"canTouchIcon");
            view;
        });
    
    }
    return self;
}

- (void)setModel:(SearchJobModel *)model{
    _model = model;
    _JobLab.text = model.job;
    _dateLab.text = model.publishDate;
    _addrLab.text = model.workPlace;
    _expLab.text = model.jobExperience;
    _focusLab.attributedText = [self getAttributeText:[NSString stringWithFormat:@"关联企业：%@",model.companyName]];
    _moneyLab.text = model.salary;

    if ([model.companyName length]) {
        [_focusView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
        }];
        _focusView.hidden = NO;
    }else{
        [_focusView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        _focusView.hidden = YES;
    }
}

- (NSAttributedString *)getAttributeText:(NSString *)str{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:KHexRGB(0xfe792d) range:NSMakeRange(5, str.length-5)];
    return attr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
