//
//  ViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "ViewController.h"
#import "AccountViewController.h"
#import "HomeViewController.h"

#import "marketViewController.h"
#import "informationViewController.h"
#import "findViewController.h"

#import "detailViewController.h"

@interface ViewController ()<UITabBarDelegate,UITabBarControllerDelegate>
{
    UIView * view;
    BOOL change;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UILabel * LABL = [[UILabel alloc]init];
//    LABL.text = LoginURL;
    

    
    
    HomeViewController * market = [[HomeViewController alloc]init];
    CustumViewController * marketNav = [[CustumViewController alloc]initWithRootViewController:market];
    marketNav.tabBarItem.image=[UIImage imageNamed:@"tab_icon_home_nor"];
    
    UIImage *evaluatingImage=[UIImage imageNamed:@"tab_icon_home_hov"];
    marketNav.tabBarItem.selectedImage=[evaluatingImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    market.title =@"首页";
    
    informationViewController * information = [[informationViewController alloc]init];
    CustumViewController * informationNav = [[CustumViewController alloc]initWithRootViewController:information];
    informationNav.tabBarItem.image=[UIImage imageNamed:@"tab_icon_new_nor"];
    
    UIImage *infoImage=[UIImage imageNamed:@"tab_icon_new_hov"];
    informationNav.tabBarItem.selectedImage=[infoImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    information.title =@"资讯";
    
    
    findViewController * find = [[findViewController alloc]init];
    CustumViewController * findNav = [[CustumViewController alloc]initWithRootViewController:find];
    findNav.tabBarItem.image=[UIImage imageNamed:@"tab_icon_live_nor"];
    
    UIImage *findImage=[UIImage imageNamed:@"tab_icon_live_hov"];
    findNav.tabBarItem.selectedImage=[findImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    find.title =@"直播";
    
    AccountViewController * account=[[AccountViewController alloc]init];
    CustumViewController *accountNav=[[CustumViewController alloc]initWithRootViewController:account];
    account.title=@"账户";
    
    
    self.viewControllers = @[marketNav,findNav,informationNav,accountNav];
   
    
    
    //[[self.tabBar.items objectAtIndex:2] setBadgeValue:@"10"];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSArray * array = [[UIApplication sharedApplication] windows];
    
    if (array.count >= 2) {
        
        window = [array objectAtIndex:1];
        
    }
    
    view = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/8*3+ScreenWidth/32-3.5,6, 7, 7)];
    
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:3.5];
    
    
    
    view.backgroundColor = [UIColor grayColor];
    change = NO;
    
    UIView * redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    redView.backgroundColor = [UIColor redColor];
    
    [self.tabBar addSubview:view];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(push) name:@"goto" object:nil];

    
    
    self.delegate =self;
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(ontimer) userInfo:nil repeats:YES];
    
    [timer fire];
    

   // self.selectedIndex = 3;
    //[self addChildViewController:accountNav];
    //self.tabBar.delegate =self;
}

-(void)push{

    NSLog(@"viewPush");
    
    //CustumViewController * nav = self.viewControllers[self.selectedIndex];
    detailViewController * dd = [[detailViewController alloc]init];
    [self.viewControllers[self.selectedIndex] pushViewController:dd animated:YES];

}

-(void)ontimer{
    if (change) {
        view.backgroundColor = [UIColor grayColor];
        change=NO;
    }else{
    
    view.backgroundColor = [UIColor redColor];
        change=YES;

    }
}




- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
   
    if([viewController.tabBarItem.title isEqualToString:@"资讯"])
    {
//        [UIEngine sharedInstance].progressStyle=2;
//        [[UIEngine sharedInstance]showProgress];
    }
    return YES;
}

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray<UITabBarItem *> *)items {


}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    
    NSLog(@"--");
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
