//
//  tableHeaderView.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/25.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "tableHeaderView.h"

@interface tableHeaderView ()
{
    UIButton * rechargeBtn;
    UIButton * WithdrawalsBtn;

}
@property (nonatomic, strong) UILabel * balance;
@property (nonatomic, strong) UILabel * integral;



@end




@implementation tableHeaderView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    
    return self;
}



-(void)loadUI{
    //余额
    UILabel * balance = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth/2, 25)];
    balance.text=@"0";
    balance.font = [UIFont systemFontOfSize:12];
    balance.textColor = [UIColor redColor];
    balance.textAlignment = NSTextAlignmentCenter;
    _balance = balance;
    [self addSubview:balance];
    
    
    UILabel * balanceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, balance.current_y_h, balance.current_w, 20)];
    balanceLable.text = @"账户余额(元)";
    balanceLable.font = [UIFont systemFontOfSize:12];
    balanceLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:balanceLable];
    
    //积分
    UILabel * integral =[[UILabel alloc]initWithFrame:CGRectMake(balance.current_x_w+1, 10, ScreenWidth/2, 25)];
    integral.text=@"0";
    integral.font = [UIFont systemFontOfSize:12];
    integral.textColor = [UIColor redColor];
    integral.textAlignment = NSTextAlignmentCenter;
    [self addSubview:integral];
    _integral = integral;
    UILabel * integralLable = [[UILabel alloc]initWithFrame:CGRectMake(integral.current_x, integral.current_y_h, integral.current_w, 20)];
    integralLable.text = @"积分余额";
    integralLable.font = [UIFont systemFontOfSize:12];
    integralLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:integralLable];
    
    //竖线
    UILabel * verticalLable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 0, 1, integralLable.current_y_h)];
    
    verticalLable.backgroundColor = RGBA(237, 237, 237, 1);
    
    
    [self addSubview:verticalLable];
    
    //横线
    UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, integralLable.current_y_h+5, ScreenWidth, 1)];
    lineLable.backgroundColor = RGBA(237, 237, 237, 1);

    [self addSubview:lineLable];
    
    //充值
    rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, lineLable.current_y_h+10, (ScreenWidth-20*3)/2, 40)];
    rechargeBtn.backgroundColor = [UIColor whiteColor];
    [rechargeBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateHighlighted];
    [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    [rechargeBtn.layer setMasksToBounds:YES];
    [rechargeBtn.layer setCornerRadius:6.0];
    
    rechargeBtn.layer.borderWidth = 2;//边框宽度
    //refreshBtn.layer.borderColor = [[UIColor colorWithRed:0.92 green:0.05 blue:0.07 alpha:1] CGColor];//边框颜色
    rechargeBtn.layer.borderColor = [UIColor redColor].CGColor;//边框颜色
    [rechargeBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rechargeBtn.tag = 1300;
    [self addSubview:rechargeBtn];
    //提现
    
    WithdrawalsBtn = [[UIButton alloc]initWithFrame:CGRectMake(rechargeBtn.current_x_w+20, rechargeBtn.current_y, rechargeBtn.current_w, rechargeBtn.current_h)];
    
    WithdrawalsBtn.backgroundColor = [UIColor whiteColor];
    [WithdrawalsBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
    [WithdrawalsBtn setTitle:@"提现" forState:UIControlStateNormal];
    [WithdrawalsBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [WithdrawalsBtn setTitle:@"提现" forState:UIControlStateHighlighted];
    [WithdrawalsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [WithdrawalsBtn.layer setMasksToBounds:YES];
    [WithdrawalsBtn.layer setCornerRadius:6.0];
    
    WithdrawalsBtn.layer.borderWidth = 2;//边框宽度
    //refreshBtn.layer.borderColor = [[UIColor colorWithRed:0.92 green:0.05 blue:0.07 alpha:1] CGColor];//边框颜色
    WithdrawalsBtn.layer.borderColor = [UIColor redColor].CGColor;//边框颜色
    [WithdrawalsBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];

    WithdrawalsBtn.tag = 1301;
    
    [self addSubview:WithdrawalsBtn];
    
    
//    rechargeBtn.userInteractionEnabled=NO;
//    
//    rechargeBtn.backgroundColor=[UIColor grayColor];
//    
//    WithdrawalsBtn.userInteractionEnabled=NO;
//    
//    WithdrawalsBtn.backgroundColor=[UIColor grayColor];

}



-(void)loadRequest{

    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    NSDictionary * dic = @{@"token":token,
                           @"version":Version};
    
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:FinancyMain successBlock:^(NSDictionary *dictionary) {
    
    NSLog(@"详情 dictionary = %@",dictionary);
    NSDictionary * data = dictionary[@"data"];
    
    
    if ([dictionary[@"code"]floatValue] == 200) {
        
        
        if ([data isKindOfClass:[NSNull class]] || data.count==0) {
            
            
        }else{
            
            self.FinancyDic = dictionary[@"data"];
            
            
//            WithdrawalsBtn.backgroundColor = [UIColor whiteColor];
//            WithdrawalsBtn.userInteractionEnabled=YES;
//            
//            rechargeBtn.backgroundColor = [UIColor whiteColor];
//            rechargeBtn.userInteractionEnabled=YES;
            
            NSString * usedAmt = [Helper translateStr:data[@"usedAmt"]];
            
            _balance.text = usedAmt;
            
            NSString * score = [Helper translateStr:data[@"score"]];
            
            _integral.text = score;
            
        }
        
        
    }else{
    
        _balance.text = @"-";
        
        _integral.text = @"-";
    
    }
    

    
    
   
    
    
} failureBlock:^(NSError *error) {
    
    _balance.text = @"-";

    _integral.text = @"-";

    
}];



}

-(void)btnClicked:(UIButton *)sender{

    self.btnClick(sender);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
