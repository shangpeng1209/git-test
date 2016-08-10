//
//  myNameVc.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/27.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "myNameVc.h"

@interface myNameVc ()
{
    UITextField * nameText;
    UITextField * cardNumText;
    UITextField * nickText;
    UIButton * checkNameBtn;
    UIButton * checkNickBtn;
    

}
@end

@implementation myNameVc
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.type == 0) {
        
        [self changeNick];
        
    }else if (self.type == 1){
    

    [self changeName];

    
    }
    
    //[self changeName];
    
   // [self changeNick];
    
}

#pragma mark -- 昵称修改页
-(void)changeNick{
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 70, 40)];
    lable.text = @"昵称";
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    nickText = [[UITextField alloc]initWithFrame:CGRectMake(lable.current_x_w+10, lable.current_y, ScreenWidth-lable.current_y_h-10, lable.current_h)];
    nickText.font = [UIFont systemFontOfSize:14];
    nickText.placeholder = @"输入昵称";
    [nickText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventAllEvents];
    nickText.autocorrectionType = UITextAutocorrectionTypeDefault;
    nickText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    nickText.tag = 1402;
    [self.view addSubview:nickText];
    
    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, lable.current_y_h, ScreenWidth, 1)];
    
    line1.backgroundColor = RGBA(237, 237, 237, 1);
    
    [self.view addSubview:line1];
    
    UILabel * promptLable = [[UILabel alloc]initWithFrame:CGRectMake(10, line1.current_y_h+5, ScreenWidth-20, 40)];
    promptLable.text = @"提示:一张身份证只能绑定一个账号，请填写本人真实信息，核实后将不可更改";
    promptLable.font = [UIFont systemFontOfSize:12];
    promptLable.textColor = [UIColor redColor];
    promptLable.numberOfLines=0;
    [self.view addSubview:promptLable];
    
    checkNickBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, promptLable.current_y_h+20, ScreenWidth-40, nickText.current_h)];
    [checkNickBtn setTitle:@"确定" forState:UIControlStateNormal];
    checkNickBtn.userInteractionEnabled=NO;
    
    checkNickBtn.backgroundColor=[UIColor grayColor];
    [checkNickBtn addTarget:self action:@selector(authNick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:checkNickBtn];
}

#pragma mark -- 实名认证
-(void)changeName{
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 70, 40)];
    lable.text = @"姓名";
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    
    nameText = [[UITextField alloc]initWithFrame:CGRectMake(lable.current_x_w+10, lable.current_y, ScreenWidth-lable.current_y_h-10, lable.current_h)];
    nameText.font = [UIFont systemFontOfSize:14];
    nameText.placeholder = @"输入姓名";
    [nameText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventAllEvents];
    nameText.autocorrectionType = UITextAutocorrectionTypeDefault;
    nameText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    nameText.tag = 1400;
    [self.view addSubview:nameText];
    
    
    UILabel * cardNumLable = [[UILabel alloc]initWithFrame:CGRectMake(0, lable.current_y_h+10, 70, lable.current_h)];
    
    cardNumLable.text = @"身份证号";
    cardNumLable.textAlignment = NSTextAlignmentCenter;
    cardNumLable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:cardNumLable];
    
    cardNumText = [[UITextField alloc]initWithFrame:CGRectMake(nameText.current_x, cardNumLable.current_y, nameText.current_w, nameText.current_h)];
    
    cardNumText.placeholder = @"输入身份证号";
    cardNumText.font = [UIFont systemFontOfSize:14];
    cardNumText.autocorrectionType = UITextAutocorrectionTypeDefault;
    cardNumText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    cardNumText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    cardNumText.tag = 1401;
    [cardNumText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventAllEvents];

    [self.view addSubview:cardNumText];
    
    
    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, lable.current_y_h, ScreenWidth, 1)];
    
    line1.backgroundColor = RGBA(237, 237, 237, 1);
    
    [self.view addSubview:line1];
    
    
    UILabel * line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, cardNumLable.current_y_h, ScreenWidth, 1)];
    
    line2.backgroundColor = RGBA(237, 237, 237, 1);
    
    [self.view addSubview:line2];
    
    UILabel * promptLable = [[UILabel alloc]initWithFrame:CGRectMake(10, line2.current_y_h+5, ScreenWidth-20, 40)];
    promptLable.text = @"提示:一张身份证只能绑定一个账号，请填写本人真实信息，核实后将不可更改";
    promptLable.font = [UIFont systemFontOfSize:12];
    promptLable.textColor = [UIColor redColor];
    promptLable.numberOfLines=0;
    [self.view addSubview:promptLable];
    
    
    checkNameBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, promptLable.current_y_h+20, ScreenWidth-40, cardNumLable.current_h)];
    [checkNameBtn setTitle:@"确定" forState:UIControlStateNormal];
    checkNameBtn.userInteractionEnabled=NO;
    
    checkNameBtn.backgroundColor=[UIColor grayColor];
    [checkNameBtn addTarget:self action:@selector(authName:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:checkNameBtn];
    
    
    
    NSString * idCardNum = [Helper translateStr:self.nameDic[@"idCardNum"]];
    cardNumText.text = idCardNum;
    
    NSString * userNmae =[Helper translateStr:self.nameDic[@"userName"]];
    nameText.text = userNmae;
    
}


