//
//  homeModel.h
//  原油期货宝
//
//  Created by 尚朋 on 16/8/4.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeModel : NSObject

@property (nonatomic, copy) NSString *currencyName;//种类名称

@property (nonatomic, assign) NSInteger decimalPlaces;

@property (nonatomic, assign) NSInteger isDoule;

@property (nonatomic, assign) NSInteger multiple;

@property (nonatomic, copy) NSString *currency;

@property (nonatomic, copy) NSString *commodityDesc;

@property (nonatomic, copy) NSString *currencyUnit;

@property (nonatomic, assign) NSInteger vendibility;

@property (nonatomic, assign) NSInteger timeTag;

@property (nonatomic, copy) NSString *commodityName;

@property (nonatomic, copy) NSString *marketCode;

@property (nonatomic, copy) NSString *currencySign;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) NSInteger marketId;

@property (nonatomic, copy) NSString *marketName;

@property (nonatomic, copy) NSString *imgs;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger baseline;

@property (nonatomic, copy) NSString *timeline;//交易时间段

@property (nonatomic, copy) NSString *loddyType;

@property (nonatomic, copy) NSString *accountCode;

@property (nonatomic, copy) NSString *timeAndNum;//交易时间和显示数量

@property (nonatomic, assign) NSInteger scale;

@property (nonatomic, copy) NSString *instrumentID;

@property (nonatomic, assign) CGFloat minPrice;

@property (nonatomic, copy) NSString *nightTimeAndNum;//晚上交易时间段

@property (nonatomic, copy) NSString *instrumentCode;

@property (nonatomic, copy) NSString *advertisement;//简介

@property (nonatomic, assign) NSInteger marketStatus;//交易所状态 0 休市 1 开市

@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, assign) CGFloat rate;

@end
