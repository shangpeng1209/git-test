
//
//  infoModel.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/3.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "infoModel.h"

@implementation infoModel

-(void)setModelWithStr:(NSString *)str{

    NSArray *array = [str componentsSeparatedByString:@"#"];

    
    NSString * time = array[2];
    
    NSArray * timeArr =[time componentsSeparatedByString:@" "];
    
    _time = [timeArr lastObject];//时间
    _text = array[3];//内容
    _imagePath = array [6];


}


+(void)modelWithStr{





}




@end
