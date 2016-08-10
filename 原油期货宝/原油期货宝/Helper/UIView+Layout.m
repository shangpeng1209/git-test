//
//  UIView+Layout.m
//  ILimateFrme
//
//  Created by 尚朋 on 15/11/25.
//  Copyright © 2015年 asdw. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)



//-(CGFloat)current_x
//{
//    return self.bounds.origin.x;
//}
//
////获取当前的y
//-(CGFloat)current_y
//{
//    return self.bounds.origin.y;
//}
////获取当前的weight
//-(CGFloat)current_wight
//{
//    return self.bounds.size.width;
//}
////获取当前的height
//-(CGFloat)current_height
//{
//    return self.bounds.size.height;
//}
//
//-(CGFloat)current_x_weight
//{
//    return self.bounds.origin.x+self.bounds.size.width;
//}
//
//-(CGFloat)current_y_height
//{
//    return self.bounds.origin.y+self.bounds.size.height;
//}
//
- (CGFloat)current_x{
    return self.frame.origin.x;
}



- (CGFloat)current_y{
    return self.frame.origin.y;
}

- (CGFloat)current_h{
    return self.frame.size.height;
}

- (CGFloat)current_w{
    return self.frame.size.width;
}

- (CGFloat)current_x_w{
    return self.frame.origin.x+self.frame.size.width;
}

- (CGFloat)current_y_h{
    return self.frame.origin.y+self.frame.size.height;
}




@end
