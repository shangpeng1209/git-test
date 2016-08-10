//
//  accountHomeView.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/20.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^buttonClicked)(UIButton *);

@interface accountHomeView : UIView
@property (copy)buttonClicked btnClick;
//@property (nonatomic, strong) void (^buttonClicked)(UIButton *);
@property (nonatomic, strong) UIButton * setBtn;
@end
