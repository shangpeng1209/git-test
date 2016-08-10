//
//  Alert.m
//  hs
//
//  Created by RGZ on 15/12/17.
//  Copyright © 2015年 luckin. All rights reserved.
//

#import "Alert.h"

@implementation Alert
{
    UIView  *_coverView;
    UIView  *_alertView;
    UILabel *_linelab;
    
    int     buttonNum;
    int     font;
    
    NSString    *firstTitle;
    NSString    *secondTitle;
    
    NSString    *message;
    
    AlertType   alertType;
    AlertErrorType  alertErrorTyle;
    NSString        *errorMessage;
    NSString        *errorMoney;
    NSString        *errorIntegral;
    NSString        *errorMoneyUnit;
    NSString        *errorTitleMessage;
}

-(instancetype)initWithButtonNum:(int)aButtonNum
                      FirstTitle:(NSString *)aFirstTitle
                     SecondTitle:(NSString *)aSecondTitle
                         Message:(NSString *)aMessage
                       AlertType:(AlertType)aAlertTyle
                  AlertErrorType:(AlertErrorType)anAlertErrorType//行情异常所需
               ErrorTitleMessage:(NSString *)aErrorTitleMessage//行情异常标题信息
                    ErrorMessage:(NSString *)aErrorMessage//行情异常信息
                      ErrorMoney:(NSString *)aErrorMoney//行情异常金额
                   ErrorIntegral:(NSString *)aErrorIntegral//行情异常积分
                  ErrorMoneyUnit:(NSString *)aErrorMoneyUnit//行情异常金额单位（元，美元）
{
    self = [super init];
    if (self) {
        self.backgroundColor    = [UIColor clearColor];
        self.frame              = CGRectMake(0, 0, ScreenWidth, ScreenHeigth);
        buttonNum               = aButtonNum;
        firstTitle              = aFirstTitle;
        secondTitle             = aSecondTitle;
        message                 = aMessage;
        alertType               = aAlertTyle;
        alertErrorTyle          = anAlertErrorType;
        errorMessage            = aErrorMessage;
        errorMoney              = aErrorMoney;
        errorIntegral           = aErrorIntegral;
        errorMoneyUnit          = aErrorMoneyUnit;
        errorTitleMessage       = aErrorTitleMessage;
        
        [self fontConfiger];
        [self loadUI];
        switch (alertType) {
            case AlertCommon:
                [self commonAlert];
                break;
            case AlertError:
                [self errorAlert];
                break;
            default:
                break;
        }
    }
    
    return self;
}

-(void)loadUI{
    
    
    _coverView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
    _coverView.backgroundColor=[UIColor blackColor];
    _coverView.alpha=0.7;
    [self addSubview:_coverView];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _coverView.bounds.size.width-60, ScreenHeigth/4-5-40)];
    _alertView.center=CGPointMake(ScreenWidth/2, ScreenHeigth/2-30);
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 8;
    _alertView.alpha=1;
    _alertView.layer.masksToBounds = YES;
    
    _linelab = [[UILabel alloc] initWithFrame:CGRectMake(0, _alertView.frame.size.height+_alertView.frame.origin.y-20, _alertView.bounds.size.width, 20+40)];
    _linelab.center = CGPointMake(ScreenWidth/2, _linelab.center.y);
    _linelab.backgroundColor = CanSelectButBackColor;
    _linelab.layer.cornerRadius = 8;
    _linelab.clipsToBounds = YES;
    _linelab.userInteractionEnabled = YES;
    [self addSubview:_linelab];
    
    if (buttonNum == 1) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 20, _alertView.frame.size.width, 40);
        button.backgroundColor=[UIColor clearColor];
        button.tag=10086;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:firstTitle forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:font];
        [button addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
        [_linelab addSubview:button];
    }
    else if (buttonNum == 2){
        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        leftButton.frame =CGRectMake(0, 20, _alertView.frame.size.width/2, 40);
        leftButton.tag = 10086;
        leftButton.backgroundColor = [UIColor clearColor];
        leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftButton setTitle:firstTitle forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
        [_linelab addSubview:leftButton];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(_alertView.frame.size.width/2-1, 20, 1, 40)];
        lineView.backgroundColor=RGBACOLOR(210, 0, 11, 1);
        lineView.alpha=0.5;
        [_linelab addSubview:lineView];
        
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        rightButton.frame =CGRectMake(_alertView.frame.size.width/2, 20, _alertView.bounds.size.width/2, 40);
        rightButton.tag = 10087;
        rightButton.backgroundColor =[UIColor clearColor];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [rightButton setTitle:secondTitle forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
        [_linelab addSubview:rightButton];
    }
    [self addSubview:_alertView];
}

