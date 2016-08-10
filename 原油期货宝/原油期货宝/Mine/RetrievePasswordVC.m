//
//  RetrievePasswordVC.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/21.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//


#import "RetrievePasswordVC.h"
#import "ResetPpasswordVC.h"

//字体大小
#define textFont 15
//#define timeInterval 60
@interface RetrievePasswordVC ()
{

    NSString * str;
    NSInteger _textFiledSelected;
    //1 tel  2 message 3 password 4 推广  0 未点击
    BOOL _telIsRight;
    CGFloat  _keybordAndLoginBtn;
    //键盘弹出时间
    CGFloat _animationDuration;
    
    NSTimer * timer;
    NSInteger timeInterval;


}
@property (nonatomic, strong) UITextField *telText;
@property (nonatomic, strong) UITextField * messageText;
@property (nonatomic, strong) UIButton * messageBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation RetrievePasswordVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    timeInterval = 10;
    
    [self loadUI];
}

-(void)loadUI{

    UILabel * telLable =[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 70, 50)];
    telLable.text = @"手机号";
    telLable.font = [UIFont systemFontOfSize:textFont];
    [self.view addSubview:telLable];
    
    UITextField * telText = [[UITextField alloc]initWithFrame:CGRectMake(telLable.current_x_w, telLable.current_y, ScreenWidth- telLable.current_x_w, telLable.current_h)];
    telText.placeholder = @"请输入手机号";
    [telText addTarget:self action:@selector(telTextClicked:) forControlEvents:UIControlEventAllEditingEvents];
    [telText becomeFirstResponder];
    telText.keyboardType=UIKeyboardTypeNumberPad;
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:TelNum]) {
        telText.text = [[NSUserDefaults standardUserDefaults]objectForKey:TelNum];
    }
    
    

    _telText =telText;
    
    telText.font = [UIFont systemFontOfSize:textFont];
    [self.view addSubview:telText];
    
    
    
    
    
    //短信验证码
    UILabel * messageLable = [[UILabel alloc]initWithFrame:CGRectMake(telLable.current_x, telLable.current_y_h+5, telLable.current_w, telLable.current_h)];
    messageLable.text = @"短信验证";
    messageLable.font =[UIFont systemFontOfSize:textFont];
    [self.view addSubview:messageLable];
    
    UITextField * messageText = [[UITextField alloc]initWithFrame:CGRectMake(messageLable.current_x_w, messageLable.current_y, ScreenWidth-messageLable.current_x_w-90, messageLable.current_h)];
    messageText.placeholder = @"输入验证码";
    messageText.font =[UIFont systemFontOfSize:textFont];
    messageText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    messageText.keyboardType=UIKeyboardTypeNumberPad;

    [messageText addTarget:self action:@selector(messageTextClicked:) forControlEvents:UIControlEventAllEditingEvents];
    _messageText =messageText;
    [self.view addSubview:messageText];
    
    UIButton * messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(messageText.current_x_w, messageText.current_y, 80, messageText.current_h)];
    [messageBtn addTarget:self action:@selector(getMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self loginBtnCanSelsected:NO];
    [messageBtn setBackgroundColor:[UIColor grayColor]];
    [messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    messageBtn.titleLabel.font = [UIFont systemFontOfSize:textFont];
    _messageBtn = messageBtn;
    [self.view addSubview:messageBtn];

    //下一步按钮
    UIButton * nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, messageText.current_y_h+10, ScreenWidth-30*2, 50)];
    nextBtn.userInteractionEnabled=NO;
    
    nextBtn.backgroundColor=[UIColor grayColor];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(netBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    _nextBtn = nextBtn;
    
    
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(telLable.current_x, telLable.current_y_h, ScreenWidth-telLable.current_x, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(messageLable.current_x, messageLable.current_y_h+2, ScreenWidth-messageLable.current_x, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    

}


#pragma mark -- 账号文本点击事件
-(void)telTextClicked:(UITextField *)sender
{
    _textFiledSelected = 1;
    
    if (_telText.text.length==11) {
        //[_telText setUserInteractionEnabled:NO];
        str=_telText.text;
        
    }else if (_telText.text.length>11){
        
        
    }
    
    else{
        
        [self loginBtnCanSelsected:NO];
        
        str=nil;
    }
    
    
    if (str!=nil) {
        
        
        _telText.text=str;
        
        _textFiledSelected=1;
        NSString *regex=@"^(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        BOOL isMatch = [pred evaluateWithObject:sender.text];
        
        if (isMatch) {
            // NSLog(@"账号正确");
            _telIsRight=YES;
            [self loginBtnCanSelsected:YES];
            //            if (_passWordText.text.length>=6) {
            //                //账号密码正确，登陆按钮变为可点击状态
            //
            //            }else{
            //
            //                [self loginBtnCanSelsected:NO];
            //
            //            }
        }else{
            _telIsRight=NO;
            //NSLog(@"账号错误");
            [self loginBtnCanSelsected:NO];
            
        }
        
    }
    
    /**
     *  1、判断当输完11位时手机号是否正确
     *  2、若正确，等待几秒跳转到密码框
     *  3、若错误，弹窗提示
     *  @return <#return value description#>
     */
    
    
    
    
    
}



#pragma mark -- 判断按钮是否可点击
-(void)loginBtnCanSelsected:(BOOL)selected
{
    if (selected) {
        _messageBtn.userInteractionEnabled=YES;
        
        _messageBtn.backgroundColor=[UIColor orangeColor];
        
    }else{
        _messageBtn.userInteractionEnabled=NO;
        
        _messageBtn.backgroundColor=[UIColor grayColor];
    }
    
    
}

-(void)btn:(UIButton *)btn canSelected:(BOOL)selected{


}


#pragma mark -- 获取验证码
-(void)getMessage:(UIButton *)sender{
    
    [self closeKeyBord];
    NSString *alertText = [NSString stringWithFormat:@"将要发送验证码到%@,请确认！",_telText.text];
    
    [[UIEngine sharedInstance] showAlertWithTitle:alertText ButtonNumber:2 FirstButtonTitle:@"确定" SecondButtonTitle:@"取消"];
    [UIEngine sharedInstance].alertClick = ^ (int aIndex){
        
        if (aIndex == 10086) {
            //第一个按钮（确认）
            [self sendMessageRequest];
            
        }else if (aIndex == 10087){
            //第二个按钮（取消）
        }
    };
}

#pragma mark -- 验证码请求
-(void)sendMessageRequest{
    
    
    //    NSDictionary * dic = @{@"tele":_telText.text,
    //                           @"version":Version};
    NSString *tel=_telText.text;
    NSString * tele =[tel stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * sign =[NSString stringWithFormat:@"%@luckin",tele];
    NSDictionary * dic = @{@"tele":tele,
                           @"version":@"1.0.0",
                           @"sign":[sign MD5Digest]
                           };
    
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:findLoginPwdCode successBlock:^(NSDictionary *dictionary) {
        NSLog(@"dictionary = %@",dictionary);
        
        NSString * alertText = dictionary[@"msg"];
        [[UIEngine sharedInstance] showAlertWithTitle:alertText ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@"取消"];
        
        [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            
            if (aIndex == 10086) {
                //第一个按钮（确认）
                
                
            }else if (aIndex == 10087){
                //第二个按钮（取消）
                
                
            }
            
        };
        
        if ([dictionary[@"code"]floatValue]==200) {
            
            [self loginBtnCanSelsected:NO];
            //开启定时器，并设置按钮不可点击，显示倒计时
          timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerChange:) userInfo:nil repeats:YES];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

-(void)timerChange:(NSTimer *)sender{

    if (timeInterval > 0) {
        NSString * title = [NSString stringWithFormat:@"%ds",timeInterval];
        
        [_messageBtn setTitle:title forState:UIControlStateNormal];
        timeInterval--;
        
    }
    else{
        [_messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];

        [self loginBtnCanSelsected:YES];
        [timer invalidate];
    
    }
}


#pragma mark -- 验证码输入框
-(void)messageTextClicked:(UITextField *)sender{
    //
    _textFiledSelected = 2;

    NSString * text = [Helper trim:sender.text];
    
    sender.text = text;
    
    if (sender.text.length >= 4) {
        
        _nextBtn.userInteractionEnabled=YES;
        
        _nextBtn.backgroundColor=[UIColor orangeColor];
    }else{
    
        _nextBtn.userInteractionEnabled=NO;
        
        _nextBtn.backgroundColor=[UIColor grayColor];
    
    }
    
    
    
    
    
}

#pragma mark -- 下一步按钮
-(void)netBtnClicked:(UIButton *)sender{
    [self closeKeyBord];
    NSString *tel=_telText.text;
    NSString * tele =[tel stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * code = _messageText.text;
    
    
    NSDictionary * dic = @{@"tele":tele,
                           @"version":Version,
                           @"code":code
                           };
    
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:authLoginPwdCode successBlock:^(NSDictionary *dictionary) {
        NSLog(@"dictionary = %@",dictionary);
        
    
        
        if ([dictionary[@"code"]floatValue]==200) {
            //验证成功，进入下一页
            ResetPpasswordVC * ResetPWVC = [[ResetPpasswordVC alloc]init];
            ResetPWVC.telNumber = tele;
            ResetPWVC.code =code;
            [self.navigationController pushViewController:ResetPWVC animated:YES];
            
            
        }
        else{
        
            NSString * alertText = dictionary[@"msg"];
            [[UIEngine sharedInstance] showAlertWithTitle:alertText ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@"取消"];
            
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
                
                if (aIndex == 10086) {
                    //第一个按钮（确认）
                    
                    
                }else if (aIndex == 10087){
                    //第二个按钮（取消）
                    
                    
                }
                
            };
        
        
        }
        
        
        
    } failureBlock:^(NSError *error) {
        
    }];




}

-(void)closeKeyBord{

    if (_textFiledSelected == 1) {
        [_telText resignFirstResponder];
        _textFiledSelected = 0;
        
    }else if (_textFiledSelected ==2){
    
        [_messageText resignFirstResponder];
        _textFiledSelected = 0;
    
    }



}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self closeKeyBord];


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
