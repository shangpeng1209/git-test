//
//  certificationVC.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/26.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "certificationVC.h"
#import "myNameVc.h"
#import "bankVC.h"
@interface certificationVC ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
{
    BOOL checkName;
    BOOL checkBank;
    BOOL checkTeleNum;
    BOOL checkNick;
    NSDictionary * nameDic ;
    NSDictionary * bankDic;
    NSDictionary * teleNumDic;
    NSDictionary * nickDic;
    
    
    UITableView * _tableView;
    
    NSMutableArray * titles;
    
    BOOL refresh;
    
    
}

@end


@implementation certificationVC



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;
    if (refresh) {
        [self loadRequest];
        refresh = NO;
    }

}



-(void)viewDidLoad{

    [super viewDidLoad];
    
    
    NSArray * nickArr = @[@"昵称"];
    NSArray * arr = @[@"实名认证",@"银行卡",@"手机认证"];
    
    titles = [NSMutableArray arrayWithObjects:nickArr,arr, nil];
    refresh =NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self Notification];
    [self loadRequest];

    
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth-64) style:UITableViewStyleGrouped];
    
   //  = [[UITableView alloc]initWithFrame:CGRectMake(0, h-20, ScreenWidth, ScreenHeigth-h+20) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate =self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    

    
    [self.view addSubview:tableView];

}


#pragma mark -- tableView方法

#pragma mark - Table view data source 返回分区数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return titles.count;
}

#pragma mark --返回行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * arr = titles[section];
    
    
    return arr.count;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid=@"mycell";
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    
   
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    cell.imageView.frame = CGRectMake(0, 0, 30, 30);
    [cell.imageView setImage:[UIImage imageNamed:@"shareIcon"]];

    
//    cell.imageView.layer.masksToBounds = YES;
//    cell.imageView.layer.cornerRadius = 30;
    
    NSArray * arr = titles[indexPath.section];

    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 0) {
        //关闭cell的交互
       // cell.userInteractionEnabled =NO;
        if (nickDic) {
            NSString * str=nickDic[@"nick"];
            cell.detailTextLabel.text = str;
            if ([nickDic[@"nickStatus"]floatValue]==1) {
                //不可修改
                cell.userInteractionEnabled =NO;
                //关闭右侧>符号
                cell.accessoryType= UITableViewCellAccessoryNone;
            }
            
            
            
        }

    }else if(indexPath.section == 1){
    
        if (indexPath.row == 0) {
            
            if (nameDic) {
                
                //实名认证 status  1:已绑定，不可改；0:未填写；2:已填写，可修改

                NSString * str=nameDic[@"status"];
                NSInteger value =[str floatValue];
                NSLog(@"str = %@",nameDic);
                if (value == 0) {
                    cell.detailTextLabel.text = @"未认证";

                }else{
                    if (value == 1) {
                        cell.detailTextLabel.text = @"已认证";
                        //不可修改
                        cell.userInteractionEnabled =NO;
                        //关闭右侧>符号
                        cell.accessoryType= UITableViewCellAccessoryNone;

                    }
                    else{
                    
                        cell.detailTextLabel.text = @"已填写";

                    }
                }
            }
            
            
        }
        else if (indexPath.row == 1){
        //银行卡 status  1:已绑定，不可改；0:未填写；2:已填写，可修改
            NSString * str=bankDic[@"status"];
            NSInteger value =[str floatValue];
            if (value == 0) {
                cell.detailTextLabel.text = @"未绑定";

            }else{
                if (value == 1) {
                    cell.detailTextLabel.text = @"已绑定";

                    //不可修改
                    cell.userInteractionEnabled =NO;
                    //关闭右侧>符号
                    cell.accessoryType= UITableViewCellAccessoryNone;
                    
                }else{
                    cell.detailTextLabel.text = @"已填写";

                }
            }
        }else if (indexPath.row == 2){
            
            //手机号 status  1:已绑定，不可改；0:未填写；2:已填写，可修改
            NSString * str=teleNumDic[@"status"];
            NSInteger value =[str floatValue];
            if (value == 0) {
                cell.detailTextLabel.text = @"未绑定";
                
            }else{
                
                NSString * tel = teleNumDic[@"tele"];
                cell.detailTextLabel.text = tel;
                if (value == 1) {
                    //不可修改
                    cell.userInteractionEnabled =NO;
                    //关闭右侧>符号
                    cell.accessoryType= UITableViewCellAccessoryNone;
                    
                }
                
                
            }
            
            
        }
    
    
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    refresh = YES;
    
    NSLog(@"tableViewdidSelect");
    if (indexPath.section == 0 ) {
        //昵称修改
        //[self changeNickName];
        myNameVc * myname = [[myNameVc alloc]init];
        myname.title = @"修改昵称";
        myname.type = NameTypeNick;
        myname.nameDic = nameDic;
        [self.navigationController pushViewController:myname animated:YES];
        
    }
    if (indexPath.section ==1) {
        if (indexPath.row == 0) {
            //实名认证
            myNameVc * myname = [[myNameVc alloc]init];
            myname.title = @"实名认证";
            myname.nameDic = nameDic;
            myname.type = NameTypeName;

            [self.navigationController pushViewController:myname animated:YES];
            
        }else if (indexPath.row == 1){
        //银行卡
            
            if ([nameDic[@"status"]floatValue]==0) {
                
                [[UIEngine sharedInstance] showAlertWithTitle:@"您还未进行实名认证，请先认证" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
                [UIEngine sharedInstance].alertClick = ^ (int aIndex){
                    
                    myNameVc * myname = [[myNameVc alloc]init];
                    myname.title = @"实名认证";
                    myname.nameDic = nameDic;
                    myname.type = NameTypeName;
                    
                    [self.navigationController pushViewController:myname animated:YES];

                    
                };
                
                return;
            }
            
            
            bankVC *bank = [[bankVC alloc]init];
            bank.bankDic = bankDic;
            bank.nameDic = nameDic;
            bank.title = @"";
            [self.navigationController pushViewController:bank animated:YES];

            
        
        }else if (indexPath.row == 2){
        //电话号码
        
            
        
        }
    }
    
    


}




#pragma mark -----------END-----------

#pragma mark -- 修改昵称

-(void)changeNickName{


    UIView * backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.8;
    [self.view addSubview:backView];
    
    
    
    
    UIView * nickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-30, 150)];
    nickView.center = self.view.center;
    
    UILabel *  titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,nickView.current_w, 40)];
    
    titleLable.text = @"修改昵称";
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    [nickView addSubview:titleLable];

    
    
    UITextField * text= [[UITextField alloc]initWithFrame:CGRectMake(20, 50, nickView.current_w-40, 30)];
    
    text.placeholder = @"昵称只能修改一次";
   // text.center = self.view.center;
    [nickView addSubview:text];
    
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, nickView.current_h-40, nickView.current_w/2-1, 40)];
    sureBtn.backgroundColor = [UIColor redColor];
    [nickView addSubview:sureBtn];
    
    UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(sureBtn.current_x_w +2, sureBtn.current_y, sureBtn.current_w, sureBtn.current_h)];
    cancelBtn.backgroundColor = [UIColor redColor];
    [nickView addSubview:cancelBtn];
    
    
    
    nickView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:nickView];
    
    
    


}






