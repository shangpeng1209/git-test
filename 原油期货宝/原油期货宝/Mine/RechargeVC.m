//
//  RechargeVC.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/29.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//
typedef NS_ENUM(NSInteger,FromToType) {
    
    FromToTypeLastPage ,//从前一页进入
    FromToTypeNextPage ,//从后一页返回
};

typedef NS_ENUM(NSInteger,payStyle) {
    payStyleNone,//初始状态，未选中
    payStyleBank ,//银行卡支付
    payStyleAlipay ,//支付宝支付
};

#import "RechargeVC.h"
#import "bankVC.h"
@interface RechargeVC ()<UITextFieldDelegate>
{
    BOOL checkName;
    BOOL checkBank;
    
    UITextField * _sumMoneyText;
    NSDictionary * nameDic;
    NSDictionary * bankDic;
    
    FromToType type;
    payStyle currentStyle;
    UIView * bankView;
    UIView * alipayView;
    NSString * lastText;
    
}
@end

@implementation RechargeVC
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;
    
    switch (type) {
        case (FromToTypeLastPage):{
            
            NSLog(@"从前一页进入");
            
            break;
        }
        case (FromToTypeNextPage):{
            
            NSLog(@"从后一页返回");
            [self determineCanEnter];
            
            type = FromToTypeLastPage;
            break;
        }
            
        default:
            break;
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //[self Notification];
    
    
    
    
    
    currentStyle = payStyleNone;

    [self loadUI];
    [self determineCanEnter];

}

-(void)loadUI{
    UILabel * sumMoneyLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 40)];
    sumMoneyLable.text = @"充值金额";
    sumMoneyLable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sumMoneyLable];
    
    UITextField * sumMoneyText = [[UITextField alloc]initWithFrame:CGRectMake(sumMoneyLable.current_x_w, sumMoneyLable.current_y, ScreenWidth - sumMoneyLable.current_x_w, sumMoneyLable.current_h)];
    sumMoneyText.placeholder = @"充值金额＞＝50元";
    sumMoneyText.keyboardType = UIKeyboardTypeDecimalPad;
    sumMoneyText.font = [UIFont systemFontOfSize:15];
    sumMoneyText.returnKeyType =  UIReturnKeyDone;
    [sumMoneyText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
    sumMoneyText.delegate = self;
    sumMoneyText.tag = 1506;
    [self.view addSubview:sumMoneyText];
    _sumMoneyText = sumMoneyText;
    
    UILabel * paymentStyle = [[UILabel alloc]initWithFrame:CGRectMake(sumMoneyLable.current_x, sumMoneyLable.current_y_h+10, ScreenWidth-sumMoneyLable.current_x, sumMoneyLable.current_h)];
    paymentStyle.text = @"请选择支付方式";
    paymentStyle.textColor =RGBA(165, 164, 164, 1);
    paymentStyle.font = [UIFont systemFontOfSize:17];
    
    [self.view addSubview:paymentStyle];
    
    
    UIButton * bankBtn = [[UIButton  alloc]initWithFrame:CGRectMake(10, paymentStyle.current_y_h, ScreenWidth-20, 40)];
    bankBtn.backgroundColor = [UIColor blackColor];
    bankBtn.titleLabel.numberOfLines = 2;
    [bankBtn setTitle:@"银行卡支付\n无需开通网银" forState:UIControlStateNormal];
    //[bankBtn setAttributedTitle:<#(nullable NSAttributedString *)#> forState:<#(UIControlState)#>]
    CGFloat labelWidth = bankBtn.titleLabel.frame.size.width;
    CGFloat imageWith = bankBtn.imageView.current_w;
    bankBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
   bankBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
    [bankBtn setBackgroundImage:[UIImage imageNamed:@"shareIcon"] forState:UIControlStateNormal];
  //  [self.view addSubview:bankBtn];
#pragma mark -----------银联--------------
    bankView = [[UIView alloc]initWithFrame:CGRectMake(10, paymentStyle.current_y_h, ScreenWidth-20, 60)];
    //图片
    UIImageView * bankIamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40*115/75, 40)];
    bankView.backgroundColor = RGBA(231, 231, 231, 1);
    [bankIamgeView setImage:[UIImage imageNamed:@"yinlian"]];
    [bankView addSubview:bankIamgeView];
    bankView.tag = 1500;
    
    //标题
    UILabel * bankTitleLaable = [[UILabel alloc]initWithFrame:CGRectMake(bankIamgeView.current_x_w+10, bankIamgeView.current_y, bankView.current_w/2, 40)];
    bankTitleLaable.text = @"银行卡支付\n无需开通网银";
    bankTitleLaable.numberOfLines = 0;
    bankTitleLaable.font = [UIFont systemFontOfSize:14];
   // bankTitleLaable.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"银行卡支付\n无需开通网银"];
    bankTitleLaable.font = [UIFont systemFontOfSize:12];
    NSRange range ;
    range.location = 0;
    range.length = 5;
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:16.0]
     
                          range:range];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:range];
    
    bankTitleLaable.attributedText = AttributedStr;
    
    [bankView addSubview:bankTitleLaable];
    
    UIImageView * rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(bankView.current_w - bankView.current_h/2, 0, bankView.current_h/2, bankView.current_h/2)];
    [rightImageView setImage:[UIImage imageNamed:@"tuijian"]];
    [bankView addSubview:rightImageView];
    
    
    
    [self.view addSubview:bankView];
    
    //添加点击事件
    UITapGestureRecognizer * bankTgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
    //设定点击次数
    bankTgr.numberOfTapsRequired=1;
    
    [bankView addGestureRecognizer:bankTgr];

    bankView = [bankTgr view];
    
