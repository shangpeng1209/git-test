//
//  bankVC.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/28.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

typedef NS_ENUM(NSInteger,FromToType) {
    
    FromToTypeLastPage = 10000,//从前一页进入
    FromToTypeNextPage = 10001,//从后一页返回
};

#import "bankVC.h"
#import "myNameVc.h"


@interface bankVC ()<UITextFieldDelegate,myNameVcDelegate>
{
    UITextField * nameText;
    UITextField * bankNumText;
    UIButton * bankNameBtn;
    UITextField * telNumText;
    UIButton * SubmitBtn;
    NSInteger textTag;
    
    FromToType type;
    
}
@end

@implementation bankVC

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
            [self authenticate];
            
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

    [self authenticate];
    [self loadUI];
    
    
}

-(void)loadUI{


//    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+10, 70, 40)];
//    lable.text = @"持卡人";
//    lable.font = [UIFont systemFontOfSize:14];
//    lable.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:lable];
//    
//    nameText = [[UITextField alloc]initWithFrame:CGRectMake(lable.current_x_w+10, lable.current_y, ScreenWidth-lable.current_y_h-10, lable.current_h)];
//    nameText.font = [UIFont systemFontOfSize:14];
//    nameText.placeholder = @"输入姓名";
//    [nameText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventAllEvents];
//    nameText.autocorrectionType = UITextAutocorrectionTypeDefault;
//    nameText.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    nameText.tag = 1400;
//    [self.view addSubview:nameText];
//    
//    
//    UILabel * bankNumLable = [[UILabel alloc]initWithFrame:CGRectMake(0, lable.current_y_h+10, 70, lable.current_h)];
//    
//    bankNumLable.text = @"银行卡号";
//    bankNumLable.textAlignment = NSTextAlignmentCenter;
//    bankNumLable.font = [UIFont systemFontOfSize:14];
//    [self.view addSubview:bankNumLable];
//    
//    bankNumText = [[UITextField alloc]initWithFrame:CGRectMake(nameText.current_x, bankNumLable.current_y, nameText.current_w, nameText.current_h)];
//    
//    bankNumText.placeholder = @"输入身份证号";
//    bankNumText.font = [UIFont systemFontOfSize:14];
//    bankNumText.autocorrectionType = UITextAutocorrectionTypeDefault;
//    bankNumText.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    bankNumText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    bankNumText.tag = 1401;
//    [bankNumText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventAllEvents];
//    
//    [self.view addSubview:bankNumText];
//    
//    
//    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, lable.current_y_h, ScreenWidth, 1)];
//    
//    line1.backgroundColor = RGBA(237, 237, 237, 1);
//    
//    [self.view addSubview:line1];
//    
//    
//    UILabel * line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, bankNumLable.current_y_h, ScreenWidth, 1)];
//    
//    line2.backgroundColor = RGBA(237, 237, 237, 1);
//    
//    [self.view addSubview:line2];
//    
//    UILabel * payBankLable = [[UILabel alloc]initWithFrame:CGRectMake(0, line2.current_y_h, bankNumLable.current_w, bankNumLable.current_h)];
//    payBankLable.text = @"支付银行";
//    payBankLable.font = [UIFont systemFontOfSize:14];
//    [self.view addSubview:payBankLable];
//    
//    UIButton * payBankBtn = [[UIButton alloc]initWithFrame:CGRectMake(bankNumText.current_x, payBankLable.current_y, bankNumText.current_w, bankNumText.current_h)];
//    [payBankBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [payBankBtn setTitle:@"选择银行卡" forState:UIControlStateNormal];
//    payBankBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    payBankBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    payBankBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    
//    
//    [self.view addSubview:payBankBtn];
//    
//    
//    UILabel * line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, payBankLable.current_y_h, ScreenWidth, 1)];
//    
//    line3.backgroundColor = RGBA(237, 237, 237, 1);
//    
//    [self.view addSubview:line3];
//    
//    
//    UILabel * telLable = [[UILabel alloc]initWithFrame:CGRectMake(0, bankNumLable.current_y_h, bankNumLable.current_w, bankNumLable.current_h)];
//    
//    telLable.text = @"手机号码";
//    
//    [self.view addSubview:telLable];
//    
//
    self.title = @"银行卡";
    //------验证实名认证------
    
    //------------
    NSArray * lableTitles = @[@"持卡人:",@"银行卡号:",@"支付银行:",@"手机号码:"];
    NSArray * textPlaceholder = @[@"输入姓名",@"输入银行卡号",@"选择银行",@"输入手机号码"];
    
    NSInteger tag = 1500;
    
    
    for (int i = 0; i<4; i++) {
        
        if (i == 2) {
            
            UILabel * payBankLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 + i*40, 70, 40)];
            payBankLable.text = lableTitles[i];
            payBankLable.font = [UIFont systemFontOfSize:14];
            [self.view addSubview:payBankLable];
            
            UIButton * payBankBtn = [[UIButton alloc]initWithFrame:CGRectMake(payBankLable.current_x_w+10, payBankLable.current_y, ScreenWidth-payBankLable.current_y_h-10, payBankLable.current_h)];
            [payBankBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [payBankBtn setTitle:@"选择银行卡" forState:UIControlStateNormal];
            payBankBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            payBankBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            payBankBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            //[payBankBtn addTarget:self action:@selector(<#selector#>) forControlEvents:<#(UIControlEvents)#>]
            bankNameBtn = payBankBtn;
            [self.view addSubview:payBankBtn];
            
            UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, payBankBtn.current_y_h, ScreenWidth, 1)];
            line.backgroundColor = RGBA(237, 237, 237, 1);
            [self.view addSubview:line];
            
            
        }else{
        
        
            UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+10+i*40, 70, 40)];
            lable.text = lableTitles[i];
            lable.font = [UIFont systemFontOfSize:14];
            lable.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:lable];
            
            UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(lable.current_x_w+10, lable.current_y, ScreenWidth-lable.current_x_w, lable.current_h)];
            textField.font = [UIFont systemFontOfSize:14];
            textField.placeholder = textPlaceholder[i];
            [textField addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventAllEvents];
            textField.autocorrectionType = UITextAutocorrectionTypeDefault;
            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            textField.tag = tag+i;;
            
            textField.returnKeyType =  UIReturnKeyNext;
            
            textField.delegate =self;
            [self.view addSubview:textField];
            
            UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, textField.current_y_h, ScreenWidth, 1)];
            line.backgroundColor = RGBA(237, 237, 237, 1);
            [self.view addSubview:line];
            
            
            
        }
    }
    
    
    SubmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 64+10+4*40+10, ScreenWidth-40, 50)];
    SubmitBtn.backgroundColor = [UIColor orangeColor];
    [SubmitBtn addTarget:self action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
    [SubmitBtn setTitle:@"提交认证" forState:UIControlStateNormal];
    [SubmitBtn.layer setMasksToBounds:YES];
    [SubmitBtn.layer setCornerRadius:6.0];
    
   
    
    
    [self.view addSubview:SubmitBtn];
    
    
    
    
    nameText = (UITextField *)[self.view viewWithTag:1500];
    bankNumText = (UITextField *)[self.view viewWithTag:1501];
    telNumText = (UITextField *)[self.view viewWithTag:1503];
    nameText.text = [Helper translateStr:self.nameDic[@"userName"]];
    [bankNameBtn setTitle:[Helper translateStr:self.bankDic[@"bankName"]] forState:UIControlStateNormal];
    bankNumText.text =[Helper translateStr:self.bankDic[@"bankNum"]];
    telNumText.text =[Helper translateStr:self.bankDic[@"phone"]];
    
    
    
}

