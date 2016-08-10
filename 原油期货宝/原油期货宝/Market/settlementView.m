//
//  settlementView.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/9.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "settlementView.h"
#import "settelementTableViewCell.h"
#import "orderDetailVC.h"

@interface settlementView ()<UITableViewDelegate,UITableViewDataSource>
{



}
@end

@implementation settlementView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self loadUI];
    }
    
    return self;
}


-(void)loadUI{
    
    UITableView * settlementTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.current_h)];
    
    settlementTable.delegate = self;
    settlementTable.dataSource = self;
    
    [self addSubview:settlementTable];
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 11;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"settlementCell";
    settelementTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[settelementTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    
    }
   // cell.textLabel.text = @"test";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 55.0f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    orderDetailVC * order = [[orderDetailVC alloc]init];
    
    [[self viewController].navigationController pushViewController:order animated:YES ];
    

}


- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}





@end
