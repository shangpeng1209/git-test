//
//  imageTableViewCell.h
//  原油期货宝
//
//  Created by 尚朋 on 16/8/3.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface imageTableViewCell : UITableViewCell
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

-(void)setCellWithString:(NSString *)string;

-(void)setMarkCellWithStr:(NSString *)value;


@end
