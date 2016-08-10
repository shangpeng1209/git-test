//
//  loginViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "loginViewController.h"
#import "registerViewController.h"
#import "RetrievePasswordVC.h"

#import "ResetPpasswordVC.h"



@interface loginViewController ()<UIScrollViewTouchesDelegate,UITextFieldDelegate>
{
    CGFloat _keybordHeight;
    //0 textFiled未被选中（取消选中）  1 userNameText 被选中 2 passWordText被选中
    NSInteger _textFiledSelected;
    NSTimeInterval _animationDuration;
    
    //注册按钮与键盘位置高度的差值
    
    CGFloat  _keybordAndLoginBtn;
    
    
    NSString *str;
    
    BOOL _telIsRight;


}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *backGroud;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIImageView *IconImageView;
@property (nonatomic, strong) UILabel *userNmaeLable;
@property (nonatomic, strong) UITextField * userNameText;
@property (nonatomic, strong) UITextField * passWordText;
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton * forgetPW;
@property (nonatomic, strong) UILabel *userLable;
@property (nonatomic, strong) UILabel *passLable;

//切换按钮
@property (nonatomic, strong) UIButton  *changeBtn;
//忘记密码按钮
@property (nonatomic, strong) UIButton  *forgotPw;


@end


@implementation loginViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;

    
    
    
}
-(void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self keyBord];
    [self loadUI];
}


