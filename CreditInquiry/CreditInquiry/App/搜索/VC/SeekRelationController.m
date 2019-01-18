//
//  SeekRelationController.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/9.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SeekRelationController.h"

@interface SeekRelationController ()<UITextFieldDelegate>
{
    UITextField *fromTextFld;
    UITextField *toTextFld;
    
    UIButton *bigBtn;
    
}

@end

@implementation SeekRelationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBarTitle:@"查关系"];
    [self setBlankBackButton];
    
    self.view.backgroundColor = KRGB(240, 242, 245);
    
    
    [self drawView];
    
}

-(void)search
{
    
}

-(void)showBig
{
    
}


-(void)drawView
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.textColor = KRGB(153, 153, 153);
    label1.font = KFont(14);
    label1.text = @"从";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15+KNavigationBarHeight);
    }];
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"查关系" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = KFont(14);
    button.backgroundColor = KRGB(238, 37, 32);
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(30+KNavigationBarHeight);
        make.right.mas_equalTo(self.view).offset(-15);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = KRGB(219, 219, 219);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(button.mas_left).offset(-15);
    }];
    
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.textColor = KRGB(153, 153, 153);
    label2.font = KFont(14);
    label2.text = @"从";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
    }];
    
    fromTextFld = [[UITextField alloc]init];
    fromTextFld.textColor = KRGB(51, 51, 51);
    fromTextFld.font = KFont(14);
    fromTextFld.placeholder = @"请分别添加两个公司或个人";
    //[view setValue:KFont(14) forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:fromTextFld];
    [fromTextFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(10);
        make.right.mas_equalTo(lineView);
        make.top.mas_equalTo(label1);

    }];
    
    toTextFld = [[UITextField alloc]init];
    toTextFld.textColor = KRGB(51, 51, 51);
    toTextFld.font = KFont(14);
    toTextFld.placeholder = @"请分别添加两个公司或个人";
    //[view setValue:KFont(14) forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:toTextFld];
    [toTextFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(10);
        make.right.mas_equalTo(lineView);
        make.top.mas_equalTo(label2);
        
    }];
    
   
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(KNavigationBarHeight);
        make.bottom.mas_equalTo(toTextFld.mas_bottom).offset(15);
    }];
    
    [label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [fromTextFld setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [toTextFld setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    UIImageView *bgView = [UIImageView new];
    bgView.image = KImageName(@"seek");
    [self.view addSubview:bgView];
   
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        //make.top.mas_equalTo(backView.mas_bottom).offset(50);
    }];
    
    [self.view layoutIfNeeded];
    
    
    if(bgView.y<=backView.maxY)
    {
        [bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(backView.mas_bottom).offset(30);
        }];
    }
    
    
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.textColor = KRGB(153, 153, 153);
    label3.font = KFont(16);
    label3.numberOfLines = 0;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"请分别添加2个公司或个人\n再点击\"查关系\"发现关系";
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(45);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    bigBtn = [[UIButton alloc]init];
    [bigBtn setTitle:@"  点击查看大图" forState:UIControlStateNormal];
    [bigBtn setTitleColor:KRGB(231, 0, 11) forState:UIControlStateNormal];
    bigBtn.titleLabel.font = KFont(12);
    [bigBtn setImage:KImageName(@"fangda-2") forState:UIControlStateNormal];
    bigBtn.layer.cornerRadius = 5;
    bigBtn.clipsToBounds = YES;
    [bigBtn addTarget:self action:@selector(showBig) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bigBtn];
    bigBtn.layer.borderWidth = 1;
    bigBtn.layer.borderColor = KRGB(229, 229, 229).CGColor;
    bigBtn.layer.shadowOpacity = 0.5;// 阴影透明
    bigBtn.layer.shadowColor = KRGB(229, 229, 229).CGColor;// 阴影的颜色
    bigBtn.layer.shadowRadius = 1;// 阴影扩散的范围控制
    bigBtn.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    
    [bigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(130);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-30);
        make.right.mas_equalTo(self.view).offset(-15);
    }];
    
    
}





















@end
