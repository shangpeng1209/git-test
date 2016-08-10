//
//  UIView+Layout.h
//  ILimateFrme
//
//  Created by 尚朋 on 15/11/25.
//  Copyright © 2015年 asdw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

//获取当前的x

//-(CGFloat)current_x;
//
////获取当前的y
//-(CGFloat)current_y;
////获取当前的weight
//-(CGFloat)current_wight;
////获取当前的height
//-(CGFloat)current_height;
//
//-(CGFloat)current_x_weight;
//
//-(CGFloat)current_y_height;

//获取当前的X
- (CGFloat)current_x;

//获取当前的Y
- (CGFloat)current_y;

//获取当前的H
- (CGFloat)current_h;

//获取当前的W
- (CGFloat)current_w;

//获取当前x位置
- (CGFloat)current_x_w;

//获取当前y位置
- (CGFloat)current_y_h;

@end
