//
//  UserDefaults.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#ifndef UserDefaults_h
#define UserDefaults_h

//存储到userdefault 信息

//会话标识
#define UserToken @"userToken"
//用户的唯一标识
#define UserSecret @"userSecret"
//用户所有信息
#define UserInfo @"userInformation"
//token过期时间
#define TokenChangeTime @"tokenChange"
//电话
#define TelNum @"tellNumber"
//是否需要重新登录 YES 重新登录  NO 不需   nil/@“”重新登录
#define LandAgain @"landAgain"
//是否加载失败 保存到本地
#define isFaild @"boolFaild"



//token过期发送通知，各个页面根据需求来做判断
#define tokenOverValue @"overValue"

//网络请求失败 发送通知
#define requestFaild @"requestFaild"
//请求成功，发送通知，以便事件处理
#define requestSuccess @"requestSuccess"





#endif /* UserDefaults_h */
