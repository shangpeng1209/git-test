//
//  SHPNetWorking.m
//  微油宝
//
//  Created by 尚朋 on 16/5/27.
//  Copyright © 2016年 shang. All rights reserved.
//

#import "SHPNetWorking.h"
#import "AFNetworking.h"
@implementation SHPNetWorking



+ (void)postRequestWithNSDictionary:(NSDictionary *)dic url:(NSString*)url successBlock:(void(^)(NSDictionary *dictionary))successBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSMutableSet *set=[NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    
    [set addObject:@"text/html"];
   
    //读取保存cookie
 /*   NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:RootURL]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"cookie"];
    */
  
    //设置cookie
    /*
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:UserToken];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }  
    }
    */
    manager.responseSerializer.acceptableContentTypes = set;
    manager.requestSerializer.timeoutInterval = 10;
    
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
        
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        
        
        
        if ([responseObject[@"code"]floatValue] == 406) {
            [[UIEngine sharedInstance] hideProgress];

            [[UIEngine sharedInstance] showAlertWithTitle:responseObject[@"msg"] ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            };
            
        }
        
        if ([responseObject[@"code"] floatValue] == 41022) {
            [[UIEngine sharedInstance] hideProgress];

            
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:LandAgain];
            

            
            [[UIEngine sharedInstance] showAlertWithTitle:@"您已在其他设备登录，请确认" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            //点解确认按钮，事件处理
                [[NSNotificationCenter defaultCenter]postNotificationName:tokenOverValue object:nil userInfo:nil];
            
            };
            
            
        }
        if ([responseObject[@"code"] floatValue] == 412) {
            
            //token无效
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:LandAgain];

            
            
        }
        
        
        
        
        
        
        successBlock(responseObject);

    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        [[UIEngine sharedInstance] hideProgress];

        [[NSNotificationCenter defaultCenter]postNotificationName:requestFaild object:nil userInfo:nil];

        
        
        

      
        
        
        
    }];
    
    
    
    
    
//    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        //token过期
//        if ([responseObject isKindOfClass:[NSMutableDictionary class]]) {
//            
//            if ([responseObject[@"code"] floatValue] == 41022) {
//                [[UIEngine sharedInstance] hideProgress];
//                
//                BOOL  isAgain = NO;
//                //存入token过期时间
//                NSUserDefaults  *userDefaults = [NSUserDefaults standardUserDefaults];
//                if ([userDefaults objectForKey:TokenChangeTime] == nil) {
//                    [userDefaults setObject:[NSNumber numberWithLongLong:[SystemSingleton sharedInstance].timeInterval] forKey:TokenChangeTime];
//                    [userDefaults synchronize];
//                    isAgain = YES;
//                }
//                //比对跑秒是否需要提示去登录
//                if ([[userDefaults objectForKey:TokenChangeTime] longLongValue] +20*1000 <= [SystemSingleton sharedInstance].timeInterval) {
//                    [userDefaults setObject:[NSNumber numberWithLongLong:[SystemSingleton sharedInstance].timeInterval] forKey:TokenChangeTime];
//                    [userDefaults synchronize];
//                    isAgain = YES;
//                }
//                
//                if (!isAgain) {
//                    return ;
//                }
//                if (![[CMStoreManager sharedInstance] isLogin]) {
//                    return;
//                }
//                NSString    *firstLoginStr = getUserDefaults(@"FirstLogin");
//                [[CMStoreManager sharedInstance] exitLoginClearUserData];
//                [[CMStoreManager sharedInstance] setbackgroundimage];
//                saveUserDefaults(firstLoginStr, @"FirstLogin");
//                
//                [[UIEngine sharedInstance] showAlertWithTitle:@"您已在其他设备登录，请确认" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
//                [UIEngine sharedInstance].alertClick = ^ (int aIndex){
//                    [[NSNotificationCenter defaultCenter] postNotificationName:uFirstOpenClearLoginInfo object:nil];
//                };
//                return ;
//            }
//            else if ([responseObject[@"code"] floatValue] == 412){
//                //                [[UIEngine sharedInstance] showAlertWithTitle:SpotLoginMessage ButtonNumber:2 FirstButtonTitle:@"取消" SecondButtonTitle:@"去开户"];
//                //                [UIEngine sharedInstance].alertClick = ^ (int aIndex){
//                //                    if (aIndex == 10087) {
//                //                        [[NSNotificationCenter defaultCenter] postNotificationName:uSpotgoodsLogin object:nil];
//                //                    }
//                //                };
//                //                return;
//            }
//        }
//        
//        successBlock(responseObject);
//        
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error);
//        //        [UIEngine showShadowPrompt:@"！您当前网络不佳，请稍后再试"];
//        [[UIEngine sharedInstance] hideProgress];
//    }];
}



//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

//Unicode转UTF-8

+ (NSString*) replaceUnicode:(NSString*)aUnicodeString

{
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                          mutabilityOption:NSPropertyListImmutable
                           
                                                                    format:NULL
                           
                                                          errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}





@end
