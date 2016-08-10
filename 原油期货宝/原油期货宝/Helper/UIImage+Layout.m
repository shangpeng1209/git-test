//
//  UIImage+Layout.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/25.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "UIImage+Layout.h"

@implementation UIImage (Layout)



+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageW = 3;
    CGFloat imageH = 3;
    // 1.开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}



@end
