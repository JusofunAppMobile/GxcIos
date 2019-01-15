//
//  SettingCell.m
//  CreditInquiry
//
//  Created by JUSFOUN on 2019/1/11.
//  Copyright © 2019年 JUSFOUN. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell ()
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UILabel *contentLab;
@end

@implementation SettingCell

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
            UILabel *view = [UILabel new];
            view.font = KFont(15);
            view.textColor = KHexRGB(0x505050);
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
        if (indexPath.row == 0) {
            _titleLab.text = @"消息推送设置";
            _contentLab.text = nil;
        }else{
            _titleLab.text = @"清除缓存";
            _contentLab.text = [self getCacheSize];
        }
    }else{
        if (indexPath.row == 0) {
            _titleLab.text = @"服务协议";
            _contentLab.text = nil;
        }else if (indexPath.row == 1){
            _titleLab.text = @"隐私政策";
            _contentLab.text = nil;
        }else{
            _titleLab.text = @"关于我们";
            _contentLab.text = nil;
        }
    }
}

- (NSString *)getCacheSize{
    long long size = [[SDImageCache sharedImageCache] getSize]+[self folderSizeAtPath:[self getPhotoCachePath]];
    NSString *str = [self fileSizeWithByte:size];
    return  str;
}

//相册选取路径
- (NSString *)getPhotoCachePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
    return imageDocPath;
}

//2:遍历文件夹获得文件夹大小，返回多少b

- ( long long) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    return folderSize;
}
// 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}

- (NSString *)fileSizeWithByte:(long long)size{
    
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return @"";
        //        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fKB",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}


@end
