//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * 🌟🌟🌟 新建SDCycleScrollView交流QQ群：185534916 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * 新浪微博:GSD_iOS
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios
 *
 * 另（我的自动布局库SDAutoLayout）：
 *  一行代码搞定自动布局！支持Cell和Tableview高度自适应，Label和ScrollView内容自适应，致力于
 *  做最简单易用的AutoLayout库。
 * 视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * 用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 * GitHub：https://github.com/gsdios/SDAutoLayout
 *********************************************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
//    _titleLabelBackgroundColor = titleLabelBackgroundColor;
//    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
//    _titleLabelTextColor = titleLabelTextColor;
//    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = [UIFont systemFontOfSize:11];
    _titleLabel.font = [UIFont systemFontOfSize:11];
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    _titleLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
   // _titleLabel.text = [NSString stringWithFormat:@"%@", title];
    
    [self titleLableTexWithStr:title];
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
}


-(void)titleLableTexWithStr:(NSString *)str{
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    //  headerLable.font = [UIFont systemFontOfSize:10];
    NSRange range ;
    if ([str rangeOfString:@"做空"].location !=NSNotFound) {
        
        range =[str rangeOfString:@"做空"];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor colorWithRed:37/255.0 green:210/255.0 blue:130/255.0 alpha:1]
         
                              range:range];
        
    }else if ([str rangeOfString:@"做多"].location !=NSNotFound){
    
        range =[str rangeOfString:@"做多"];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor colorWithRed:251/255.0 green:75/255.0 blue:85/255.0 alpha:1]
         
                              range:range];
    
    }else{
    
        range.location=0;
        range.length=0;
    }
   
    
    
    
    
    _titleLabel.attributedText = AttributedStr;
    //    headerLable.numberOfLines=1;
    //    headerLable.textAlignment = NSTextAlignmentCenter;
    //    tableHeaderView.backgroundColor = [UIColor whiteColor];
    //    [tableHeaderView addSubview:headerLable];
    //    [tableHeaderView addSubview:footLable];
    
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat titleLabelW = self.sd_width;
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.sd_height - titleLabelH;
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
}

@end
