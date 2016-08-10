//
//  HeadPortraitView.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "HeadPortraitView.h"

@interface HeadPortraitView ()
{

    UIView * _backView;
    UIImageView * _QRImageView;
    
}


@end

@implementation HeadPortraitView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    
    return self;
}



-(void)loadUI{

    
    
    self.backgroundColor = [UIColor colorWithHexString:@"#0e2947"];
    
    
    //NSLog(@"screen = %lf",ScreenWidth);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-70.0/368.0*ScreenWidth)/2, 60.0/200.0*self.current_h,70.0/368.0*ScreenWidth,  70.0/368.0*ScreenWidth)];
    imageView.layer.cornerRadius = imageView.current_w/2;
    imageView.layer.masksToBounds = YES;
    imageView .backgroundColor = [UIColor whiteColor];
    imageView.userInteractionEnabled = YES;
    
    _imageView = imageView;
    
    
    
    imageView.layer.borderWidth = 2;//边框宽度
    //refreshBtn.layer.borderColor = [[UIColor colorWithRed:0.92 green:0.05 blue:0.07 alpha:1] CGColor];//边框颜色
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;//边框颜色
    
    [self addSubview:imageView];
    
    CGFloat interval;
    if (ScreenHeigth >481) {
        interval =18;
    }else{
        interval =8;

    }
    


    UILabel * userNameLable = [[UILabel alloc]initWithFrame:CGRectMake(60, imageView.current_y_h+interval, self.current_w-120, 10)];
    userNameLable.textAlignment = NSTextAlignmentCenter;
    userNameLable.textColor = [UIColor whiteColor];
    userNameLable.font = [UIFont systemFontOfSize:14];

    _userNameLable = userNameLable;
    [self addSubview:userNameLable];
    
    UILabel * autograph = [[UILabel alloc]initWithFrame:CGRectMake(60, userNameLable.current_y_h+interval, userNameLable.current_w, 8)];
    autograph.textAlignment = NSTextAlignmentCenter;
    autograph.textColor = [UIColor whiteColor];
    autograph.font = [UIFont systemFontOfSize:12];
    [self addSubview:autograph];
    _autograph = autograph;
    
    //二维码按钮
    UIButton * QRBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 20, 20)];
    [QRBtn addTarget:self action:@selector(QRBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    QRBtn.backgroundColor = [UIColor blackColor];
    [self addSubview:QRBtn];
    
    
    
    // 设置按钮
    UIButton * setBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-30, 30, 20, 20)];
    setBtn.tag = 1202;
    setBtn.backgroundColor = [UIColor blackColor];
    _setBtn = setBtn;
    [self addSubview:setBtn];
    
    //添加点击事件
    UITapGestureRecognizer*tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
    //设定点击次数
    tgr.numberOfTapsRequired=1;
    
    [imageView addGestureRecognizer:tgr];

}

-(void)Tap:(id)sender{

    [self.delegate headPortraitViewTap];

}


-(void)setViewWithDic:(NSDictionary *)value{

  
        if (value) {
            NSString * path = value[@"data"][@"userInfo"][@"head_pic"];
            
            if ( [Helper translateStr:path].length>0) {
            [_imageView sd_setImageWithURL:[NSURL URLWithString:path]];

            }
            
            NSString * userName =value[@"data"][@"userInfo"][@"nick"];
            
            if ([Helper translateStr:userName].length>0) {
                _userNameLable.text =value[@"data"][@"userInfo"][@"nick"] ;

            }else{
            

            }
           NSString * persion_sign = value[@"data"][@"userInfo"][@"person_sign"];
            
            
            if ([Helper translateStr:persion_sign].length>0 ) {
                
           // _autograph.text =value[@"data"][@"userInfo"][@"person_sign"];
                _autograph.text = @"编辑个性签名";


            }else{
                //_autograph.text = @"编辑个性签名编辑个性签名编辑个性签名编辑个性签名编辑个性签名编辑个性签名编辑个性签名编辑个性签名编辑个性签名编辑个性签名编辑个性签名";
            _autograph.text = @"编辑个性签名";

            }
            
        }
}


-(void)QRBtnClicked:(UIButton *)sneder{


    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSArray * array = [[UIApplication sharedApplication] windows];
    
    if (array.count >= 2) {
        
        window = [array objectAtIndex:1];
        
    }
    
    UIView * backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.7;
    
    [window addSubview:backView];
    _backView = backView;
    
    //添加点击事件
    UITapGestureRecognizer*tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearWidow:)];
    //设定点击次数
    tgr.numberOfTapsRequired=1;
    
    [backView addGestureRecognizer:tgr];
    
    UIImageView * QRImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-40, ScreenWidth-40)];
    QRImageView.center = window.center;
    [QRImageView.layer setMasksToBounds:YES];
    [QRImageView.layer setCornerRadius:6.0];
    
    
    
    [QRImageView sd_setImageWithURL:[NSURL URLWithString:@"http://qr.liantu.com/api.php?text=http://www.jnhyxx.com/?abc=9a353e"]];
    QRImageView.userInteractionEnabled = YES;

    [window addSubview:QRImageView];
    
    _QRImageView = QRImageView;
    
    UILongPressGestureRecognizer *longPressGR =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleLongPress:)];
    longPressGR.allowableMovement=NO;
    longPressGR.minimumPressDuration = 1;
    [QRImageView addGestureRecognizer:longPressGR];

}

-(void)clearWidow:(UITapGestureRecognizer *)sender{

    [_backView removeFromSuperview];
    [_QRImageView removeFromSuperview];

}


-(void)handleLongPress:(UILongPressGestureRecognizer *)sender{

    NSLog(@"二维码");


}

@end
