//
//  AppDelegate.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "detailViewController.h"
#import "ViewController.h"
#import "AccountViewController.h"

@interface AppDelegate ()
{
    Reachability *reach;
    
    int i;

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"test-------");
    
    //NSNotification * no = [NSNotification alloc]init
    //[NSNotificationCenter defaultCenter]postNotification:<#(nonnull NSNotification *)#>
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(push) name:@"goto" object:nil];

   // [UINavigationBar apperance]setBackground:[UIImage imageWithColor:[UIColor redColor]];
    
   // [[UINavigationBar appearance]setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    //[UINavigationController ]
    //[[UINavigationBar appearance]setShadowImage:[UIImage imageWithColor:[UIColor yellowColor]]];
  

    
    
    reach =[Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [reach startNotifier];
    
    return YES;
}

-(void)push{

    NSLog(@"appPush");

}
- (void) reachabilityChanged: (NSNotification*)note {
    reach = [note object];
    
    
    if (reach.currentReachabilityStatus==0) {
        //无网络
    }else if (reach.currentReachabilityStatus==1){
    //shuju
    
    }else if (reach.currentReachabilityStatus==2){
        //wifi
        
    }else if (reach.currentReachabilityStatus==3){
        
        
    }
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"goto" object:nil];




}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (i == 1) {
        i=0;
        NSLog(@"-------------");
        detailViewController * dd = [[detailViewController alloc]init];

        //[[self getCurrentVC].navigationController pushViewController:dd animated:YES ];
        //[self.window.rootViewController presentModalViewController:dd animated:YES];
      //  [self.window.rootViewController.navigationController pushviewcontroller:dd animated:YES];
     //   [[NSNotificationCenter defaultCenter]postNotificationName:@"goto" object:nil];
       // [self.window.rootViewController.navigationController pushViewController:dd animated:YES];
        
    }else{
    
        i=1;
    }
    
    
//    
//    detailViewController * dd = [[detailViewController alloc]init];
//    
//    //UIViewController * cl=  [self getCurrentVC];
//    
//    ViewController * view ;
//    
//
//    view.selectedIndex = 3;
//    
//    
//    AccountViewController * account=[[AccountViewController alloc]init];
//    CustumViewController *accountNav=[[CustumViewController alloc]initWithRootViewController:dd];
//    
//    
//    [[self getCurrentVC] presentViewController:accountNav animated:YES completion:nil];

   // [accountNav.navigationController pushViewController:dd animated:YES];
    
    

    
    
}

-(void)nofi{

    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
   // localNotification.userInfo = userInfo;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertBody = @"testtesttesttesttesttesttesttest";
    localNotification.fireDate = [NSDate date];
    UIUserNotificationType type =  UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.parentViewController;
    }
    
    return topVC;
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
