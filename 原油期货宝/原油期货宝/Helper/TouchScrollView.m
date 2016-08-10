//
//  TouchScrollView.m
//  微油宝
//
//  Created by 尚朋 on 16/6/3.
//  Copyright © 2016年 shang. All rights reserved.
//

#import "TouchScrollView.h"

@implementation TouchScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize touchesdelegate=_touchesdelegate;
- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    
    if (!self.dragging) {
        //run at ios5 ,no effect;
        [self.nextResponder touchesEnded: touches withEvent:event];
        if (_touchesdelegate!=nil) {
            
            [_touchesdelegate scrollViewTouchesEnded:touches withEvent:event whichView:self];
        }
        //NSLog(@"UITouchScrollView nextResponder touchesEnded");
    }
    [super touchesEnded: touches withEvent: event];
    
}




@end
