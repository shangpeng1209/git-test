//
//  systemNewsModel.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/21.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface systemNewsModel : NSObject

@property (nonatomic, assign) NSInteger NewsID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *order;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *updateDate;

@end
