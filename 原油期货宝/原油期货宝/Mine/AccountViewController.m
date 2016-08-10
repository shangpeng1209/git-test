//
//  AccountViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "AccountViewController.h"

#import "loginViewController.h"
#import "registerViewController.h"

#import "HeadPortraitView.h"
#import "accountHomeView.h"
#import "setUpViewController.h"
#import "NewsViewController.h"
#import "detailViewController.h"
#import "tableHeaderView.h"

#import "certificationVC.h"

#import "RechargeVC.h"


@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,HeadPortraitViewDelegate>
{
    UIView * _backView;

    tableHeaderView * _headerView;
    UITableView * _tableView;
    

}

@property (nonatomic, strong) accountHomeView * home;
@property (nonatomic, strong) HeadPortraitView * head;
@property (nonatomic, strong) UITableView *tabview;
@end

@implementation AccountViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden = NO;
    [self getInfo];
    
    
    
    
    
    //[self loadLandUI];
     //[self LoadLandedUI];


    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // [self loadLandUI];

    float h = (float)200.0/667.0* [UIScreen mainScreen].bounds.size.height;
    
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, h-20, ScreenWidth, ScreenHeigth-h+20) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate =self;
    tableView.dataSource = self;
    _tabview = tableView;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(push) name:@"goto" object:nil];
    
    
}


-(void)push{

    NSLog(@"push");


}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 0.3f;
}



//加载 登陆界面UI
-(void)loadLandUI{
    
    
    
    if (_head) {
        [_head removeFromSuperview];
        _head = nil;
    }
    
    
    float h = (float)200.0/667.0* [UIScreen mainScreen].bounds.size.height;

    accountHomeView * home = [[accountHomeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)];
    _home = home;
    home.backgroundColor = [UIColor redColor];
    
    home.btnClick=^(UIButton * sender){
    

        if (sender.tag == 1000) {
            //跳转到登录界面
            loginViewController * loginView = [[loginViewController alloc]init];
            
            [self.navigationController pushViewController:loginView animated:YES];
            
        }else if (sender.tag == 1001){
        //跳转到注册界面
        
            registerViewController * registerView = [[registerViewController alloc]init];
            
            [self.navigationController pushViewController:registerView animated:YES];

        }
    
    
    };
    
    //btn tag = 1201
    [home.setBtn addTarget:self action:@selector(setBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:home];
    

    
    
    
}


//加载登陆完成后UI
-(void)LoadLandedUI{
    
    if (_home) {
        [_home removeFromSuperview];
        _home = nil;
    }
    float h = (float)200.0/667.0* [UIScreen mainScreen].bounds.size.height;

    HeadPortraitView * head =[[HeadPortraitView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)];
    _head = head;
    head.delegate = self;
    NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:UserInfo];
    NSDictionary * dic = [Helper returnDictionaryWithData:data];
    
    
    [head setViewWithDic:dic];
    [head.setBtn addTarget:self action:@selector(setBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:head];

}

#pragma  mark -- 设置按钮
-(void)setBtnClicked:(UIButton *)sender{

    setUpViewController * setUp =[[setUpViewController alloc]init];
    
    if (sender.tag == 1201) {
        
        setUp.type = homeType;
    }else if (sender.tag ==1202 ){
        setUp.type = headType;

    }else{
    
    }
    
    
    [self.navigationController pushViewController:setUp animated:YES];
    
    

}



//
#pragma mark -- 登陆完成获取 积分现金信息
-(void)getInfo{

    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    
    
    //再加一个网络判断
    if (token == nil || [token isEqualToString:@""]) {
        
        [self loadLandUI];
        
    }else{
    
        NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
        if (token == nil) {
            token = @"";
        }
        
        NSLog(@"token = %@",token);
        
        NSDictionary * dic = @{@"token":token,
                               @"version":Version};

        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [SHPNetWorking postRequestWithNSDictionary:dic url:currentOrderList successBlock:^(NSDictionary *dictionary) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            
            NSString * landAgain = [[NSUserDefaults standardUserDefaults]objectForKey:LandAgain];
            
            
            
            if (landAgain == nil || [landAgain isEqualToString:@""]||[landAgain isEqualToString:@"YES"]) {
                //加载登录界面
                NSLog(@"加载登录界面");
                if (_headerView) {
                [_headerView removeFromSuperview];
                UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
                _tableView.tableHeaderView = view;
                  
                }
                
                [self loadLandUI];
                
            }else if([landAgain isEqualToString:@"NO"]){
                //加载登录完成界面
                NSLog(@"加载登录完成界面");
                if (_headerView) {
                    [_headerView removeFromSuperview];
                }
                [self LoadLandedUI];
                [self setUpTableHeaderView];
                [_headerView loadRequest];
                
            }
            
            
            
            
        } failureBlock:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            
            
            [self loadLandUI];
            
            [[UIEngine sharedInstance] showAlertWithTitle:@"加载失败，稍后重试" ButtonNumber:1 FirstButtonTitle:@"确定" SecondButtonTitle:@""];
            [UIEngine sharedInstance].alertClick = ^ (int aIndex){
                
            };
            
        }];
    
    }
    




}
#pragma mark -- 头像点击事件
-(void)headPortraitViewTap{

    certificationVC * certifi = [[certificationVC alloc]init];
    
    [self.navigationController pushViewController:certifi animated:YES];


}