-(void)alertClick:(UIButton *)btn{
    self.alertClick(btn);
    [self removeFromSuperview];
}

-(void)fontConfiger{
    font=0;
    if (ScreenHeigth==480) {
        font=14;
    }
    else if (ScreenHeigth==568)
    {
        font=15;
    }
    else if (ScreenHeigth==667)
    {
        font=15;
    }
    else if (ScreenHeigth==736)
    {
        font=16;
    }
}

#pragma mark 普通

-(void)commonAlert{
    UILabel * infolab       = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, _alertView.bounds.size.width-17*2, _alertView.frame.size.height/3*2)];
    infolab.numberOfLines   = 0;
    infolab.center          = CGPointMake(_alertView.bounds.size.width/2, _alertView.bounds.size.height/2);
    infolab.textAlignment   = NSTextAlignmentCenter;
    infolab.font            = [UIFont systemFontOfSize:font];
    infolab.backgroundColor = [UIColor clearColor];
    infolab.text            = message;
    infolab.textColor       = [UIColor blackColor];
    [_alertView addSubview:infolab];
    
    float messageHeight = [DataUsedEngine getStringRectWithString:message Font:font Width:infolab.frame.size.width+8 Height:MAXFLOAT].height;
    if (messageHeight > infolab.frame.size.height) {
        _alertView.frame = CGRectMake(_alertView.frame.origin.x, _alertView.frame.origin.y, _alertView.frame.size.width, _alertView.frame.size.height + (messageHeight - infolab.frame.size.height));
        _alertView.center=CGPointMake(ScreenWidth/2, ScreenHeigth/2-30);
        infolab.frame = CGRectMake(infolab.frame.origin.x, infolab.frame.origin.y, infolab.frame.size.width, messageHeight);
        _linelab.frame = CGRectMake(_linelab.frame.origin.x, _alertView.frame.size.height+_alertView.frame.origin.y-20, _alertView.bounds.size.width, 20+40);
    }
}

#pragma mark 行情异常弹窗

