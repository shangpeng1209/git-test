//
//  systemNewsModel.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/21.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "systemNewsModel.h"

@implementation systemNewsModel




//-(void)setValue:(id)value forUndefinedKey:(NSString *)key


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.NewsID =(NSInteger) value;
    }

}

@end
