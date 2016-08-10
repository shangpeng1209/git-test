//
//  ResetPpasswordVC.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/21.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "ResetPpasswordVC.h"
//字体大小
#define textFont 15
@interface ResetPpasswordVC ()
@property (nonatomic, strong) UITextField * pwdText;
@property (nonatomic, strong) UITextField * repeatPwdText;
@property (nonatomic, strong) UIButton * confirmBtn;

@end

@implementation ResetPpasswordVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self loadUI];
    
    
}



-(void)loadUI{

    UILabel * pwdLable =[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 70, 50)];
    pwdLable.text = @"新密码";
    pwdLable.font = [UIFont systemFontOfSize:textFont];
    [self.view addSubview:pwdLable];
    
    UITextField * pwdText = [[UITextField alloc]initWithFrame:CGRectMake(pwdLable.current_x_w, pwdLable.current_y, ScreenWidth- pwdLable.current_x_w, pwdLable.current_h)];
    pwdText.placeholder = @"请输入新密码";
    pwdText.secureTextEntry=YES;
    pwdText.clearsOnBeginEditing = YES;

    [pwdText addTarget:self action:@selector(pwdTextClicked:) forControlEvents:UIControlEventAllEditingEvents];
    [pwdText becomeFirstResponder];
   // pwdText.keyboardType=UIKeyboardTypeNumberPad;
    _pwdText =pwdText;
    
    pwdText.font = [UIFont systemFontOfSize:textFont];
    [self.view addSubview:pwdText];
    
    
    
    
    
    
    UILabel * repeatPwdLable = [[UILabel alloc]initWithFrame:CGRectMake(pwdLable.current_x, pwdLable.current_y_h+5, pwdLable.current_w, pwdLable.current_h)];
    repeatPwdLable.text = @"确认密码";
    repeatPwdLable.font =[UIFont systemFontOfSize:textFont];
    [self.view addSubview:repeatPwdLable];
    
    UITextField * repeatPwdText = [[UITextField alloc]initWithFrame:CGRectMake(repeatPwdLable.current_x_w, repeatPwdLable.current_y, ScreenWidth-repeatPwdLable.current_x_w, repeatPwdLable.current_h)];
    repeatPwdText.placeholder = @"请再次输入新密码";
    repeatPwdText.secureTextEntry=YES;
    repeatPwdText.font =[UIFont systemFontOfSize:textFont];
    repeatPwdText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    repeatPwdText.clearsOnBeginEditing = YES;

    [repeatPwdText addTarget:self action:@selector(pwdTextClicked:) forControlEvents:UIControlEventAllEditingEvents];
    _repeatPwdText =repeatPwdText;
    [self.view addSubview:repeatPwdText];

    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(10, repeatPwdText.current_y_h+5, ScreenWidth-20, 20)];
    lable.text = @"提示:密码为6-20位数组或字母，不能包含非法字符";
    lable.font = [UIFont systemFontOfSize:12];
    lable.textColor = [UIColor blueColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.numberOfLines = 0;
    [self.view addSubview:lable];
    
    
    
    UIButton * confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, lable.current_y_h+10, ScreenWidth-60, 50)];
    confirmBtn.userInteractionEnabled=NO;
    confirmBtn.backgroundColor=[UIColor grayColor];
    [confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    _confirmBtn =confirmBtn;
    
    
    
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(pwdLable.current_x, pwdLable.current_y_h, ScreenWidth-2*pwdLable.current_x, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(repeatPwdLable.current_x, repeatPwdLable.current_y_h+2, ScreenWidth-2*repeatPwdLable.current_x, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];


}

-(void)pwdTextClicked:(UITextField *)sender{
    NSLog(@"===%@====%@====",_pwdText.text,_repeatPwdText.text);
    if (_pwdText.text.length >= 6 && _pwdText.text.length <= 20 && _repeatPwdText.text.length >= 6&& _repeatPwdText.text.length <= 20) {
        
        NSLog(@"0000000000---------0000000000");
        _confirmBtn.userInteractionEnabled=YES;
        
        _confirmBtn.backgroundColor=[UIColor orangeColor];
        
    }else{
    
        _confirmBtn.userInteractionEnabled=NO;
        
        _confirmBtn.backgroundColor=[UIColor grayColor];
    }
    if (_pwdText.text.length >20 || _repeatPwdText.text.length > 20) {
        //弹框提示，密码不能多于20位
        
        [[UIEngine sharedInstance] showAlertWithTitle:@"密码不能多于20位,请重新输入" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
        [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            
        };

        
    }
    
    
    
    
}


-(void)confirmBtnClicked:(UIButton *)sender{
//对比字符串

    
    NSLog(@"------");
    
    if ([_pwdText.text isEqualToString:_repeatPwdText.text]) {
        
        
        [self sendRequest];
        
        
        
    }else{
    //弹框提示两次密码不一致
        [[UIEngine sharedInstance] showAlertWithTitle:@"两次密码不一致,请重新输入" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
        [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            
        };
    }
}

-(void)sendRequest{

    NSString *tel=[self.telNumber copy];
    NSString * password = _pwdText.text;
    NSString * tele =[tel stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * sign =[NSString stringWithFormat:@"%@luckin",tele];
    NSDictionary * dic = @{@"tele":tele,
                           @"version":Version,
                           @"authCode":[self.code copy],
                           @"password":password,
                           @"sign":[sign MD5Digest]
                           };


    [SHPNetWorking postRequestWithNSDictionary:dic url:findLoginPwd successBlock:^(NSDictionary *dictionary) {
        
        if ([dic[@"code"]floatValue]==200) {
            [[UIEngine sharedInstance] showAlertWithTitle:dictionary[@"msg"] ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){

                [self.navigationController popToRootViewControllerAnimated:YES];
            };
            
        }else{
        
            [[UIEngine sharedInstance] showAlertWithTitle:dictionary[@"msg"] ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
     
            };
        }
        
    } failureBlock:^(NSError *error) {
        
    }];


}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{





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