#pragma mark -- tableHeaderView

-(void)setUpTableHeaderView{

//    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
//    
//    
//    headerView.backgroundColor = [UIColor yellowColor];
    
    
    tableHeaderView * headerView = [[tableHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    _headerView = headerView;
    headerView.btnClick = ^(UIButton * sender){
    
        NSString * landAgain = [[NSUserDefaults standardUserDefaults]objectForKey:LandAgain];

        if ([landAgain isEqualToString:@"YES"]||landAgain==nil) {
            loginViewController * login = [[loginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            
            return;
        }
        
        if (sender.tag == 1300) {
            NSLog(@"进入充值页面");
            RechargeVC * recharge = [[RechargeVC alloc]init];
            recharge.title = @"充值";
            [self.navigationController pushViewController:recharge animated:YES];
            
            
        }else if (sender.tag == 1301){
        
        
        }
        
    
    };
    
    
    _tabview.tableHeaderView = headerView;
    


}




#pragma mark - Table view data source 返回分区数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    return 4;
}

#pragma mark --返回行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0 || section == 3) {
        return 1;
    }else if (section == 1 || section == 2){
    
        return 2;
    }
    
    
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid=@"mycell";

    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellid];

    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }

    if (indexPath.section == 0) {
        cell.textLabel.text = @"消息中心";
    }else if (indexPath.section == 1){
    
        if (indexPath.row == 0) {
            cell.textLabel.text = @"资金明细";

        }else if (indexPath.row == 1){
            cell.textLabel.text = @"积分明细";

        }
    
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"个人信息";
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"推广赚钱";
            
            
        }
    
    }
    else if(indexPath.section == 3){
        cell.textLabel.text = @"关于我们";

    }else{
        cell.textLabel.text = @"test";

    
    }
   // cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString * landAgain = [[NSUserDefaults standardUserDefaults]objectForKey:LandAgain];
    
    if (indexPath.section == 0) {
        NewsViewController * newsVC = [[NewsViewController alloc]init];
        newsVC.NewsType = NewsTypeDefault;
        [self.navigationController pushViewController:newsVC animated:YES];
        return;
    }

    
    if ([landAgain isEqualToString:@"YES"]||landAgain==nil) {
        loginViewController * login = [[loginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
        return;
    }

    if (indexPath.section == 1) {
        
        
        
        
        detailViewController * vc = [[detailViewController alloc]init];
        vc.urlType = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            certificationVC * certifi = [[certificationVC alloc]init];
            
            [self.navigationController pushViewController:certifi animated:YES];
            
            
        }
        
        
    }
    
    


}

-(void)loadRequestWithSection:(NSInteger)section{






}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
//    headerView.backgroundColor = [UIColor redColor];
//
//    return headerView;
//}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    footView.backgroundColor = RGBA(237, 237, 237, 1);
    
    return footView;


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
