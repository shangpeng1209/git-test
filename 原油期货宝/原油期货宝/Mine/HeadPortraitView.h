//
//  HeadPortraitView.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HeadPortraitViewDelegate <NSObject>

-(void)headPortraitViewTap;


@end


@interface HeadPortraitView : UIView

@property (nonatomic, assign)  id<HeadPortraitViewDelegate>delegate;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * userNameLable;
@property (nonatomic, strong) UILabel * autograph;
@property (nonatomic, strong) UIButton * setBtn;



-(void)setViewWithDic:(NSDictionary *)value;


@end