#pragma mark ----------支付宝----------------
    alipayView = [[UIView alloc]initWithFrame:CGRectMake(bankView.current_x, bankView.current_y_h+10, bankView.current_w, bankView.current_h)];
    
    alipayView.backgroundColor = RGBA(231, 231, 231, 1);
    alipayView.tag = 1501;
    
    //图片
    UIImageView * alipayIamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40*135/75, 40)];
    [alipayIamgeView setImage:[UIImage imageNamed:@"zhifubao"]];
    [alipayView addSubview:alipayIamgeView];
    
    
    
    
    
    
    
    
    
    
    
    [self.view addSubview:alipayView];
    
    //添加点击事件
    UITapGestureRecognizer * alipayTgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
    //设定点击次数
    alipayTgr.numberOfTapsRequired=1;
    [alipayView addGestureRecognizer:alipayTgr];
 
    [bankView.layer setMasksToBounds:YES];
    [bankView.layer setCornerRadius:6.0];
    [alipayView.layer setMasksToBounds:YES];
    [alipayView.layer setCornerRadius:6.0];
    
    
    
    
    UIButton * nextButton = [[UIButton alloc]initWithFrame:CGRectMake(20, alipayView.current_y_h+10, ScreenWidth-40, 50)];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    nextButton.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:nextButton];
    [nextButton.layer setMasksToBounds:YES];
    [nextButton.layer setCornerRadius:6.0];
    
    
    
    
    
}

-(void)textChange:(UITextField *)value{

    NSString * currentText = [Helper trim:value.text];

  //  NSString * text =[currentText stringByReplacingOccurrencesOfString:@".." withString:@"."];
    NSString * text = currentText;
    //限制小数点不能位于第一位
    if ([text rangeOfString:@"."].location == 0) {
        _sumMoneyText.text = @"";
        return;
    }
    
    
    //限制只能输入一个小数点
    NSArray *arr = [value.text componentsSeparatedByString:@"."];
    
    if (arr.count > 2) {
        _sumMoneyText.text = lastText;
    }else{
        _sumMoneyText.text = text;
        lastText = text;
    }
    
    
    

}


-(void)Tap:(id)sender{
    
    
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSInteger currentTag = [singleTap view].tag;
    
    if (currentTag == 1500) {
        DLog(@"选中银行卡");
        
        //点击银行卡变成红色边框，取消支付宝红色边框
        currentStyle = payStyleBank;
        bankView.layer.borderWidth = 1;//边框宽度
        bankView.layer.borderColor = [UIColor redColor].CGColor;//边框颜色
        
        alipayView.layer.borderWidth = 1;//边框宽度
        alipayView.layer.borderColor = [UIColor clearColor].CGColor;//边框颜色
        
    }else if (currentTag == 1501){
        DLog(@"选中支付宝");

        currentStyle = payStyleAlipay;
        //点击支付宝变成红色边框，取消银行卡红色边框
        
        alipayView.layer.borderWidth = 1;//边框宽度
        alipayView.layer.borderColor = [UIColor redColor].CGColor;//边框颜色
        
        bankView.layer.borderWidth = 1;//边框宽度
        bankView.layer.borderColor = [UIColor clearColor].CGColor;//边框颜色
    
    }
    
}

