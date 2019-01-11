//
//  ObjectionTypeCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/10.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "ObjectionTypeCell.h"
#import "ObjectionItem.h"

static int BASE_TAG = 2019;

@interface ObjectionTypeCell ()
@property (nonatomic ,strong) UIView *itemBg;
@end

@implementation ObjectionTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *titleLab = [UILabel new];
        titleLab.font = KFont(15);
        titleLab.text = @"异议类型";
        [self.contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = KHexRGB(0xd9d9d9);
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLab.mas_bottom).offset(10);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(.5);
        }];
        
        self.itemBg = ({
            UIView *view = [UIView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView.mas_bottom);
                make.left.right.bottom.mas_equalTo(self.contentView);
            }];
            view;
        });
    }
    return self;
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    
    CGFloat space = 5;
    CGFloat lineSpace = 10;
    CGFloat width = (KDeviceW - 15*2 - space*3)/4;
    CGFloat height = 30;

    for (int i = 0; i<_titles.count; i++) {
        ObjectionItem *item = [[ObjectionItem alloc]initWithFrame:KFrame(15 + (width+space)*(i%4),10+(lineSpace+height)*(i/4) , width, height)];
        item.tag = BASE_TAG+i;
        [item setTitle:titles[i] forState:UIControlStateNormal];
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_itemBg addSubview:item];

        if (i == _titles.count-1) {
            [_itemBg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(item.maxY+10);
            }];
        }
    }
}

- (void)itemAction:(UIButton *)sender{
    [_itemBg.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ObjectionItem class]]) {
            ObjectionItem *button = (ObjectionItem *)obj;
            if ([obj isEqual:sender]) {
                button.selected = YES;
            }else{
                button.selected = NO;
            }
        }
    }];
}


@end
