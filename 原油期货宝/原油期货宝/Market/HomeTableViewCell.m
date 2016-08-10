//
//  HomeTableViewCell.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/4.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "HomeTableViewCell.h"

typedef NS_ENUM(NSInteger,positionType) {
    
    positionTypeDefault ,//默认状态不显示
    positionTypeRed ,// 持仓中
    positionTypeGray ,//休市
    
};


@interface HomeTableViewCell ()
{
    UILabel * _categoryName;
    UIImageView * _hotImage;
    UILabel * _position;
    UILabel * _advertisementLable;
    UILabel * _percentageLable;
    UILabel * _lastPriceLable;
    UILabel * _hughState;
    UIColor * currentColor;//当前涨跌颜色
    positionType currentType;
    
    BOOL isClosed;
    
    //左间距
    CGFloat leftSpace;
    CGFloat rightSpace;
    
    
}




@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        if (ScreenWidth > 320) {
            leftSpace = 20;
            rightSpace = 20;
            
        }else{
        
            leftSpace = 10;
            rightSpace = 10;
        }
        
        
        
        
        [self loadContentView];
    }
    
    
    return self;
}


-(void)loadContentView{

    //期货名称
    UILabel * categoryName = [[UILabel alloc]init];
    categoryName.font = [UIFont systemFontOfSize:15];
    categoryName.textColor = [UIColor colorWithHexString:@"#262626"];
    _categoryName = categoryName;
    [self.contentView addSubview:categoryName];
   
    
    
    
    //种类简介
    UILabel * advertisementLable = [[UILabel alloc]init];
    advertisementLable.font = [UIFont systemFontOfSize:12];
    advertisementLable.textColor = [UIColor colorWithHexString:@"#A8A8A8"];
    _advertisementLable = advertisementLable;
    [self.contentView addSubview:advertisementLable];
    
    
    
    //涨跌幅
    UILabel * percentageLable = [[UILabel alloc]init];
    percentageLable.textColor = [UIColor whiteColor];
    [percentageLable.layer setMasksToBounds:YES];
    [percentageLable.layer setCornerRadius:2.0];
    
   
    _percentageLable = percentageLable;
    percentageLable.backgroundColor = [UIColor colorWithHexString:@"#fb4b55"];

    
    [self.contentView addSubview:percentageLable];
    
    
    
    //最后价格
    UILabel * lastPriceLable = [[UILabel alloc]init];
    lastPriceLable.textColor = [UIColor colorWithHexString:@"#25d282"];
    _lastPriceLable = lastPriceLable;
    //休市状态下 不显示涨跌 和 价格
    
    UILabel * hughState = [[UILabel alloc]init];
    hughState.textAlignment = NSTextAlignmentRight;
    hughState.font = [UIFont systemFontOfSize:14];
    hughState.textColor = [UIColor colorWithHexString:@"#262626"];
    hughState.textColor = RGBA(38, 38, 38, 0.5f);
    
    _hughState = hughState;
    
    
    
    //测试
    _categoryName.text = @"美原油";
    _advertisementLable.text = @"最热品种，980元做一手";
    _percentageLable.text = @"--";
    _lastPriceLable.text = @"--";
    _lastPriceLable.font = [UIFont systemFontOfSize:15];
    _percentageLable.font = [UIFont systemFontOfSize:12];
    _percentageLable.textAlignment = NSTextAlignmentCenter;
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
   
    
    
    
 /*
    // 创建一个富文本
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] init];
    

    //  添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"content_icon_down"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, -2, 11, 11);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string];
    

    
    
    NSAttributedString * text = [[NSAttributedString alloc]initWithString:_percentageLable.text];
    
    [attri appendAttributedString:text];

    // 用label的attributedText属性来使用富文本
    _percentageLable.attributedText = attri;

   // [_percentageLable setInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
   // _percentageLable.alignmentRectInsets =UIEdgeInsetsMake(0, 5, 0, 5);
*/
}





