//
//  detailTableViewCell.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/22.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface detailTableViewCell : UITableViewCell
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UILabel * introLable;
@property (nonatomic, strong) UILabel * curflowAmt;


-(void)setCellWithDictionary:(NSDictionary *)dic;

@end
