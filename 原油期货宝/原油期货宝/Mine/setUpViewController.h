//
//  setUpViewController.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/20.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,btnType) {
    
    homeType = 1,//从accountHomeView 跳转
    
    headType = 2,//从head跳转
    
};

@interface setUpViewController : UIViewController

@property (nonatomic, assign) btnType type;


@end
