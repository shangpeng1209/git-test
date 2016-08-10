//
//  infoModel.h
//  原油期货宝
//
//  Created by 尚朋 on 16/8/3.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface infoModel : NSObject

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imagePath;


-(void)setModelWithStr:(NSString *)str;

+(void)modelWithStr;


@end
