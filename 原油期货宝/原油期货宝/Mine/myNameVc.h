//
//  myNameVc.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/27.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NameType) {
    
    NameTypeNick = 0,//
    NameTypeName = 1,//实名认证页
    
};


@protocol myNameVcDelegate <NSObject>

-(void)myNameVcSenderDictionary:(NSDictionary *)value;

@end


@interface myNameVc : UIViewController


@property (nonatomic, strong) NSDictionary *nameDic;
@property (nonatomic, assign) NameType type;
@property (nonatomic, assign) id<myNameVcDelegate>delegate;

@end
