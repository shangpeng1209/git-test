//
//  NewsViewController.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/21.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,newsType) {
    
    NewsTypeDefault = 1000,//默认
    NewsTypeSystem = 1000,// 系统消息
    NewsTypeTrade = 1001,// 交易提醒
    
    
};


@interface NewsViewController : UIViewController

@property (nonatomic, assign) newsType NewsType;


@end