-(void)setCellWithModel:(homeModel *)model{

    _categoryName.text = model.commodityName;
    
    _advertisementLable.text =model.advertisement;
    
    CGFloat width = [Helper calculateTheHightOfText:_categoryName.text height:15 font:[UIFont systemFontOfSize:16]];
    
    _categoryName.frame = CGRectMake(leftSpace, 15, width, 16);
    
    
    
    [self hotImageHidden:NO ];
    
    
    

    
    _advertisementLable.frame = CGRectMake(_categoryName.current_x, _categoryName.current_y_h+8, (ScreenWidth-25)/2, 15);
    
    _hotImage.frame = CGRectMake(_categoryName.current_x_w+8, _categoryName.current_y, 12, 12);
    
    //model.marketStatus 0 休市 1 开市
    [self hughStateHiden:model.marketStatus withStrring:nil];
    
    
    if (model.marketStatus == 0) {
       
        
        
    }else{
   
        
    }
    
    

}



-(void)setLableAttributedStringWithStr:(NSString *)str{


    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] init];
    
    
    //
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 图片
    attch.image = [UIImage imageNamed:@"content_icon_time"];
    // 设置图片大小
    attch.bounds = CGRectMake(-5, -1.5f, 13, 13);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string];
    
    
    
    
    NSAttributedString * text = [[NSAttributedString alloc]initWithString:str];
    
    [attri appendAttributedString:text];
    
    // 用label的attributedText属性来使用富文本
    _hughState.attributedText = attri;
    // [_percentageLable setInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    // _percentageLable.alignmentRectInsets =UIEdgeInsetsMake(0, 5, 0, 5);


}




-(void)setCellPriceWithDic:(NSDictionary *)dic{

    NSNumber * lastPrice =dic[@"lastPrice"];//[Helper  translateStr:dic[@"lastPrice"]];
    NSString * percentage =dic[@"percentage"];
    
    //[Helper  translateStr:dic[@"percentage"]];
  //  _percentageLable.text = percentage;
    
   [self percentageLableAttributedStringWithStr:percentage];
    
    _lastPriceLable.text = [NSString stringWithFormat:@"%g",[lastPrice floatValue]];
    
    CGFloat percentWidth =[Helper calculateTheHightOfText:_lastPriceLable.text height:15 font:[UIFont systemFontOfSize:15]];
    
    _lastPriceLable.frame = CGRectMake(ScreenWidth-rightSpace-64-percentWidth-10, 22, percentWidth, 21);
    if ([percentage floatValue]>0) {
        //红色
        currentColor =[UIColor colorWithHexString:@"#fb4b55"];
        _percentageLable.backgroundColor = currentColor;
        
        _lastPriceLable.textColor = [UIColor colorWithHexString:@"#fb4b55"];

        
    }else{
    //绿色
        _lastPriceLable.textColor = [UIColor colorWithHexString:@"#25d282"];
       
        currentColor =[UIColor colorWithHexString:@"#25d282"];
        _percentageLable.backgroundColor = currentColor;

    
    }
    
    
    
    
    
    
    

}

#pragma mark -- 热度图片是否显示
-(void)hotImageHidden:(BOOL)hidden{

    if (hidden) {
        
        [_hotImage removeFromSuperview];
    }else{
        //热度图标
        UIImageView * hotImage = [[UIImageView alloc]init];
        [self.contentView addSubview:hotImage];
        
        _hotImage = hotImage;
        [_hotImage setImage:[UIImage imageNamed:@"content_icon_hot"]];
        
        _hotImage.frame = CGRectMake(_categoryName.current_x_w+8, 15, 12, 12);
    }
    
   
    

    
}


#pragma mark -- 休市时 右侧按钮是否显示以及显示内容
-(void)hughStateHiden:(BOOL)open withStrring:(NSString *)str{

    if (!open) {
        //休市
        //休市状态 富文本 右侧lable  左侧持仓中改为休市状态
        [self.contentView addSubview:_hughState];
        
        _hughState.frame = CGRectMake(_advertisementLable.current_x_w, 27, _advertisementLable.current_w, 26);
        [_percentageLable removeFromSuperview];
        [_lastPriceLable removeFromSuperview];
        
       // currentType = positionTypeGray;
        
        [self positionShowWithPositionType:positionTypeGray];
        
        
        [self setLableAttributedStringWithStr:@"9:15~晚间23:45"];
        
        
        
    }else{
    
        //开市
        // [_hughState removeFromSuperview];
        // _hughState=nil;
        //非休市状态
        [self.contentView addSubview:_lastPriceLable];
        [self.contentView addSubview:_percentageLable];
        
        [_hughState removeFromSuperview];
        _percentageLable.frame = CGRectMake(ScreenWidth-rightSpace-64, 22, 64, 21);
        
        [self positionShowWithPositionType:positionTypeDefault];

        
        
//        _position.textColor =[UIColor colorWithHexString:@"#fb4b55"];
//        _position.layer.borderWidth = 1;//边框宽度
//        //refreshBtn.layer.borderColor = [[UIColor colorWithRed:0.92 green:0.05 blue:0.07 alpha:1] CGColor];//边框颜色
//        _position.layer.borderColor = [UIColor colorWithHexString:@"#fb4b55"].CGColor;//边框颜色
//        
//        _hughState.text = @"";
//        _position.text = @"持仓中";
    
    
    
    }
    
    
    


}