-(void)errorAlert{
    _alertView.frame = CGRectMake(_alertView.frame.origin.x, _alertView.frame.origin.y, _alertView.frame.size.width, _alertView.frame.size.height + 30/667.0*ScreenHeigth);
    _alertView.center=CGPointMake(ScreenWidth/2, ScreenHeigth/2-30);
    _linelab.frame = CGRectMake(_linelab.frame.origin.x, _alertView.frame.size.height+_alertView.frame.origin.y-20, _alertView.bounds.size.width, 20+40);
    
    UIImageView *errorImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (68.0 * ((77.0/2.5)/667*ScreenHeigth)) / 77, (77.0/2.5)/667*ScreenHeigth)];
    errorImage.center = CGPointMake(_alertView.frame.size.width/2, 20/667.0*ScreenHeigth+errorImage.frame.size.height/2);
    errorImage.image = [UIImage imageNamed:@"error_image"];
    [_alertView addSubview:errorImage];
    
    UILabel     *redLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, errorImage.frame.origin.y + errorImage.frame.size.height + 10/667.0*ScreenHeigth, _alertView.frame.size.width, 20/667.0*ScreenHeigth)];
    redLabel.font = [UIFont systemFontOfSize:font+1];
    redLabel.textColor = [UIColor redColor];
    redLabel.numberOfLines = 0;
    redLabel.textAlignment = NSTextAlignmentCenter;
    redLabel.text = errorTitleMessage;
    [_alertView addSubview:redLabel];
    
    if (ScreenHeigth <= 480) {
        _linelab.frame = CGRectMake(_linelab.frame.origin.x, _linelab.frame.origin.y + 10, _linelab.frame.size.width, _linelab.frame.size.height);
    }
    else if (ScreenHeigth <= 568 && ScreenHeigth > 480){
        _linelab.frame = CGRectMake(_linelab.frame.origin.x, _linelab.frame.origin.y + 5, _linelab.frame.size.width, _linelab.frame.size.height);
    }
    
    switch (alertErrorTyle) {
        case AlertErrorTypeOrder:
            [self errorTypeOrder:redLabel];
            break;
        case AlertErrorTypeSelling:
            [self errorTypeSelling:redLabel];
            break;
            
        default:
            break;
    }
}

-(void)errorTypeOrder:(UILabel *)redLabel{
    UILabel     *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20/375.0*ScreenWidth, redLabel.frame.origin.y + redLabel.frame.size.height + 10/667.0*ScreenHeigth, _alertView.frame.size.width - 20/375.0*ScreenWidth*2, 42/667.0*ScreenHeigth)];
    messageLabel.text = errorMessage;
    messageLabel.font = [UIFont systemFontOfSize:font-1];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    [_alertView addSubview:messageLabel];
    
    if (ScreenHeigth <= 480) {
        messageLabel.bounds = CGRectMake(0, 0, messageLabel.frame.size.width, messageLabel.frame.size.height + 20);
        _alertView.bounds = CGRectMake(0, 0, _alertView.frame.size.width, _alertView.frame.size.height + 20);
    }
    else if (ScreenHeigth <= 568 && ScreenHeigth > 480){
        messageLabel.bounds = CGRectMake(0, 0, messageLabel.frame.size.width, messageLabel.frame.size.height + 10);
        _alertView.bounds = CGRectMake(0, 0, _alertView.frame.size.width, _alertView.frame.size.height + 10);
    }
}