-(void)TextChange:(UITextField *)sender{

    if (sender.tag == 1400) {
        NSString * text = [Helper trim:sender.text];
        
        nameText.text = text;
        if (text.length > 1) {
            
            [self loginBtnCanSelsected:YES];
            
        }else{
            
            [self loginBtnCanSelsected:NO];
            
        }
    }else if (sender.tag == 1401){
    
        NSString * text = [Helper trim:sender.text];
        
        cardNumText.text = text;
        if (text.length == 18) {
            [self loginBtnCanSelsected:YES];
            
        }else{
            [self loginBtnCanSelsected:NO];
            
        }
        
    }
    
    
    
    
    //昵称
    if(sender.tag == 1402){
    
        NSString * nick = [Helper translateStr:sender.text];
    
        nickText .text= nick;
        
        if (nick.length >1) {
            checkNickBtn.userInteractionEnabled=YES;
            
            checkNickBtn.backgroundColor=[UIColor orangeColor];
        }else{
        
            checkNickBtn.userInteractionEnabled=NO;
            
            checkNickBtn.backgroundColor=[UIColor grayColor];
        }
    }
    
   
    
    

}

#pragma mark -- 判断按钮是否可点击
-(void)loginBtnCanSelsected:(BOOL)selected
{
    if (selected) {
        checkNameBtn.userInteractionEnabled=YES;
        
        checkNameBtn.backgroundColor=[UIColor orangeColor];
        
    }else{
        checkNameBtn.userInteractionEnabled=NO;
        
        checkNameBtn.backgroundColor=[UIColor grayColor];
        
        
    }
    
    
}

#pragma mark -- 实名认证
-(void)authName:(UIButton *)sender{
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    if (token == nil ) {
        
        token = @"";
        
    }
    NSString * realName = nameText.text;
    
    NSString * card = [Helper translateStr:cardNumText.text];
   
    
    
    NSDictionary * dic = @{@"token":token,
                           @"realName":realName,
                           @"idCard":card,
                           @"version":Version};
    [SHPNetWorking postRequestWithNSDictionary:dic url:authUser successBlock:^(NSDictionary *dictionary) {
        
        
        if ([dictionary[@"code"]floatValue] == 200 ) {
            [[UIEngine sharedInstance] showAlertWithTitle:dictionary[@"msg"] ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            };
            
        }else  {
            [[UIEngine sharedInstance] showAlertWithTitle:dictionary[@"msg"] ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){

            
            
            };
            
        }
        //41011
        
        
        
    } failureBlock:^(NSError *error) {
        
    }];

    

}


#pragma mark -- 修改昵称
-(void)authNick:(UIButton *)sender{

    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    if (token == nil ) {
        
        token = @"";
        
    }
    NSString * realName = [Helper translateStr:nickText.text];
    
    
    NSDictionary * dic = @{@"token":token,
                           @"nick":realName,
                           @"version":Version};


    [SHPNetWorking postRequestWithNSDictionary:dic url:updUserNick successBlock:^(NSDictionary *dictionary) {
        
        
        if ([dictionary[@"code"]floatValue] == 200 ) {
            [[UIEngine sharedInstance] showAlertWithTitle:dictionary[@"msg"] ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
                
                [self.delegate myNameVcSenderDictionary:dictionary[@"data"]];
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
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


    [nameText resignFirstResponder];
    [cardNumText resignFirstResponder];
    [nickText resignFirstResponder];

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