//
#pragma mark == 持仓 休市状态切换
-(void)positionShowWithPositionType:(positionType)type{

    switch (type) {
        case positionTypeDefault:
        {
            [_position removeFromSuperview];
        }
            break;
           
        case positionTypeRed:
        {
            //持仓 提示
            UILabel * position = [[UILabel alloc]init];
            position.text = @"持仓中";
            
            position.layer.borderWidth = 1;//边框宽度
            position.layer.borderColor = [UIColor redColor].CGColor;//边框颜色
            position.textColor = [UIColor colorWithHexString:@"#fb4b55"];
            position.textAlignment = NSTextAlignmentCenter;
            position.font = [UIFont systemFontOfSize:8];
            _position = position;
            _position.frame = CGRectMake(_hotImage.current_x_w+10, _hotImage.current_y, 34, 13);

            [self.contentView addSubview:position];

        }
            break;
            
        case positionTypeGray:
        {
            //持仓 提示
            UILabel * position = [[UILabel alloc]init];
            
            
            position.layer.borderWidth = 1;//边框宽度
            //refreshBtn.layer.borderColor = [[UIColor colorWithRed:0.92 green:0.05 blue:0.07 alpha:1] CGColor];//边框颜色
            position.textAlignment = NSTextAlignmentCenter;
            position.font = [UIFont systemFontOfSize:8];
            _position = position;
            _position.frame = CGRectMake(_hotImage.current_x_w+10, _hotImage.current_y, 34, 13);
            _position.text=@"休市";
            _position.textColor =RGBA(128, 128, 128, 0.5f);
            _position.layer.borderWidth = 1;//边框宽度
            //refreshBtn.layer.borderColor = [[UIColor colorWithRed:0.92 green:0.05 blue:0.07 alpha:1] CGColor];//边框颜色
            _position.layer.borderColor = RGBA(128, 128, 128, 0.5f).CGColor;//边框颜色
            
            
            [self.contentView addSubview:position];

        }
            break;
        default:
            break;
    }
    
    


}

#pragma mark -- 涨跌幅富文本
-(void)percentageLableAttributedStringWithStr:(NSString *)str{
    //str = @"1";
    
     // 创建一个富文本
     NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] init];
     
     
     //  添加表情
     NSTextAttachment *attch = [[NSTextAttachment alloc] init];
     // 表情图片
    if ([str floatValue]>0) {
    attch.image = [UIImage imageNamed:@"content_icon_up"];

    }else{
    
    attch.image = [UIImage imageNamed:@"content_icon_down"];
    }
    
    
     // 设置图片大小
     attch.bounds = CGRectMake(-2, -1, 9, 11);
     
     // 创建带有图片的富文本
     NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
     [attri appendAttributedString:string];
     
     
     
     
     NSAttributedString * text = [[NSAttributedString alloc]initWithString:str];
     
     [attri appendAttributedString:text];
    _percentageLable.textAlignment = NSTextAlignmentCenter;
     // 用label的attributedText属性来使用富文本
     _percentageLable.attributedText = attri;
     
     // [_percentageLable setInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
     // _percentageLable.alignmentRectInsets =UIEdgeInsetsMake(0, 5, 0, 5);
     




}



- (void)prepareForReuse
{
    _position.text = nil;
    _hughState.text = nil;
    _hotImage.image = nil;
    [_position removeFromSuperview];
    currentType = positionTypeDefault;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _percentageLable.backgroundColor = currentColor;
    
    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{

    _percentageLable.backgroundColor = currentColor;


}
@end
