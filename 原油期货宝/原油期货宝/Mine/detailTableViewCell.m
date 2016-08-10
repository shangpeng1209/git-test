//
//  detailTableViewCell.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/22.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#define textFont 12

#import "detailTableViewCell.h"


@interface detailTableViewCell ()
{

    UILabel * _timeLable;
    UILabel * _introLable;
    UILabel * _curflowAmt;
}

@end


@implementation detailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadUI];
        
    }
    
    
    return self;
}



-(void)loadUI{

    UILabel * timeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth/3, 50)];
    timeLable.font = [UIFont systemFontOfSize:textFont];
    timeLable.numberOfLines =2;
    timeLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:timeLable];
    _timeLable = timeLable;
    
    
    UILabel * introLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLable.current_x_w, 0, timeLable.current_w, 50)];
    introLable.textAlignment = NSTextAlignmentCenter;

    introLable.font = [UIFont systemFontOfSize:textFont];

    [self.contentView addSubview:introLable];
    _introLable = introLable;
    
    UILabel * curflowAmt = [[UILabel alloc]initWithFrame:CGRectMake(introLable.current_x_w, 0, introLable.current_w, 50)];
    curflowAmt.font = [UIFont systemFontOfSize:textFont];
    curflowAmt.textAlignment = NSTextAlignmentCenter;

    [self.contentView addSubview:curflowAmt];
    _curflowAmt = curflowAmt;
    //237
    UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, timeLable.current_y_h-1, ScreenWidth, 1)];
    lineLable.backgroundColor = RGBA(237, 237, 237, 1);
    
    [self.contentView addSubview:lineLable];
    
    
    
    
    self.height = timeLable.current_y_h;

    
    
}

-(void)setCellWithDictionary:(NSDictionary *)dic{

    NSString * time = dic[@"createDate"];
    
    if (![dic[@"createDate"] isKindOfClass:[NSNull class]]) {
        time =[time stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
        _timeLable.text = time;

    }
    
    
    
    NSString * curflow ;// = dic[@"curflowAmt"];
    
    if (![dic[@"type"] isKindOfClass:[NSNull class]] && ![dic[@"curflowAmt"] isKindOfClass:[NSNull class]]) {
        if ([dic[@"type"]floatValue]>0) {
            
            curflow = dic[@"curflowAmt"];
            _curflowAmt.textColor = RGBA(234, 65, 44, 1);

        }else{
            
            curflow = [NSString stringWithFormat:@"-%@",dic[@"curflowAmt"]];
            _curflowAmt.textColor = RGBA(59, 131, 103, 1);
        }
        
        
        _curflowAmt.text = curflow;
        
    }
    
    NSString * info =dic[@"intro"];
   
    if (![info isKindOfClass:[NSNull class]]) {
        
        _introLable.text = info;
        
    }
    


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