-(void)authenticate{

    /**1、验证实名认证*/
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    
    NSDictionary * dic = @{@"token":token,
                           @"version":Version};
    [SHPNetWorking postRequestWithNSDictionary:dic url:checkUserName successBlock:^(NSDictionary *dictionary) {
        
        NSLog(@"验证实名认证 = %@",dictionary);
       // checkName = YES;
        
        if ([dictionary[@"code"]floatValue] == 200) {
            
            NSDictionary * dic = dictionary[@"data"];
            self.nameDic = dic;
            if ([dic[@"status"]floatValue] == 0) {
                [[UIEngine sharedInstance] showAlertWithTitle:@"您还未进行实名认证，请先认证" ButtonNumber:2 FirstButtonTitle:@"前往认证" SecondButtonTitle:@"返回首页"];
                
                
                [UIEngine sharedInstance].alertClick = ^ (int aIndex){
                    //点解确认按钮，事件处理
                    
                    if (aIndex == 10086) {
                        myNameVc * myname = [[myNameVc alloc]init];
                        myname.title = @"实名认证";
                        myname.nameDic = dic;
                        myname.type = NameTypeName;
                        myname.delegate = self;
                        type = FromToTypeNextPage;
                        [self.navigationController pushViewController:myname animated:YES];
                    }else if(aIndex == 10087){
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                    
                    
                    return;
                };

                
                
            }
            
            else{
            
                NSString * userName = [Helper translateStr:dictionary[@"data"][@"userName"]];
                nameText.text = userName;
            
            }
            
            
        }
       
        
    } failureBlock:^(NSError *error) {
        
        
        
    }];



}


-(void)TextChange:(UITextField *)sender{
    
    UITextField * text =(UITextField *) [self.view viewWithTag:sender.tag];
    textTag = sender.tag;
    NSString * currentText = [text.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    text.text=currentText;
    
    
    if (textTag == 1503) {
        text.returnKeyType =  UIReturnKeyDone;

    }
    
    
    //只有手机号做本地判断
    
    
}

-(void)Submit:(UIButton *)sender{
    
   
    NSString * alert;
    
    if (nameText.text.length<2) {
        
        alert = @"持卡人姓名填写不正确";
        
    }else if (bankNumText.text.length < 5){
        alert = @"银行卡号填写不正确";

    }else if ([bankNameBtn.titleLabel.text isEqualToString:@"选择银行卡"]){
        alert = @"请选择银行";

    }else if ([SHPNetWorking valiMobile:telNumText.text] == NO){
        alert = @"手机号码格式不正确，请重新填写";
    
    }else{
    
    
    }
    if (alert) {
        
        [[UIEngine sharedInstance] showAlertWithTitle:alert ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
        [UIEngine sharedInstance].alertClick = ^ (int aIndex){
        };
        
        return;
    }
    
    [self loadRequest];
    



}





-(void)loadRequest{

    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    
    token = [Helper translateStr:token];
    
    NSString * bankNum = bankNumText.text;
    NSLog(@"bankNum = %@",telNumText.text);
    NSString * bankName = bankNameBtn.titleLabel.text;
    ///promotion/getPromoteIdByToken
    
    NSDictionary * dic= @{@"token":token,
                          @"bankNum":bankNum,
                          @"bankName":bankName,
                          @"phone":telNumText.text,
                          @"version":Version};

    [SHPNetWorking postRequestWithNSDictionary:dic url:bindBank successBlock:^(NSDictionary *dictionary) {
        
        NSLog(@"dictionary = %@",dictionary);
        [[UIEngine sharedInstance] showAlertWithTitle:dictionary[@"msg"] ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
        [UIEngine sharedInstance].alertClick = ^ (int aIndex){
            
        };
        
        
        
    } failureBlock:^(NSError *error) {
        
    } ];


}

#pragma mark -- 从实名认证页认证完成跳转
-(void)myNameVcSenderDictionary:(NSDictionary *)value{
    
//    NSString * userName = [Helper translateStr:value[@"userName"]];
//    nameText.text = userName;

}




//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 1500) {
        //换行
        NSLog(@"换行");
        UITextField * textfiled1 = [self.view viewWithTag:1501];
        NSLog(@"textfiled1 = %@",textfiled1.text);
        [textfiled1  becomeFirstResponder ];
        NSLog(@"[textfiled1  becomeFirstResponder ] = %d",[textfiled1  becomeFirstResponder ]);
        return NO;
    }else if (textField.tag == 1501) {
        //换行
        
        UITextField * textfiled = [self.view viewWithTag:1503];
        [textfiled becomeFirstResponder];
        
        return NO;
        
    }else if (textField.tag == 1503) {
    
        [self Submit:SubmitBtn];
        
        return YES;
    }

    
    
    
    //[textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    
    UITextField * textfiled = [self.view viewWithTag:textTag];
    [textfiled resignFirstResponder];
    

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
