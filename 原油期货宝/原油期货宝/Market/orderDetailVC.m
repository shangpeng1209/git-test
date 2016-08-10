//
//  orderDetailVC.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/10.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "orderDetailVC.h"
#import "orderDetailView.h"
@interface orderDetailVC ()

@end

@implementation orderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单详情";
    
    
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
    scrollView.backgroundColor = [UIColor whiteColor];
    //scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeigth*2);
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    //添加锯齿View
    orderDetailView *sawtoothView = [orderDetailView new];
    sawtoothView.frame = CGRectMake(0, 0, ScreenWidth, 109);
    [sawtoothView setColor:[UIColor blackColor] topColor:[UIColor clearColor] waveCount:80 waveHeight:109];
    [scrollView addSubview:sawtoothView];
    
   
    UILabel * titleLable  = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, sawtoothView.current_w*210/375, 11)];
    titleLable.text = @"结算盈亏 (美元)";
    titleLable.font = [UIFont systemFontOfSize:11];
    titleLable.textColor = [UIColor colorWithHexString:@"#A8A8A8"];
    titleLable.textAlignment = NSTextAlignmentRight;
    [sawtoothView addSubview:titleLable];
    
    
    UILabel * tradeLable = [[UILabel alloc]initWithFrame:CGRectMake(titleLable.current_x_w + sawtoothView.current_w*15/375, 21, sawtoothView.current_w*39/375, 19)];
    tradeLable.text = @"买涨";
    tradeLable.textColor = [UIColor whiteColor];
    tradeLable.font = [UIFont systemFontOfSize:11];
    tradeLable.backgroundColor = [UIColor redColor];
    tradeLable.textAlignment = NSTextAlignmentCenter;
    [sawtoothView addSubview:tradeLable];
    
    
    
    
    

    
    
    
    
}


-(void)loadUI{





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
