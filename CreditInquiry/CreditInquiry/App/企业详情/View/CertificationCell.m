//
//  CertificationCell.m
//  CreditInquiry
//
//  Created by WangZhipeng on 2019/1/8.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "CertificationCell.h"

@implementation CertificationCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(int)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textColor = KRGB(22, 22, 22);
            label.font = KFont(16);
            label.text = @"";
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(15);
               // make.width.mas_lessThanOrEqualTo(100);
            }];
            label;
        });
        //[self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
      //  [self.nameLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        if(type == 1)
        {
            self.introLabel = ({
                UILabel *label = [[UILabel alloc]init];
                label.textColor = KRGB(22, 22, 22);
                label.font = KFont(14);
                label.text = @"";
                label.numberOfLines = 0;
                [self.contentView addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(30);
                    make.right.mas_equalTo(self.contentView).offset(-30); make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
                    
                }];
                label;
            });
            
            
            self.addBtn = ({
                UIButton *view = [[UIButton alloc]init];
                [view setImage:KImageName(@"index_topbg") forState:UIControlStateNormal];
                view.layer.cornerRadius = 5;
                view.clipsToBounds = YES;
                [view addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(250.0/1334*KDeviceH);
                    make.width.mas_equalTo(370.0/750*KDeviceW);
                    make.centerX.mas_equalTo(self.contentView); make.top.mas_equalTo(self.introLabel.mas_bottom).offset(30);
                    make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-30);
                    
                }];
                view;
            });
            
            self.reloadLabel = ({
                UILabel *label = [[UILabel alloc]init];
                label.textColor = [UIColor whiteColor];
                label.font = KFont(16);
                label.text = @"重新上传";
                label.hidden = YES;
                label.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
                [self.addBtn addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.mas_equalTo(self.addBtn);
                    make.height.mas_equalTo(25);
                    
                }];
                label;
            });
            self.addImageView = ({
                UIImageView *view = [[UIImageView alloc]init];
                view.image = KImageName(@"更新icon");
                view.hidden = YES;
                [self.addBtn addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(self.addBtn);
                    
                }];
                view;
            });
        }
        else
        {
            self.textFld = ({
                UITextField *view = [[UITextField alloc]init];
                view.textColor = KRGB(0, 0, 0);
                //view.font = KFont(14);
                view.text = @"";
                //[view setValue:KFont(14) forKeyPath:@"_placeholderLabel.font"];
                [self.contentView addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.nameLabel.mas_right).offset(10);
                    make.right.mas_equalTo(self.contentView).offset(-15);
                        make.top.mas_equalTo(self.nameLabel);
                    make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
                }];
                view;
            });
            [self.nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.textFld setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

            
        }
    }
    return self;
}

-(void)setIndex:(NSInteger)index
{
    if(index == 0)
    {
        self.nameLabel.text = @"企业名称:";
        self.textFld.placeholder = @"请输入企业名称";
    }
    else if (index == 1)
    {
        self.nameLabel.text = @"身  份  证:";
        self.textFld.placeholder = @"请输入您的身份证号码";
    }
    else if (index == 2)
    {
        self.nameLabel.text = @"职       位:";
        self.textFld.placeholder = @"请输入您在企业的任职";
    }
    else if (index == 3)
    {
        self.nameLabel.text = @"手机号码:";
        self.textFld.placeholder = @"请输入您的手机号码";
        self.textFld.text = @"13644811627";
        self.textFld.enabled = NO;
    }
    else if (index == 4)
    {
        self.nameLabel.text = @"邮       箱:";
        self.textFld.placeholder = @"请输入您的邮件地址";
    }
    else if (index == 5)
    {
        self.nameLabel.text = @"营业执照:";
        self.introLabel.text = @"仅支持JPG、JPEG和PNG格式，大小不超过5兆。文字应清晰可辨。企业名称必须与您填写的名称一致。";
        
    }
    else if (index == 6)
    {
        self.nameLabel.text = @"本人身份证:";
        self.introLabel.text = @"仅支持JPG、JPEG和PNG格式，大小不超过5兆。请手持身份证进行拍照";
    }
    
    self.addBtn.tag = KCertificationTag + index;

}

-(void)addImage:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(addImage:)]) {
        [self.delegate addImage:button.tag - KCertificationTag];
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