-(void)loadUI{
    TouchScrollView *scrollView=[[TouchScrollView alloc]initWithFrame:CGRectMake(0, -64, ScreenWidth, ScreenHeigth)];
    scrollView.scrollEnabled=YES;
    scrollView.touchesdelegate=self;
    [self.view addSubview:scrollView];
    UIImageView * imageView = [[UIImageView alloc]init];
    
    [scrollView addSubview:imageView];
    _scrollView =scrollView;
    
    UIButton * backBtn = [[UIButton alloc]init];
    
    [scrollView addSubview:backBtn];
    
    
    UIImageView * iconView = [[UIImageView alloc]init];
    
    [scrollView addSubview:iconView];
    
    
    UITextField * userName = [[UITextField alloc]init];
    userName.placeholder = @"请输入手机号";
    //userName.textColor=[UIColor whiteColor];
    [userName setValue:RGBACOLOR(146, 146, 146, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [userName setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [userName addTarget:self action:@selector(userNameSelect:) forControlEvents:UIControlEventAllEditingEvents];
    userName.delegate = self;
    NSString * tel = [[NSUserDefaults standardUserDefaults]objectForKey:TelNum];
    if (tel == nil || [tel isEqualToString:@""]) {
        
        
    }else{
       // userName.userInteractionEnabled =NO;
        userName.textAlignment = NSTextAlignmentCenter;
        userName.text = tel;
    
    }
    
    
    
    
    
    [scrollView addSubview:userName];
    _userNameText = userName;
    
    
    
    
    
    UITextField * passWord = [[UITextField alloc]init];
    passWord.placeholder = @"请输入密码";
    [passWord setValue:RGBACOLOR(146, 146, 146, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [passWord setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [passWord addTarget:self action:@selector(passWordTextSelsect:) forControlEvents:UIControlEventAllEditingEvents];
    passWord.secureTextEntry=YES;
    [passWord addTarget:self action:@selector(passWordTextSelsect:) forControlEvents:UIControlEventAllEditingEvents];
    passWord.clearButtonMode=UITextFieldViewModeWhileEditing;
    passWord.delegate = self;
  //  passWord.textColor = [UIColor whiteColor];
    [scrollView addSubview:passWord];

    _passWordText = passWord;
    
    
    
    //登陆按钮
    UIButton * loginBtn = [[UIButton alloc]init];
    [loginBtn addTarget:self action:@selector(loginTo:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [scrollView addSubview:loginBtn];
    _loginBtn = loginBtn;
    
    
    //切换账户、登陆按钮 ，根据userdefault是否存取username来确定

    
    // 切换用户 注册按钮
    UIButton * changeBtn = [[UIButton alloc]init];
    NSString * btnTitle;
    
    if (tel==nil || [tel isEqualToString:@""]) {
        btnTitle = @"注册账户";
    }else{
        btnTitle=@"切换账户";
    }
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [changeBtn setTitle:btnTitle forState:UIControlStateNormal];
    
    [changeBtn addTarget:self action:@selector(changeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:changeBtn];
    _changeBtn = changeBtn;
    
    
    //忘记密码按钮
    UIButton * forgotPw = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, 100, 30)];
    
    [forgotPw addTarget:self action:@selector(forgotPwClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPw];
    forgotPw.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgotPw setTitle:@"忘记密码?" forState:UIControlStateNormal];

    _forgotPw = forgotPw;
    
    
    
    [self layoutSubviews];
}

-(void)layoutSubviews{


    
    _userNameText.frame = CGRectMake(10, 200.0/660.0*SCREEN_HEIGHT, SCREEN_WIDTH-20, 50);
   // _userNameText.backgroundColor = [UIColor blackColor];
    
    //UILabel * userLine = [UILabel alloc]initWithFrame:<#(CGRect)#>
    
    
    _passWordText.frame = CGRectMake(10, _userNameText.current_y_h+5, _userNameText.current_w, 50);
    //_passWordText.backgroundColor = [UIColor blackColor];
    
    _loginBtn.frame = CGRectMake(30, _passWordText.current_y_h+5, SCREEN_WIDTH-60, 50);
    _loginBtn.backgroundColor = [UIColor grayColor];
    
    
    _changeBtn.frame = CGRectMake(5, ScreenHeigth - 30-64, ScreenWidth/4, 25);
    
    _changeBtn.backgroundColor = [UIColor grayColor];
    
    _forgotPw.frame = CGRectMake(ScreenWidth-ScreenWidth/4-5, _changeBtn.current_y, ScreenWidth/4, 25);
    
    _forgotPw.backgroundColor = [UIColor grayColor];
    
    
    
//    _forgotPw.frame = CGRectMake(5, ScreenHeigth - 30, ScreenWidth/4, 25);
//    _forgetPW . backgroundColor = [UIColor blackColor];
    
    

}

-(void)scrollViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event whichView:(id)scrollView
{
    if (_textFiledSelected==1) {
        [_userNameText resignFirstResponder];
        _textFiledSelected=0;
        
    }else if (_textFiledSelected==2){
        [_passWordText resignFirstResponder];
        _textFiledSelected=0;
        
    }else{
        
    }
    
   // if (_keybordAndLoginBtn>0) {
        [UIView animateWithDuration:_animationDuration animations:^{
            
            _scrollView.contentOffset=CGPointMake(0, 0);
            
            
        } completion:^(BOOL finished) {
            _keybordAndLoginBtn=0;
            
        }];
   // }
}

#pragma mark -- 密码文本点击事件
-(void)passWordTextSelsect:(UITextField *)sender
{
    
    _textFiledSelected=2;
    //以后确定用户名是否可以有空格
    NSString * tel = [[NSUserDefaults standardUserDefaults]objectForKey:TelNum];

    if (tel) {
        _telIsRight = YES;
    }
    
    if (_passWordText.text.length>=6 && _telIsRight==YES) {
        
        [self loginBtnCanSelsected:YES];
        
    }else{
        
        [self loginBtnCanSelsected:NO];
        
    }
    
    
    
}

#pragma mark -- 账号文本点击事件
-(void)userNameSelect:(UITextField *)sender
{
    
    _textFiledSelected=1;
    
    if (_userNameText.text.length==11) {
        //[_userNameText setUserInteractionEnabled:NO];
        str=_userNameText.text;
        
    }else if (_userNameText.text.length>11){
        
        
    }
    
    else{
        
        [self loginBtnCanSelsected:NO];
        
        str=nil;
    }
    
    
    if (str!=nil) {
        
        
        _userNameText.text=str;
        
        _textFiledSelected=1;
        NSString *regex=@"^(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        BOOL isMatch = [pred evaluateWithObject:sender.text];
        
        if (isMatch) {
            // NSLog(@"账号正确");
            _telIsRight=YES;
            if (_passWordText.text.length>=6) {
                //账号密码正确，登陆按钮变为可点击状态
                
                [self loginBtnCanSelsected:YES];
            }else{
                
                [self loginBtnCanSelsected:NO];
                
            }
        }else{
            _telIsRight=NO;
            //NSLog(@"账号错误");
            [ UIEngine  showShadowPrompt:@"账号输入错误"];
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



#pragma  mark -- 登陆按钮事件
-(void)loginTo:(UIButton *)sender
{
    
    
    NSString *tel=_userNameText.text;
    NSString * tele =[tel stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * pw=_passWordText.text;
    NSDictionary *dic=@{@"loginName":tele,
                        @"password" :[pw MD5Digest],
                        @"version"  :Version
                        
                        };
    NSString *url=LoginURL;
    
    
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:url successBlock:^(NSDictionary *dictionary) {
        
        NSLog(@"dic=%@",dictionary);
        
        if ([dictionary[@"code"]floatValue]==200) {
            [ UIEngine  showShadowPrompt:dictionary[@"msg"]];
            NSDictionary * data = dictionary[@"data"];
            
            NSDictionary * tokenInfo = data[@"tokenInfo"];
            
            //会话标识
            NSString * token = tokenInfo[@"token"];
            //
            NSString * userSecret = tokenInfo[@"userSecret"];
            
            //电话号码
            NSString * telNum = data[@"userInfo"][@"tele"];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:token forKey:UserToken];
            
            [[NSUserDefaults standardUserDefaults]setObject:userSecret forKey:UserSecret];
           
            [[NSUserDefaults standardUserDefaults]setObject:telNum forKey:TelNum];
       
            
            //将dictionary转换成data存入userdefault
            [[NSUserDefaults standardUserDefaults]setObject:[Helper returnDataWithDictionary:dictionary] forKey:UserInfo];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:LandAgain];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            

        }else{
        
        }
        
        
        
        
        
    } failureBlock:^(NSError *error) {
        
    }];
}


#pragma mark -- 切换、注册按钮 点击事件
-(void)changeBtnClicked:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"切换账户"]) {
        
        //删除userdefault中的tel
       // [[NSUserDefaults standardUserDefaults]removeObjectForKey:TelNum];
        //将账号输入框清空
        _userNameText.text = nil;
        //恢复账号可编辑状态
        // _userNameText.userInteractionEnabled =NO;
        
        //将账号输入框设置为左对齐
        _telIsRight = NO;
        
        //将btnlable 设置为“注册账户”
        
        [_changeBtn setTitle:@"注册账户" forState:UIControlStateNormal];
        
        
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"注册账户"]){
        registerViewController * registerVC = [[registerViewController alloc]init];
        
        [self.navigationController pushViewController:registerVC animated:YES];
    }
}

#pragma mark -- 忘记密码按钮

-(void)forgotPwClicked:(UIButton *)sender{
    //跳转到忘记密码页面

    RetrievePasswordVC * retrieveVC = [[RetrievePasswordVC alloc]init];
    
    [self.navigationController pushViewController:retrieveVC animated:YES];

//    ResetPpasswordVC * vc = [[ResetPpasswordVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];

}



#pragma <#arguments#>





#pragma mark -- 键盘监听、通知
-(void)keyBord
{
    
    //1.定制通知
    //在初始化时定制通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
}
//2.对应的方法。
-(void)KeyboardWillShow:(NSNotification *)notification
{
    NSLog(@"keybord");
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
    _keybordAndLoginBtn=keyboardHeight-(ScreenHeigth- _loginBtn.current_y_h);
   
    if (_textFiledSelected>0&&_keybordAndLoginBtn>0) {
        
        [UIView animateWithDuration:animationDuration animations:^{
            _scrollView.contentOffset=CGPointMake(0, _keybordAndLoginBtn);
            
            
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}

#pragma mark -- 判断按钮是否可点击
-(void)loginBtnCanSelsected:(BOOL)selected
{
    if (selected) {
        _loginBtn.userInteractionEnabled=YES;
        
        _loginBtn.backgroundColor=[UIColor orangeColor];
        
    }else{
        _loginBtn.userInteractionEnabled=NO;
        
        _loginBtn.backgroundColor=[UIColor grayColor];
        
        
    }
    
    
}
#pragma mark -- 键盘return键事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
//    if (_textFiledSelected==1) {
//        [_userNameText resignFirstResponder];
//        _textFiledSelected=0;
//        
//    }else if (_textFiledSelected==2){
//        [_passWordText resignFirstResponder];
//        _textFiledSelected=0;
//        
//    }else{
//        
//    }
    
    // if (_keybordAndLoginBtn>0) {
    [UIView animateWithDuration:_animationDuration animations:^{
        
        _scrollView.contentOffset=CGPointMake(0, 0);
        
        
    } completion:^(BOOL finished) {
        _keybordAndLoginBtn=0;
        
    }];

    return YES;
}

@end
