//
//  InviteView.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/1.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "InviteView.h"

@implementation InviteView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}


-(void)loadUI{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSArray * array = [[UIApplication sharedApplication] windows];
    
    if (array.count >= 2) {
        
        window = [array objectAtIndex:1];
        
    }
    
//    UIView  *coverView = [window viewWithTag:(NSInteger)10000000001];
//    UIView  *smallCoverView = [window viewWithTag:(NSInteger)10000000002];
//    [coverView removeFromSuperview];
//    [smallCoverView removeFromSuperview];
//    smallCoverView = nil;
//    coverView = nil;



}





@end