#pragma mark -- 请求数据
-(void)loadRequest{

    
    
// 加载三个请求 再加一个 修改昵称
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    
    NSDictionary * dic = @{@"token":token,
                           @"version":Version};
    //
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
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
            
            NSDictionary * dic = dictionary[@"data"];
            
            bankDic = [NSDictionary dictionaryWithDictionary:dic];
            
        }
        //请求成功，发送通知，以便事件处理

        [[NSNotificationCenter defaultCenter]postNotificationName:requestSuccess object:nil userInfo:nil];

    } failureBlock:^(NSError *error) {

        
        
        
    }];
    
    /**3、验证手机号*/
    [SHPNetWorking postRequestWithNSDictionary:dic url:checkTele successBlock:^(NSDictionary *dictionary) {
        
        NSLog(@"验证手机号 = %@",dictionary);
        checkTeleNum = YES;

        if ([dictionary[@"code"]floatValue] == 200) {
            
            NSDictionary * dic = dictionary[@"data"];
            
            teleNumDic = [NSDictionary dictionaryWithDictionary:dic];
            
        }
        //请求成功，发送通知，以便事件处理

        [[NSNotificationCenter defaultCenter]postNotificationName:requestSuccess object:nil userInfo:nil];

    } failureBlock:^(NSError *error) {
        
       
        
        
    }];
    
    
    /**4、验证昵称*/
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:checkNickChange successBlock:^(NSDictionary *dictionary) {
        
        NSLog(@"验证昵称 = %@",dictionary);
        checkNick = YES;
        
        if ([dictionary[@"code"]floatValue] == 200) {
            
            NSDictionary * dic = dictionary[@"data"];
            
            nickDic = [NSDictionary dictionaryWithDictionary:dic];
            
            
        }
        //请求成功，发送通知，以便事件处理
        [[NSNotificationCenter defaultCenter]postNotificationName:requestSuccess object:nil userInfo:nil];
        
    } failureBlock:^(NSError *error) {
        
        
        
    }];
    



}



//判断request是否加载完

-(BOOL)requestIsDown{

    if (checkName && checkBank && checkTeleNum && checkNick) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        return YES;
    }

    return NO;
}




#pragma mark -- 通知方法
-(void)loadSuccess:(NSNotification *)sender{
    if ([self requestIsDown]) {
        //1、请求全部完成
        NSLog(@"请求全部完成，隐藏MBprograss");
        //2、刷新tableView
        [_tableView reloadData];
        
        [[UIEngine sharedInstance] hideProgress];

        
        
    }
}


-(void)tokenOver:(NSNotification *)sender{
    
    //token过期 隐藏MBprograss
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)loadFaild:(NSNotification *)sender{
    //加载失败 隐藏MBprograss
    [MBProgressHUD hideHUDForView:self.view animated:YES];


    [[UIEngine sharedInstance] showAlertWithTitle:@"加载失败，请稍后重试" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
    [UIEngine sharedInstance].alertClick = ^ (int aIndex){
        [self.navigationController popViewControllerAnimated:YES];

        
    };

}
#pragma mark -----------END-----------



#pragma mark -- 通知创建与销毁
-(void)Notification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tokenOver:) name:tokenOverValue object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadFaild:) name:requestFaild object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadSuccess:) name:requestSuccess object:nil];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:tokenOverValue object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:requestFaild object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:requestSuccess object:nil];

}
#pragma mark -----------END-----------

@end
