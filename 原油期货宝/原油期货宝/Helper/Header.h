//
//  Header.h
//  微油宝
//
//  Created by 尚朋 on 16/5/27.
//  Copyright © 2016年 shang. All rights reserved.
//

#ifndef Header_h
#define Header_h



#pragma mark -- 网址 url
/**
 * 当前域名
 */
#define  RootUrl @"www.jnhyxx.com"

/**
 *  域名格式 http协议  后期会改成https
 */
#define  W_URL  [NSString stringWithFormat:@"http://%@",RootUrl]
















#pragma mark -- 用户信息存储
#define  User_token  @"usertoken"
#define  User_name  @"user_name"
#define  User_pw    @"user_passWord"
#define  User_tele  @"user_tel"

#define uFirstOpenClearLoginInfo    @"uFirstOpenClearLoginInfo"




#pragma mark -- 常量

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height




#pragma mark -- 颜色管理

#define CanSelectButBackColor [UIColor colorWithHexString:@"fa4300"]
#define UnSelectButBackColor [UIColor colorWithHexString:@"6e6e6e"]

#define MAINTEXTCOLOR [UIColor colorWithHexString:@"373635"]
#define SUBTEXTCOLOR [UIColor colorWithHexString:@"999999"]

//金色
#define Color_Gold [UIColor colorWithRed:234/255.0 green:194/255.0 blue:129/255.0 alpha:1]

//黑色
#define Color_black [UIColor colorWithRed:22/255.0 green:22/255.0 blue:24/255.0 alpha:1]

//深空灰
#define Color_grayDeep [UIColor colorWithRed:38/255.0 green:37/255.0 blue:42/255.0 alpha:1]

//绿色
#define Color_green [UIColor colorWithRed:0/255.0 green:166/255.0 blue:120/255.0 alpha:1]

//红色
//导航红
#define Color_red [UIColor colorWithRed:200/255.0 green:50/255.0 blue:30/255.0 alpha:1]
//普通红
#define Color_subRed [UIColor colorWithRed:232/255.0 green:43/255.0 blue:0/255.0 alpha:1]

//灰色
#define Color_gray [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1]

//持仓内页偏粉红
#define Color_red_pink [UIColor colorWithRed:236/255.0 green:10/255.0 blue:45/255.0 alpha:1]

//白色
#define Color_white [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1]

//行情改版 line
#define Color_line [UIColor colorWithRed:55/255.0 green:54/255.0 blue:59/255.0 alpha:1]

//登录黄
#define Color_loginYellow [UIColor colorWithRed:255.0/255.0 green:157.0/255.0 blue:0/255.0 alpha:1]

//注册红
#define Color_registeRed   [UIColor colorWithRed:255.0/255.0 green:8.0/255.0 blue:27.0/255.0 alpha:1]
//RGBA
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]









#pragma mark -- 单例

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}







#endif /* Header_h */
