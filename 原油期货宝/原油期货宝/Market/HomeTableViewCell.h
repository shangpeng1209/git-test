//
//  HomeTableViewCell.h
//  原油期货宝
//
//  Created by 尚朋 on 16/8/4.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeModel.h"
@interface HomeTableViewCell : UITableViewCell




//视图
-(void)setCellWithModel:(homeModel *)model;
//涨跌幅
-(void)setCellPriceWithDic:(NSDictionary *)dic;



@end