-(void)nextButtonClicked:(UIButton *)sender{

    
    if ([_sumMoneyText.text isEqualToString:@""]||_sumMoneyText==nil) {
        
        [[UIEngine sharedInstance] showAlertWithTitle:@"请填写充值金额" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
        [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            
        };
        
        
        return;
    }
    
    
    if ([_sumMoneyText.text floatValue]<50) {
       
        [[UIEngine sharedInstance] showAlertWithTitle:@"充值金额>=50元" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
        [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            
        };

        
        return;
    }
    
    
    
    switch (currentStyle) {
        case payStyleNone:
            [[UIEngine sharedInstance] showAlertWithTitle:@"请选择支付方式" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            
            };
            break;
        case payStyleBank:
            
            [[UIEngine sharedInstance] showAlertWithTitle:@"支付方式 = 银行卡" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
                
            };
            break;
        case payStyleAlipay:
            [[UIEngine sharedInstance] showAlertWithTitle:@"支付方式=支付宝" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
                
            };
            
            break;
  
        default:
            break;
    }


}




#pragma mark -- 验证实名认证 银行卡绑定
-(void)determineCanEnter{

    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    
    NSDictionary * dic = @{@"token":token,
                           @"version":Version};
    
    //
    [UIEngine sharedInstance].progressStyle=2;
    [[UIEngine sharedInstance]showProgress];

    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    
    /**1、验证实名认证*/
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:checkUserName successBlock:^(NSDictionary *dictionary) {
        
        NSLog(@"验证实名认证 = %@",dictionary);
        checkName = YES;
        
        if ([dictionary[@"code"]floatValue] == 200) {
            
            NSDictionary * dic = dictionary[@"data"];
            
            
            nameDic = [NSDictionary dictionaryWithDictionary:dic];
            
            
        }
        //请求成功，发送通知，以便事件处理
        [[NSNotificationCenter defaultCenter]postNotificationName:requestSuccess object:nil userInfo:nil];
        
    } failureBlock:^(NSError *error) {
        
        
        
    }];
    
    
    /**2、验证银行卡*/
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:checkBankCard successBlock:^(NSDictionary *dictionary) {
        NSLog(@"验证银行卡 = %@",dictionary);
        checkBank =YES;
        
        if ([dictionary[@"code"]floatValue] == 200) {
            [[UIEngine sharedInstance] hideProgress];

            NSDictionary * dic = dictionary[@"data"];
            
            bankDic = [NSDictionary dictionaryWithDictionary:dic];
            if ([bankDic[@"status"]floatValue]==0) {
                    NSLog(@"跳转到银行卡页面");
                
                [[UIEngine sharedInstance] showAlertWithTitle:@"您还未绑定银行卡，请先绑定" ButtonNumber:2 FirstButtonTitle:@"去绑定" SecondButtonTitle:@"返回"];
                [UIEngine sharedInstance].alertClick = ^ (int aIndex){
                    //点解确认按钮，事件处理
                    
                    if (aIndex == 10086) {
                        bankVC * bank = [[bankVC alloc]init];
                        type = FromToTypeNextPage;
                        [self.navigationController pushViewController:bank animated:YES];
                    }else if(aIndex == 10087){
                    
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                    
                    return;
                };
            }
            
        }
        //请求成功，发送通知，以便事件处理
        
        [[NSNotificationCenter defaultCenter]postNotificationName:requestSuccess object:nil userInfo:nil];
        
    } failureBlock:^(NSError *error) {

        
    }];
    

    
    


}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITextField * textFiled = [self.view viewWithTag:1506];
    [textFiled resignFirstResponder];

}


#pragma mark -- 通知创建与销毁
-(void)Notification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tokenOver:) name:tokenOverValue object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadFaild:) name:requestFaild object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadSuccess:) name:requestSuccess object:nil];
    
}

//token过期，需要重新登陆
-(void)tokenOver:(NSNotification *)sender{

    [self.navigationController popViewControllerAnimated:YES];

    
}
-(void)loadFaild:(NSNotification *)sender{
    //加载失败，返回
    //加载失败 隐藏MBprograss
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    [[UIEngine sharedInstance] showAlertWithTitle:@"加载失败，请稍后重试" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
    [UIEngine sharedInstance].alertClick = ^ (int aIndex){
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    
}
-(void)loadSuccess:(NSNotification *)sender{
    //[MBProgressHUD hideHUDForView:self.view animated:YES];

  
    
}
#pragma mark --------通知END---------

#pragma mark -- 判断request是否加载完

-(BOOL)requestIsDown{
    
    if (checkName && checkBank ) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        return YES;
    }
    
    return NO;
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:tokenOverValue object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:requestFaild object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:requestSuccess object:nil];
    
    [[UIEngine sharedInstance] hideProgress];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
