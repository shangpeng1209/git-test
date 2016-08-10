//
//  orderDetailView.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/10.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "orderDetailView.h"

@interface orderDetailView (){
    int waveCount;
    UIColor *bgColor;
    UIColor *viewTopColor;
    CGFloat viewHeight;
}

@end


@implementation orderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
      
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
#pragma mark - 第一步：获取上下文
    //获取绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
#pragma mark - 第二步：构建路径
    if (waveCount <= 0) {
        waveCount = 30;//默认30个
    }
    
    //单个波浪线的宽度
    CGFloat itemWidth = ScreenWidth/waveCount;
    //单个波浪线的高度
    CGFloat itemHeight = 3;
    //整个view的大小
    if (viewHeight <= 0) {
        viewHeight = 50;//默认50大小
    }
    
    //背景色
    if (bgColor == nil) {
        bgColor = [UIColor blackColor];
    }
    
    if (viewTopColor == nil) {
        viewTopColor = [UIColor orangeColor];
    }
    
  //  移动到起始点,从左上画到右上
    CGContextMoveToPoint(ctx, 0, itemHeight);
    for (int i = 0; i<waveCount; i++) {
        int nextX = (i+1)*itemWidth;
        
        CGContextAddLineToPoint(ctx, nextX - itemWidth*0.5, 0);
        CGContextAddLineToPoint(ctx, nextX, itemHeight);
    }
    
    //右上移动到右下角
    CGContextAddLineToPoint(ctx, ScreenWidth, viewHeight - itemHeight);
    
    //右下角画到左下角
    for(int i = waveCount+1;i > 0;i--){
        int preX = (i-1)*itemWidth;
        CGContextAddLineToPoint(ctx, preX - itemWidth*0.5, viewHeight);
        CGContextAddLineToPoint(ctx, preX - itemWidth, viewHeight - itemHeight);
    }
    
#pragma mark - 第三步：将路径画到view上
    //    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    CGContextSetFillColorWithColor(ctx, bgColor.CGColor);
    CGContextFillPath(ctx);
    
    
//    CGContextMoveToPoint(ctx, 0, itemHeight-5);
//        for (int i = 0; i<waveCount; i++) {
//            int nextX = (i+1)*itemWidth;
//    
//            CGFloat height;
//            if (i%2 == 0) {
//                
//                height = self.current_h-itemHeight;
//                
//            }else{
//            
//            height = self.current_h;
//            }
//            
//            
////            CGContextAddLineToPoint(ctx, nextX - itemWidth*0.5, 0);
////            CGContextAddLineToPoint(ctx, nextX, itemHeight);
//            
//            CGContextAddLineToPoint(ctx, nextX - itemWidth*0.5, height);
//
//            
//            
//            
//        }
//    
//    
//        //    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
//        CGContextSetFillColorWithColor(ctx, bgColor.CGColor);
//        CGContextFillPath(ctx);
    
   

    
   
    
    
    
    
    //开始画顶部的填充图
//    CGContextMoveToPoint(ctx, 0, itemHeight);
//    for (int i = 0 ; i<waveCount; i++) {
//        int nextX = (i+1)*itemWidth;
//        CGContextAddLineToPoint(ctx, nextX - itemWidth*0.5, 0);
//        CGContextAddLineToPoint(ctx, nextX, itemHeight);
//    }
//    CGContextSetFillColorWithColor(ctx, viewTopColor.CGColor);
//    CGContextAddLineToPoint(ctx, ScreenWidth, 0);
//    CGContextAddLineToPoint(ctx, 0, 0);
//    CGContextFillPath(ctx);
}

/**
 *  设置波浪线背景颜色、波浪个数、波浪view的高度
 *
 *  @param color  颜色
 *  @param topColor 顶部颜色
 *  @param count  波浪个数
 *  @param height 波浪高度
 */
-(void)setColor:(UIColor *)color topColor:(UIColor *)topColor waveCount:(int)count waveHeight:(CGFloat)height{
    bgColor = color;
    waveCount = count;
    viewHeight = height;
    viewTopColor = topColor;
    
    [self setNeedsDisplay];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    
    view.backgroundColor = bgColor;
    [self addSubview:view];
    
}




@end
