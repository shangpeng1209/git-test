//
//  OrderViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/8.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "OrderViewController.h"
#import "positionView.h"
#import "settlementView.h"

@interface OrderViewController ()<UIScrollViewDelegate>
{

    NSInteger selectIndex;
    UILabel * line;
    UIButton * _position;
    UIButton * _settlement;
    UIScrollView * ScrollView;
    
    positionView * posi;
    
}
@end

@implementation OrderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    self.tabBarController.tabBar.hidden = YES;



}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单";

    UIButton * position = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 40)];
    [position setTitle:@"订单" forState:UIControlStateNormal];
    [position setTitleColor:[UIColor colorWithHexString:@"#358CF3"] forState:UIControlStateNormal];
    position.tag = 3500;
    position.titleLabel.font = [UIFont systemFontOfSize:14];
    [position addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    position.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:position];
    _position = position;
    
    
    UIButton * settlement = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 40)];
    [settlement setTitle:@"结算" forState:UIControlStateNormal];
    [settlement setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    settlement.tag = 3501;

    settlement.titleLabel.font = [UIFont systemFontOfSize:14];
    [settlement addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settlement];
    _settlement = settlement;
    
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(15*ScreenWidth/375 + selectIndex*ScreenWidth/2, 40-4, 158*ScreenWidth/375, 4)];
    [line.layer setMasksToBounds:YES];
    [line.layer setCornerRadius:2.0];
    line.backgroundColor = [UIColor colorWithHexString:@"#358CF3"];
    [self.view addSubview:line];
    
    
    ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeigth-40-64)] ;
    ScrollView.pagingEnabled = YES;
    ScrollView.delegate =self;
    ScrollView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeigth-40-64);
    ScrollView.contentOffset = CGPointMake(selectIndex*ScreenWidth, 0);
    ScrollView.bounces=NO;

    [self.view addSubview:ScrollView];
    
    posi = [[positionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScrollView.current_h)];
    
    [ScrollView addSubview:posi];
    
    settlementView * settlements = [[settlementView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScrollView.current_h)];
    [ScrollView addSubview:settlements];

    
    
    

}

-(void)buttonSelected:(UIButton *)sender{
    if (sender.tag == 3500) {
        selectIndex = 0;
        [_position setTitleColor:[UIColor colorWithHexString:@"#358CF3"] forState:UIControlStateNormal];

        [_settlement setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];

        //[self.view addSubview:posi];
        
        
    }else{
        selectIndex = 1;
        [_position setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_settlement setTitleColor:[UIColor colorWithHexString:@"#358CF3"] forState:UIControlStateNormal];
        
       // [posi removeFromSuperview];
        
    }
    
    
    
    


    [UIView animateWithDuration:0.3 animations:^{
        line.frame =CGRectMake(15*ScreenWidth/375 + selectIndex*ScreenWidth/2, 40-4, 158*ScreenWidth/375, 4);
        ScrollView.contentOffset = CGPointMake(selectIndex*ScreenWidth, 0);

    }];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{


    if (scrollView.contentOffset.x>ScreenWidth/2) {
        
        selectIndex = 1;
        [_position setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_settlement setTitleColor:[UIColor colorWithHexString:@"#358CF3"] forState:UIControlStateNormal];
        
        
    }else{
    
        selectIndex = 0;
        [_position setTitleColor:[UIColor colorWithHexString:@"#358CF3"] forState:UIControlStateNormal];
        
        [_settlement setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        line.frame =CGRectMake(15*ScreenWidth/375 + selectIndex*ScreenWidth/2, 40-4, 158*ScreenWidth/375, 4);
        
    }];


}




-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];
    
    [posi removeFromSuperview];

    

}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];



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
