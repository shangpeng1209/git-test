//
//  homeButton.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/5.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "homeButton.h"

@implementation homeButton



-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self loadButton];
    }
    
    return self;
}


-(void)loadButton{

    self.centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.current_w-24)/2, 5, 24, 22)];
    
   // self.centerImageView.center = self.center;
    [self addSubview:self.centerImageView];
    
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.centerImageView.current_y_h, self.current_w, self.current_h-self.centerImageView.current_y_h)];
    
    [self addSubview:self.downLable];
 
}






@end
