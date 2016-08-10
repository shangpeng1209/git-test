//
//  tableHeaderView.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/25.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tableHeaderViewDelegate <NSObject>

-(void)senderDictionary:(NSDictionary *)value;

@end


typedef void (^buttonClicked)(UIButton *);


@interface tableHeaderView : UIView
@property (nonatomic, strong) NSDictionary *FinancyDic;
@property (copy)buttonClicked btnClick;

-(void)loadRequest;

@end
