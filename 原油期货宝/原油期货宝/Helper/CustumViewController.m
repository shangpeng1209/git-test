//
//  CustumViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/1.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "CustumViewController.h"

@interface CustumViewController ()

@end

@implementation CustumViewController



+ (void)initialize {
    // 1.appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    [navigationBar setBarTintColor:[UIColor yellowColor]];
    [navigationBar setTintColor:[UIColor whiteColor]];// iOS7的情况下,设置NavigationBarItem文字的颜色
    // 3.设置导航栏文字的主题
    NSShadow *shadow = [[NSShadow alloc]init];
    [shadow setShadowOffset:CGSizeZero];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                            NSShadowAttributeName : shadow}];
    //    [navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_cell_bg_selected"] forBarMetrics:UIBarMetricsDefault];
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
        //k IsIOS7OrMore
        [barButtonItem setTintColor:[UIColor whiteColor]];
    }else {
        // 修改item的背景图片
        //[barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        //[barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        // 修改item上面的文字样式
        NSDictionary *dict =@{NSForegroundColorAttributeName : [UIColor whiteColor],
                              NSShadowAttributeName : shadow};
        [barButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
        [barButtonItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    }
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#0e2947"]] forBarMetrics:UIBarMetricsDefault];
    //修改返回按钮样式
    //    [barButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    // 5.设置状态栏样式
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor colorWithHexString:@"#fefefe"] forKey:NSForegroundColorAttributeName];
    NSDictionary * dic = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#fefefe"],NSForegroundColorAttributeName:[UIFont systemFontOfSize:17]};
    
    
    [UINavigationBar appearance].titleTextAttributes = dic;

    
}
//如果想要统一定制返回按钮样式的话，可以重写如下方法
//重写返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
}
-(UIBarButtonItem *)creatBackButton
{
   // [UIBarButtonItem alloc]initWithImage:[UIImage imageWithColor:[UIColor yellowColor]] style:UIBarButtonItemStylePlain target:<#(nullable id)#> action:<#(nullable SEL)#>
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imageView setImage:[UIImage imageNamed:@"yinlian"]];
    [backView addSubview:imageView];
    
    
    
   //[[UIBarButtonItem alloc]initWithCustomView:backView]
    //[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tuijian"] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)]
    
    
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"findPage_04"] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    //或[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
}
-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
