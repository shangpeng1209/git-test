//
//  registerViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/20.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "registerViewController.h"

//字体大小
#define textFont 15

@interface registerViewController ()<UIScrollViewTouchesDelegate,UITextFieldDelegate>

{
    NSString * str;
    NSInteger _textFiledSelected;
    //1 tel  2 message 3 password 4 推广  0 未点击
    BOOL _telIsRight;
    CGFloat  _keybordAndLoginBtn;
    //键盘弹出时间
    CGFloat _animationDuration;


}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *telText;
@property (nonatomic, strong) UITextField * messageText;
@property (nonatomic, strong) UIButton * messageBtn;
@property (nonatomic, strong) UITextField * passWordText;
@property (nonatomic, strong) UITextField *extensionText;
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation registerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;

    
    
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textFiledSelected = 0;
    
    [self keyBord];
    TouchScrollView *scrollView=[[TouchScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.scrollEnabled=YES;
    scrollView.touchesdelegate=self;
    [self.view addSubview:scrollView];
    _scrollView =scrollView;
    [self loadUI];
    
}

-(void)loadUI{

    UILabel * telLable =[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 70, 50)];
    telLable.text = @"手机号";
    telLable.font = [UIFont systemFontOfSize:textFont];
    [_scrollView addSubview:telLable];
    
    UITextField * telText = [[UITextField alloc]initWithFrame:CGRectMake(telLable.current_x_w, telLable.current_y, ScreenWidth- telLable.current_x_w, telLable.current_h)];
    telText.placeholder = @"请输入手机号";
    telText.tag = 1101;
    [telText addTarget:self action:@selector(telTextClicked:) forControlEvents:UIControlEventAllEditingEvents];
    _telText =telText;
    
    telText.font = [UIFont systemFontOfSize:textFont];
    [_scrollView addSubview:telText];
    
    
    
    
    
    //短信验证码
    UILabel * messageLable = [[UILabel alloc]initWithFrame:CGRectMake(telLable.current_x, telLable.current_y_h+5, telLable.current_w, telLable.current_h)];
    messageLable.text = @"短信验证";
    messageLable.font =[UIFont systemFontOfSize:textFont];
    [_scrollView addSubview:messageLable];
    
    UITextField * messageText = [[UITextField alloc]initWithFrame:CGRectMake(messageLable.current_x_w, messageLable.current_y, ScreenWidth-messageLable.current_x_w-90, messageLable.current_h)];
    messageText.placeholder = @"输入验证码";
    messageText.tag =1102;
    messageText.font =[UIFont systemFontOfSize:textFont];
    [messageText addTarget:self action:@selector(TextClicked:) forControlEvents:UIControlEventAllEditingEvents];
    _messageText =messageText;
    [_scrollView addSubview:messageText];
    
    UIButton * messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(messageText.current_x_w, messageText.current_y, 80, messageText.current_h)];
    [messageBtn addTarget:self action:@selector(getMessage:) forControlEvents:UIControlEventTouchUpInside];
    messageBtn.backgroundColor = [UIColor grayColor];
    
    [messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    messageBtn.titleLabel.font = [UIFont systemFontOfSize:textFont];
    _messageBtn = messageBtn;
    [_scrollView addSubview:messageBtn];
    
    
    
    
    
    
    //密码
    UILabel * passWordLable = [[UILabel alloc]initWithFrame:CGRectMake(messageLable.current_x, messageLable.current_y_h+5, messageLable.current_w, messageLable.current_h)];
    passWordLable.font = [UIFont systemFontOfSize:textFont];
    passWordLable.text = @"密码";
    [_scrollView addSubview:passWordLable];
    
    UITextField * passWordText = [[UITextField alloc]initWithFrame:CGRectMake(passWordLable.current_x_w, passWordLable.current_y, ScreenWidth- passWordLable.current_x_w, passWordLable.current_h)];
    [_scrollView addSubview:passWordText];
    passWordText.tag =1103;
    [passWordText addTarget:self action:@selector(TextClicked:) forControlEvents:UIControlEventAllEditingEvents];
    _passWordText =passWordText;

    
   
    
    //推广码
    UILabel * extensionLable = [[UILabel alloc]initWithFrame:CGRectMake(passWordLable.current_x, passWordLable.current_y_h+5, passWordLable.current_w, passWordLable.current_h)];
    extensionLable.text =@"推广";
    extensionLable.font =[UIFont systemFontOfSize:textFont];

    [_scrollView addSubview:extensionLable];
    
    
    
    
    UITextField *extensionText = [[UITextField alloc]initWithFrame:CGRectMake(extensionLable.current_x_w, extensionLable.current_y, ScreenWidth- extensionLable.current_x_w, extensionLable.current_h)];
    extensionText.placeholder = @"没有可不填";
    _extensionText = extensionText;
    [_scrollView addSubview:extensionText];
    [extensionText addTarget:self action:@selector(TextClicked:) forControlEvents:UIControlEventAllEditingEvents];
    extensionText.tag = 1104;
    
    
    UIButton * registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, extensionText.current_y_h+5, ScreenWidth-30*2, 50)];
    registerBtn.backgroundColor = [UIColor orangeColor];
    [_scrollView addSubview:registerBtn];
    _registerBtn = registerBtn;
    
    
    
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(telLable.current_x, telLable.current_y_h, ScreenWidth-telLable.current_x, 1)];
    line.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:line];

    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(messageLable.current_x, messageLable.current_y_h+2, ScreenWidth-messageLable.current_x, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:line1];
    UILabel * line2 = [[UILabel alloc]initWithFrame:CGRectMake(passWordLable.current_x, passWordLable.current_y_h, ScreenWidth-passWordLable.current_x, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:line2];
    
    UILabel * line3 = [[UILabel alloc]initWithFrame:CGRectMake(extensionLable.current_x, extensionLable.current_y_h, ScreenWidth-extensionLable.current_x, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:line3];
    
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

-(void)TextClicked:(UITextField *)sender{


    if (sender.tag == 1101) {
        _textFiledSelected = 2;

    }else if (sender.tag == 1102){
        
        _textFiledSelected = 2;
        
    
    }else if (sender.tag == 1103){
        
        _textFiledSelected = 3;
        
    }else if (sender.tag == 1104){
        
        _textFiledSelected = 4;
    }




}

#pragma mark -- 获取验证码
-(void)getMessage:(UIButton *)sender{
  
    [self closeKeyBord];
    NSString *alertText = [NSString stringWithFormat:@"发送验证码到%@,请确认！",_telText.text];

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


-(void)keyBord
{
    
    //1.定制通知
    //在初始化时定制通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
}
//2.对应的方法。
-(void)KeyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    
    //获取高度
    NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    //关键的一句，网上关于获取键盘高度的解决办法，多到这句就over了。系统宏定义的UIKeyboardBoundsUserInfoKey等测试都不能获取正确的值。不知道为什么。。。
    
    
    
    CGSize keyboardSize = [value CGRectValue].size;
    //NSLog(@"横屏%f",keyboardSize.height);
    float keyboardHeight = keyboardSize.height;
    // 获取键盘弹出的时间
    NSValue *animationDurationValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    _animationDuration=animationDuration;
    //自定义的frame大小的改变的语句
    //...
    //ScreenHeigth- _loginBtn.current_y_h
    
    if (_textFiledSelected == 1) {
        _keybordAndLoginBtn=keyboardHeight-(ScreenHeigth - _messageText.current_y_h);

    }
    if (_textFiledSelected == 2) {
        _keybordAndLoginBtn=keyboardHeight-(ScreenHeigth - _passWordText.current_y_h);

    }
    
    if (_textFiledSelected == 3) {
        _keybordAndLoginBtn=keyboardHeight-(ScreenHeigth - _extensionText.current_y_h);

    }
    
    if (_textFiledSelected == 4) {
        _keybordAndLoginBtn=keyboardHeight-(ScreenHeigth - _registerBtn.current_y_h);

    }
    
    
//    NSLog(@"keyboardHeight11111 = %f----%f---%f",_passWordText.current_y_h,_messageText.current_y_h,_extensionText.current_y_h);
//    NSLog(@"keyboardHeight22222 = %f",(ScreenHeigth - _messageText.current_y_h));
//
//    NSLog(@"_keybordAndLoginBtn = %f",_keybordAndLoginBtn);
//    NSLog(@"_textFiledSelected = %ld",(long)_textFiledSelected);
    
    if (_textFiledSelected>0&&_keybordAndLoginBtn>0) {
        [UIView animateWithDuration:animationDuration animations:^{
            _scrollView.contentOffset=CGPointMake(0, _keybordAndLoginBtn);
            
            
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}
-(void)scrollViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event whichView:(id)scrollView
{

    NSLog(@"...............");
    
    
    [self closeKeyBord];
    
    
    [UIView animateWithDuration:_animationDuration animations:^{
        _scrollView.contentOffset=CGPointMake(0, 0);
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
}


-(void)closeKeyBord{

    if (_textFiledSelected==1) {
        [_telText resignFirstResponder];
        _textFiledSelected=0;
        
    }else if (_textFiledSelected==2){
        [_messageText resignFirstResponder];
        _textFiledSelected=0;
        
    }else if (_textFiledSelected==3){
        [_passWordText resignFirstResponder];
        _textFiledSelected=0;
        
    }else if (_textFiledSelected==4){
        [_extensionText resignFirstResponder];
        _textFiledSelected=0;
        
    }else{
        
    }


}



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

    
    [SHPNetWorking postRequestWithNSDictionary:dic url:RegCode successBlock:^(NSDictionary *dictionary) {
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
        

    } failureBlock:^(NSError *error) {
        
    }];



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