-(void)errorTypeSelling:(UILabel *)redLabel{
    
    if (errorMoneyUnit == nil || [errorMoneyUnit isEqualToString:@""]) errorMoneyUnit = @"元";
    if ([errorMoney isEqualToString:@""]) errorMoney = nil;
    if ([errorIntegral isEqualToString:@""]) errorIntegral = nil;
    
    UILabel     *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20/375.0*ScreenWidth, redLabel.frame.origin.y + redLabel.frame.size.height + 10/667.0*ScreenHeigth, _alertView.frame.size.width - 20/375.0*ScreenWidth*2, 42/667.0*ScreenHeigth)];
    messageLabel.font = [UIFont systemFontOfSize:font-1];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    [_alertView addSubview:messageLabel];
    
    if ((errorMoney != nil && ![errorMoney isKindOfClass:[NSNull class]]) && (errorIntegral != nil && ![errorIntegral isKindOfClass:[NSNull class]])) {
        messageLabel.center = CGPointMake(messageLabel.center.x, messageLabel.center.y - 8);
        messageLabel.text = [NSString stringWithFormat:@"%@",errorMessage];
        
        for (int i = 0; i < 2; i++) {
            UILabel     *incomeLabel = [[UILabel alloc]init];
            incomeLabel.font = [UIFont systemFontOfSize:font-1];
            incomeLabel.textAlignment = NSTextAlignmentCenter;
            incomeLabel.numberOfLines = 0;
            [_alertView addSubview:incomeLabel];
            if (i == 0) {
                incomeLabel.frame = CGRectMake(0, messageLabel.frame.origin.y + messageLabel.frame.size.height - 15/667.0*ScreenHeigth, _alertView.frame.size.width/2/8*7, 42/667.0*ScreenHeigth);
                NSString    *sign = @"+";
                UIColor     *color = Color_red;
                if ([errorMoney floatValue] < 0) {
                    sign = @"";
                    color = Color_green;
                }
                incomeLabel.textAlignment = NSTextAlignmentRight;
                incomeLabel.text = [NSString stringWithFormat:@"%@%@%@",sign,errorMoney,errorMoneyUnit];
                incomeLabel.attributedText = [Helper multiplicityText:incomeLabel.text from:0 to:(int)incomeLabel.text.length - (int)errorMoneyUnit.length color:color];
            }
            else if (i == 1){
                incomeLabel.frame = CGRectMake(_alertView.frame.size.width/2 + _alertView.frame.size.width/2/8, messageLabel.frame.origin.y + messageLabel.frame.size.height - 15/667.0*ScreenHeigth, _alertView.frame.size.width/2/8*7, 42/667.0*ScreenHeigth);
                incomeLabel.textAlignment = NSTextAlignmentRight;
                NSString    *sign = @"+";
                UIColor     *color = Color_red;
                if ([errorIntegral floatValue] < 0) {
                    sign = @"";
                    color = Color_green;
                }
                incomeLabel.textAlignment = NSTextAlignmentLeft;
                incomeLabel.text = [NSString stringWithFormat:@"%@%@积分",sign,errorIntegral];
                incomeLabel.attributedText = [Helper multiplicityText:incomeLabel.text from:0 to:(int)incomeLabel.text.length - 2 color:color];
            }
        }
    }
    //有积分
    else if ((errorMoney == nil || [errorMoney isKindOfClass:[NSNull class]]) && (errorIntegral != nil && ![errorIntegral isKindOfClass:[NSNull class]])){
        NSString    *sign = @"+";
        UIColor     *color = Color_red;
        if ([errorIntegral floatValue] < 0) {
            sign = @"";
            color = Color_green;
        }
        messageLabel.text = [NSString stringWithFormat:@"%@  %@%@积分",errorMessage,sign,errorIntegral];
        messageLabel.attributedText = [Helper multiplicityText:messageLabel.text from:(int)errorMessage.length + 2 to:(int)errorIntegral.length+(int)sign.length color:color];
    }
    //有现金
    else if ((errorMoney != nil && ![errorMoney isKindOfClass:[NSNull class]]) && (errorIntegral == nil || [errorIntegral isKindOfClass:[NSNull class]])){
        NSString    *sign = @"+";
        UIColor     *color = Color_red;
        if ([errorMoney floatValue] < 0) {
            sign = @"";
            color = Color_green;
        }
        messageLabel.text = [NSString stringWithFormat:@"%@  %@%@%@",errorMessage,sign,errorMoney,errorMoneyUnit];
        messageLabel.attributedText = [Helper multiplicityText:messageLabel.text from:(int)errorMessage.length + 2 to:(int)errorMoney.length+(int)sign.length color:color];
    }
    //无积分，无现金
    else{
        
    }
    
    if (ScreenHeigth <= 480) {
        messageLabel.bounds = CGRectMake(0, 0, messageLabel.frame.size.width, messageLabel.frame.size.height + 20);
        _alertView.bounds = CGRectMake(0, 0, _alertView.frame.size.width, _alertView.frame.size.height + 20);
    }
    else if (ScreenHeigth <= 568 && ScreenHeigth > 480){
        messageLabel.bounds = CGRectMake(0, 0, messageLabel.frame.size.width, messageLabel.frame.size.height + 10);
        _alertView.bounds = CGRectMake(0, 0, _alertView.frame.size.width, _alertView.frame.size.height + 10);
    }
    
}

@end
