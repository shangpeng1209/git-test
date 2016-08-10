//
//  accountHomeView.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/20.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "accountHomeView.h"

@implementation accountHomeView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    
    return self;
}




-(void)loadUI{

    self.backgroundColor = [UIColor redColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-70.0/368.0*ScreenWidth)/2, 60.0/200.0*self.current_h,70.0/368.0*ScreenWidth,  70.0/368.0*ScreenWidth)];
    imageView.layer.cornerRadius = imageView.current_w/2;
    imageView.layer.masksToBounds = YES;
    imageView .backgroundColor = [UIColor yellowColor];
  //  _imageView = imageView;
   // [self addSubview:imageView];

   // NSLog(@"h = %f",backGrandView.current_h);
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80.0/200.0*self.current_h, self.current_w, 20)];
    
    lable.text = @"testtesttest";
    lable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:lable];
    
    UIButton * loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 120.0/200.0*self.current_h, (self.current_w-30*2 -15)/2, 50)];
    loginBtn.backgroundColor = [UIColor orangeColor];
    [loginBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.tag = 1000;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [self addSubview:loginBtn];
    
    
    UIButton * registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(loginBtn.current_x_w+15 , loginBtn.current_y, loginBtn.current_w, loginBtn.current_h)];
    registerBtn.backgroundColor = [UIColor orangeColor];
    [registerBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerBtn.tag =1001;
    
    [self addSubview:registerBtn];
    
    
    // 设置按钮
    UIButton * setBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-30, 30, 20, 20)];
    setBtn.tag = 1201;
    setBtn.backgroundColor = [UIColor blackColor];
    _setBtn = setBtn;
    [self addSubview:setBtn];
    
    

}


-(void)btnClicked:(UIButton *)sender{


    self.btnClick(sender);


}


@end
