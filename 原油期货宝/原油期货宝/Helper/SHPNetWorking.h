//
//  SHPNetWorking.h
//  微油宝
//
//  Created by 尚朋 on 16/5/27.
//  Copyright © 2016年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHPNetWorking : NSObject

+ (void)postRequestWithNSDictionary:(NSDictionary *)dic url:(NSString*)url successBlock:(void(^)(NSDictionary *dictionary))successBlock failureBlock:(void(^)(NSError *error))failureBlock;

/**判断手机号码格式是否正确*/
+ (BOOL)valiMobile:(NSString *)mobile;

+ (NSString*)replaceUnicode:(NSString*)aUnicodeString;

@end
