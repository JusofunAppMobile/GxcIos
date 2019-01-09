//
//  HomeSectionHeader.m
//  EnterpriseInquiry
//
//  Created by wzh on 2018/1/5.
//  Copyright © 2018年 王志朋. All rights reserved.
//

#import "HomeSectionHeader.h"

@interface HomeSectionHeader ()
@property (nonatomic ,strong) UIButton *moreBtn;



@end
@implementation HomeSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView *kongView = [[UIView alloc]init];
        kongView.backgroundColor = KRGB(243, 242, 242);
        [self.contentView addSubview:kongView];
        [kongView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(10);
            make.bottom.mas_equalTo(self.contentView).offset(-45);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = KRGB(223, 36, 44);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kongView.mas_bottom).offset(15);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(2);
            make.bottom.mas_equalTo(self.contentView).offset(-15);
           
        }];
       

        self.titleLabel = ({
            UILabel *view = [[UILabel alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.centerY.mas_equalTo(line);
                make.bottom.mas_equalTo(self.contentView);
                make.left.mas_equalTo(line.mas_right).offset(5);
                make.width.mas_equalTo(150);
                
            }];
            view.font = KFont(16);
            view.textColor = KRGB(51, 51, 51);
            view;
        });
        
        self.moreBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [view setImage:KImageName(@"icon_more") forState:UIControlStateNormal];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.contentView);
               make.centerY.mas_equalTo(line); make.right.mas_equalTo(self.contentView).offset(-15);
                make.width.mas_equalTo(44);
                
            }];
            [view addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
        
        UIView *line2 = [[UIView alloc]init];
        line2.backgroundColor = KRGB(227, 227, 227);
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView);
            make.left.width.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
       
    }
    return self;
}



- (void)moreAction{
    if ([self.delegate respondsToSelector:@selector(sectionHeaderMoreBtnClicked:)]) {
        [self.delegate sectionHeaderMoreBtnClicked:self.titleLabel.text];
    }
}

@end

