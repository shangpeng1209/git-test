//
//  settelementTableViewCell.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/9.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "settelementTableViewCell.h"

@implementation settelementTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadUI];
        
        
    }
    return self;
}

-(void)loadUI{

    //时间
    UILabel * timeLable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth* 15/375, 10, ScreenWidth*77/375 -ScreenWidth* 15/375 , 40)];
    timeLable.font = [UIFont systemFontOfSize:14];
    timeLable.numberOfLines=0;
    [self.contentView addSubview:timeLable];
    
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(timeLable.current_x_w-1, 5, 1, 45)];
    line.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [self.contentView addSubview:line];
    
    
    
    //买跌买涨
    UILabel * tradeLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLable.current_x_w + 20*ScreenWidth/375, 15, ScreenWidth*41/375, 25)];
    tradeLable.font = [UIFont systemFontOfSize:12];
    tradeLable.backgroundColor = [UIColor redColor];
    tradeLable.textAlignment = NSTextAlignmentCenter;
    [tradeLable.layer setMasksToBounds:YES];
    [tradeLable.layer setCornerRadius:2.0];
    
    
    tradeLable.textColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.contentView addSubview:tradeLable];
    
    //描述
    UILabel * describeLable = [[UILabel alloc]initWithFrame:CGRectMake(tradeLable.current_x_w+30*ScreenWidth/375, 15, 60, 25)];
    describeLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:describeLable];
    
    //盈亏
    
    UILabel * settle = [[UILabel alloc]initWithFrame:CGRectMake(describeLable.current_x_w,  27/2, ScreenWidth- describeLable.current_x_w -ScreenWidth* 15/375, 14)];
    settle.font = [UIFont systemFontOfSize:14];
    settle.textColor = [UIColor redColor];
    settle.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:settle];
    
    //外汇转人民币
    UILabel * rmbLable = [[UILabel alloc]initWithFrame:CGRectMake(settle.current_x, settle.current_y_h+5,settle.current_w, 9)];
    rmbLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:rmbLable];
    rmbLable.font = [UIFont systemFontOfSize:9];
    
    timeLable.text = @"07/28\n10:24";
    
    
    
    tradeLable.text = @"买涨";
    describeLable.text = @"止盈卖出";
    settle.text = @"+1820美元";
    rmbLable.text = @"(132元)";
    
    
    NSString * currentStr=@"07/28\n10:24";
    
    NSRange  range = [currentStr rangeOfString:@"("];
    
    NSRange range1 = {0,5};
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:currentStr];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:9.0]
     
                          range:range1];
    
    //[AttributedStr addAttribute:NSForegroundColorAttributeName
     
//                          value:[UIColor redColor]
//     
//                          range:range1];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];

   // [AttributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, 5)];

    
    timeLable.attributedText = AttributedStr;
    
    
    
}






- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
