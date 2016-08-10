//
//  positionTableViewCell.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/8.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "positionTableViewCell.h"

@interface positionTableViewCell ()
{
    //价格
    UILabel * _priceLable;
    int i;

}


@end



@implementation positionTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self loadUI];
    
    
    }
    return self;
}


-(void)loadUI{


    CGFloat leftSpace = ScreenWidth*15/375;
    //看多看空 0-看多 1- 看空
    UILabel * tradeLable = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, (ScreenWidth-leftSpace*2)/3, 43.5)];
    tradeLable.text = @"买涨";
    tradeLable.textColor = [UIColor colorWithHexString:@"#FB4B55"];
    tradeLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:tradeLable];
    
    //数量
    
    UILabel * numbersLable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*160/375, 0, (ScreenWidth-ScreenWidth*160/375)/3, 43.5)];
    numbersLable.font = [UIFont systemFontOfSize:14];
    numbersLable.text = @"1手";
    [self.contentView addSubview:numbersLable];

    //价格
    UILabel * priceLable = [[UILabel alloc]initWithFrame:CGRectMake(numbersLable.current_x_w, 0, ScreenWidth-numbersLable.current_x_w-leftSpace, 43.5)];
    //priceLable.text = @"1500";
    priceLable.font = [UIFont systemFontOfSize:9];

    priceLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:priceLable];
    _priceLable = priceLable;
    
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, tradeLable.current_y_h-1, ScreenWidth-2*leftSpace, 1)];
    
    line.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [self.contentView addSubview:line];
    
    //买入价
    UILabel * buyPrice = [[UILabel alloc]initWithFrame:CGRectMake(tradeLable.current_x, tradeLable.current_y_h+15, tradeLable.current_w, 12)];
    buyPrice.text = @"买入价  42.12";
    buyPrice.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:buyPrice];
    
    //止盈
    UILabel * stopProfitLable = [[UILabel alloc]initWithFrame:CGRectMake(numbersLable.current_x, buyPrice.current_y, buyPrice.current_w, buyPrice.current_h)];
    stopProfitLable.text = @"止盈价  1800美元";
    stopProfitLable.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:stopProfitLable];
    
    
    //z最新价
    
    UILabel * newLable = [[UILabel alloc]initWithFrame:CGRectMake(buyPrice.current_x, buyPrice.current_y_h+6 ,buyPrice.current_y_h+6, buyPrice.current_h)];
    newLable.text = @"最新价  42.12";
    newLable.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:newLable];

    
    //止损价
    UILabel * stopLossLable = [[UILabel alloc]initWithFrame:CGRectMake(stopProfitLable.current_x, stopProfitLable.current_y_h+6, stopProfitLable.current_w, stopProfitLable.current_h)];
    stopLossLable.text = @"止损价  108美元";
    stopLossLable.font = [UIFont systemFontOfSize:11];

    [self.contentView addSubview:stopLossLable];

    
    
    //平仓键
    UIButton * saleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth -leftSpace -ScreenWidth*61.0f/375, buyPrice.current_y, ScreenWidth*61.0f/375, 30)];
    [saleButton setTitle:@"平仓" forState:UIControlStateNormal];
    [saleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    saleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [saleButton.layer setMasksToBounds:YES];
    [saleButton.layer setCornerRadius:4.0];
    
    saleButton.layer.borderWidth = 1;//边框宽度
    //refreshBtn.layer.borderColor = [[UIColor colorWithRed:0.92 green:0.05 blue:0.07 alpha:1] CGColor];//边框颜色
    saleButton.layer.borderColor = [UIColor blueColor].CGColor;//边框颜色
    
    [self.contentView addSubview:saleButton];

    
    
//    i=1000;
//    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    
    
    NSString * currentStr=@"+2000 (14000元)";
    
    NSRange  range = [currentStr rangeOfString:@"("];
    
    NSRange range1 = {0,range.location};
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:currentStr];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:14.0]
     
                          range:range1];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:range1];
    
    priceLable.attributedText = AttributedStr;
    

}
-(void)onTimer{

    NSString * currentStr=@"+2000 (14000元)";
    currentStr= [NSString stringWithFormat:@"%d (%d)",i,i*7];
    NSRange  range = [currentStr rangeOfString:@"("];
    
    NSRange range1 = {0,range.location};
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:currentStr];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:16.0]
     
                          range:range1];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:range1];
    
    _priceLable.attributedText = AttributedStr;

    i=i+1000;
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
