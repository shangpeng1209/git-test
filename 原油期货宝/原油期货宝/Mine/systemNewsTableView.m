//
//  systemNewsTableView.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/21.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "systemNewsTableView.h"

@implementation systemNewsTableView



-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    return self;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
