//
//  positionView.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/8.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "positionView.h"
#import "positionTableViewCell.h"


@interface positionView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _listTableView;
    
    
    UIView * _incomeView;
    UILabel * _incomeLable;
    UILabel * _RMBLable;
    int i ;
    int b;
    
}


@end


@implementation positionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f4f4f2"];
        
        
        [self loadUI];
    }
    
    return self;
}



-(void)loadUI{

//tableView
//    
    UITableView * listTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth-81-64-40) style:UITableViewStyleGrouped];
    listTableView.delegate = self;
    listTableView.dataSource = self;
   
    [self addSubview:listTableView];
    
//    UITableView * tab = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
//    
//    
//    tab.delegate = self;
//    tab.dataSource = self;
//    [self addSubview:tab];
    
    
    
    
//    listTableView.dataSource=self;
//    
//    listTableView.delegate = self;

//底部持仓总收益
    
    UIView * incomeView= [[UIView alloc]initWithFrame:CGRectMake(0, self.current_h-81, self.current_w, 81)];
    incomeView.backgroundColor = [UIColor colorWithHexString:@"#0e2947"];
    _incomeView = incomeView;
    
    [self addSubview:incomeView];
    [self setIncomeView];
}

-(void)setIncomeView{

    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 2*(ScreenWidth-10*2)/3, 11)];
    titleLable.font = [UIFont systemFontOfSize:11];
    titleLable.textColor = [UIColor colorWithHexString:@"#A8A8A8"];
    titleLable.text = @"持仓总收益(美元)";
    [_incomeView addSubview:titleLable];
    
    UILabel * incomeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 36, 60, 40)];
    incomeLable.text = @"+0";
    incomeLable.font = [UIFont systemFontOfSize:40];

    incomeLable.textColor = [UIColor colorWithHexString:@"#fb4b55"];
    //incomeLable.backgroundColor = [UIColor redColor];
    incomeLable.textAlignment = NSTextAlignmentNatural;
    [_incomeView addSubview:incomeLable];
    _incomeLable = incomeLable;
    UILabel * RMBLable = [[UILabel alloc]initWithFrame:CGRectMake(incomeLable.current_x_w+5, incomeLable.current_y_h-28, 80, 28)];
    RMBLable.text = @"(+0元)";
    RMBLable.adjustsFontSizeToFitWidth = YES;
    RMBLable.font = [UIFont systemFontOfSize:14];
    RMBLable.textColor = [UIColor colorWithHexString:@"#cccccc"];
    [_incomeView addSubview:RMBLable];
    _RMBLable= RMBLable;
    
//
//    incomeLable.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, font);
//    
//    RMBLable.frame = CGRectMake(incomeLable.current_x_w+10, incomeLable.current_y_h-28, (ScreenWidth-10*2)/4-10, 28);
   // titleLable.font = [UIFont systemFontOfSize:font-3];

    
    //一键平仓
    UIButton * openInterest = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3*2, 20, ScreenWidth/3-10, 42)];
    
    openInterest.backgroundColor = [UIColor colorWithHexString:@"#fb4b55"];
    [openInterest setTitle:@"一键平仓" forState:UIControlStateNormal];
    [openInterest setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    openInterest.titleLabel.font = [UIFont systemFontOfSize:15];
    [openInterest.layer setMasksToBounds:YES];
    [openInterest.layer setCornerRadius:21];
    
    [_incomeView addSubview:openInterest];
    
    
    //----------------测试---------------
    i=0;
    b=10;
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(omnTimer) userInfo:nil repeats:YES];

}

-(void)omnTimer{
    [self setLableText];
    
    if (i>100000) {
        b=10000;
    }
    if (i>10000) {
        b=1000;
    }
    
    i=i+b;


}


-(void)setLableText{

    
    _incomeLable.text = [NSString stringWithFormat:@"+%d",i];
    _RMBLable.text = [NSString stringWithFormat:@"(+%d元)",i*7];

    CGFloat width = [Helper calculateTheHightOfText:_incomeLable.text height:40 font:[UIFont systemFontOfSize:40]];
    CGRect rect = _incomeLable.frame;

    if (width > 4*ScreenWidth/9-20) {
        _incomeLable.frame = CGRectMake(rect.origin.x, rect.origin.y, 4*ScreenWidth/9-20, 40);
        _incomeLable.adjustsFontSizeToFitWidth = YES;
        _RMBLable.frame = CGRectMake(_incomeLable.current_x_w+5, _incomeLable.current_y_h-28, 2*ScreenWidth/9, 28);
        
    }else{
        _incomeLable.frame = CGRectMake(rect.origin.x, rect.origin.y, width, 40);
        _RMBLable.frame = CGRectMake(_incomeLable.current_x_w+5, _incomeLable.current_y_h-28, 2*ScreenWidth/9, 28);
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 11;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{




    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellid = @"positionCell";
    
    positionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[positionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    
    

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 104.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];






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

@end
