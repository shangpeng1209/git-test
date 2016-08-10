//
//  infoTableViewCell.h
//  原油期货宝
//
//  Created by 尚朋 on 16/8/1.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol infoTableViewCellDelegate <NSObject>

-(void)cellHeight:(CGFloat)height;

@end

@interface infoTableViewCell : UITableViewCell
{
    
    
}

@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UILabel * time;
@property (nonatomic, strong) UILabel * line;
@property (nonatomic, strong) UILabel * line1;
@property (nonatomic, strong) UILabel * titleLable;
@property (nonatomic, strong) UIImageView * firstImageView;
@property (nonatomic, assign) id<infoTableViewCellDelegate>delegate ;

-(void)setCellWithString:(NSString *)string;

-(void)setMarkCellWithStr:(NSString *)value;

-(void)setCellWithTime:(NSString *)time title:(NSString *)title image:(NSString *)image;

+(CGFloat)heightForDynamicCell:(NSString *)value;
@end
