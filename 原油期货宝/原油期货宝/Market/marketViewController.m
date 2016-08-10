//
//  marketViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "marketViewController.h"

@implementation marketViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden = NO;
    
    
    
}

-(void)viewDidLoad{

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITabBarItem *tabbarItem4 = [[UITabBarItem alloc] initWithTitle:@"44" image:[UIImage imageNamed:@"findPage_04"] tag:4];
    tabbarItem4.badgeValue = [NSString stringWithFormat:@"10"];
}

@end
