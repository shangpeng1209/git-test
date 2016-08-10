//
//  HomeViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/4.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "homeModel.h"
#import "SDCycleScrollView.h"
#import "homeButton.h"


#pragma mark -- test
#import "OrderViewController.h"



@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
  //左间距
    CGFloat leftSpace;
    CGFloat rightSpace;
    
//--------
    NSArray * cycleArr;//轮播数组
    NSArray * homeArr;//期货信息
    NSArray * priceArr;//价格信息
    UITableView * _homeTableView;
    NSTimer * priceTime;
    NSTimer * onlineTimer;
    
    SDCycleScrollView *cycleScrollView;//轮播
    NSMutableArray * cycleImageArr;
    NSMutableArray * cycleUrlArr;
    NSMutableArray * resultListArr;//实时在线做多做空
    
    
    UILabel * onLine;//在线人数
    SDCycleScrollView *resultListView;//实时买入
    
    //分组，国内国际期货
    NSMutableArray * internalArr;
    NSMutableArray * internationalArr;
    
    
    
    
    
}



@end


@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [priceTime setFireDate:[NSDate distantPast]];
    self.tabBarController.tabBar.hidden = NO;

}


-(void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"原油期货宝";
    leftSpace = 10;
    rightSpace = 10;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(push) name:@"goto" object:nil];

    
    UITableView * homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth-64) style:UITableViewStyleGrouped];
    homeTableView.backgroundColor = [UIColor whiteColor];
    homeTableView.delegate = self;
    homeTableView.dataSource = self;
    
    [self.view addSubview:homeTableView];
    _homeTableView = homeTableView;
    
    [self loadRequest];
    
    priceTime=  [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(priceReload:) userInfo:nil repeats:YES];
    [priceTime fire];
    
    
    onlineTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(onlineReload:) userInfo:nil repeats:YES];
    
    
    //创建tableview头
    [self tableHeaderView];
    //轮播列表
    [self requestCycleScrollView];
    
}

-(void)push{

    NSLog(@"homePush");

}

-(void)loadRequest{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
    
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
//    [NSString stringWithFormat:@"http://www.jnhyxx.com/market/futureCommodity/select?_=%@",timeSp];
    
[SHPNetWorking postRequestWithNSDictionary:nil url:[NSString stringWithFormat:@"http://www.jnhyxx.com/market/futureCommodity/select?_=%@",timeSp] successBlock:^(NSDictionary *dictionary) {
    if ([dictionary[@"code"]floatValue]==200) {
        
        internalArr = [NSMutableArray array];
        internationalArr = [NSMutableArray array];
        homeArr = dictionary[@"data"];
        
        
        for (NSDictionary * dic in dictionary[@"data"]) {
            if ([dic[@"currencyName"] isEqualToString:@"人民币"]) {
                
                [internalArr addObject:dic];
                
            }else{
            
                [internationalArr addObject:dic];
            
            }
        }
        
        
        [_homeTableView reloadData];
        
    }
    
    
    
} failureBlock:^(NSError *error) {
    
}];


}
#pragma mark -- 定时器--加载当前价格 涨跌幅 --
-(void)priceReload:(NSTimer *)sender{

    [self requestCurrentPrice];


}

#pragma mark -- 定时器--加载在线人数 --
-(void)onlineReload:(NSTimer *)sender{

    [self requestOnlineNumber];


}

#pragma mark == 获取当前价格以及涨跌幅
-(void)requestCurrentPrice{
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
    //http://www.jnhyxx.com/futuresquota/getAllCacheData?_=1470359106248
    
    [SHPNetWorking postRequestWithNSDictionary:nil url:[NSString stringWithFormat:@"http://www.jnhyxx.com/futuresquota/getAllCacheData?_=%@",timeSp] successBlock:^(NSDictionary *dictionary) {
        
        if ([dictionary[@"code"]floatValue]==200) {
            
            priceArr = dictionary[@"data"];
            
            [_homeTableView reloadData];
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
        
    }];
    

}

#pragma mark -- 获取当前在线人数 --实时购买等 --
-(void)requestOnlineNumber{
   
    __block NSString * result;
    __block NSNumber * text;
    resultListArr= [NSMutableArray array];
    [SHPNetWorking postRequestWithNSDictionary:nil url:[NSString stringWithFormat:@"%@/order/order/indexReport",RootURL] successBlock:^(NSDictionary *dictionary) {
        
        if ([dictionary[@"code"]floatValue]==200) {
            
            NSArray * arr = dictionary[@"data"][@"resultList"];
            
            for (NSDictionary * dic in arr) {
                
               
                result = [NSString stringWithFormat:@"%@ %@ %@ %@",dic[@"nick"],dic[@"time"],dic[@"tradeType"],dic[@"futuresType"]];
                [resultListArr addObject:result];
                
            }
            text =dictionary[@"data"][@"count"];
//            NSMutableArray *titlesArray = [NSMutableArray new];
//            [titlesArray addObject:@"***76 15:06 做空 美原油"];
//            [titlesArray addObject:@"***76 15:06 做涨 美原油"];
//            [titlesArray addObject:@"***76 15:06 无无 美原油"];
            
            resultListView.titlesGroup = [resultListArr copy];
            
            NSString * lableText = [NSString stringWithFormat:@"当前在线%d人",[text intValue]];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:lableText];
            
            NSRange range = [lableText rangeOfString:[NSString stringWithFormat:@"%@",text]];
            
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor redColor]
             
                                  range:range];
            
            onLine.attributedText = AttributedStr;
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
        
    }];


}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{



    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return internationalArr.count;
    }


    return internalArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * homeCell = @"homecell";
    
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:homeCell];

    if (!cell) {
        
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeCell];
    }
    
    homeModel * model = [[homeModel alloc]init];
    
    
    NSArray * currentArr;
    
    
    if (indexPath.section == 0) {
        
        currentArr = [NSArray arrayWithArray:internationalArr];
        
    }else{
    
        currentArr = [NSArray arrayWithArray:internalArr];
    
    
    }
    
    
    
    [model setValuesForKeysWithDictionary:currentArr[indexPath.row]];
    
    [cell setCellWithModel:model];

    
    for (NSDictionary * dic  in priceArr) {
        
        if ([[dic[@"code"] lowercaseString] isEqualToString:[model.instrumentCode lowercaseString]]) {
            
            
            [cell setCellPriceWithDic:dic];
            
            
            break;
            
        }
        
        
    }
    
   // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    

    

    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{



    return 62.0f;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{


    if (section == 0) {
        return @"国际期货";
    }else{
    
    
    return @"国内期货";
    }


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    OrderViewController * order = [[OrderViewController alloc]init];
    
    
    [self.navigationController pushViewController:order animated:YES];



}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 37)];
    
    UILabel * headerLable = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, ScreenWidth-leftSpace, 37)];
    
    if (section == 0) {
        headerLable.text = @"国际期货";

    }else{
        headerLable.text = @"国内期货";

    
    }
    
    headerLable.textColor = [UIColor colorWithHexString:@"#666666"];
    headerLable.font = [UIFont systemFontOfSize:14];
    [header addSubview:headerLable];
    
    


    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{


    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 37.0f;
}


#pragma mark -- table HeaderView

-(void)tableHeaderView{

    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 222)];
    
    
    //----------------------创建轮播-------------------
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 140) delegate:self placeholderImage:[UIImage imageNamed:@"shareIcon"]];
    
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    // cycleScrollView2.titlesGroup = titles;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView.autoScrollTimeInterval = 2.0;


    
    [headerView addSubview:cycleScrollView];
    
    
    //         --- 模拟加载延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
//    });
//    
//    
//    // block监听点击方式
   __block NSString * url;
    cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {

        
        if (cycleImageArr.count<1) {
            return ;
        }
        
         url = cycleUrlArr[index];
        
//        if (url!=nil && [url]) {
//            <#statements#>
//        }
        
        
        
        
        
    
    };
    
    
   //---------------创建实时在线人数和买入情况------------
    onLine = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, cycleScrollView.current_y_h, (ScreenWidth-leftSpace-rightSpace)/2, 28)];
    //http://www.jnhyxx.com/order/order/indexReport
    onLine.font = [UIFont systemFontOfSize:11];
    onLine.textColor = [UIColor colorWithHexString:@"#666666"];
    onLine.text = @"当前在线--人";
    
    
    
    [headerView addSubview:onLine];
    
    
    resultListView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(onLine.current_x_w, cycleScrollView.current_y_h, (ScreenWidth-leftSpace-rightSpace)/2, 28) delegate:self placeholderImage:nil];
    resultListView.scrollDirection = UICollectionViewScrollDirectionVertical;
    resultListView.onlyDisplayText = YES;
    
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"  "];
    
    resultListView.titlesGroup = [titlesArray copy];

    // [titlesArray addObjectsFromArray:titles];
    [headerView addSubview:resultListView];
    
//
//    [demoContainerView addSubview:cycleScrollView4];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, onLine.current_y_h, ScreenWidth, 1)];
    line.backgroundColor =[UIColor colorWithHexString:@"#e5e5e5"];
    //[UIColor colorWithHexString:@"#A8A8A8"];
    [headerView addSubview:line];
    
    

//------------模拟操盘--新手指引--联系客服------------
    
    NSArray * imageNames = [NSArray arrayWithObjects:@"main_icon_simulator",@"main_icon_guide",@"main_icon_serve", nil];
    NSArray * titles = @[@"模拟操盘",@"新手指引",@"联系客服"];
    
    for (int i = 0; i<3; i++) {
        
        homeButton * button = [[homeButton alloc]initWithFrame:CGRectMake(ScreenWidth/3*i, onLine.current_y_h, ScreenWidth/3, 55)];
        [button.centerImageView setImage:[UIImage imageNamed:imageNames[i]]];
        button.downLable .text = titles[i];
        button.downLable.font = [UIFont systemFontOfSize:12];
        button.downLable.textAlignment = NSTextAlignmentCenter;
        button.downLable.textColor = [UIColor colorWithHexString:@"#262626"];
        [headerView addSubview:button];
        
        
    }
    
    
    
    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, headerView.current_y_h-1, ScreenWidth, 1)];
    line1.backgroundColor =[UIColor colorWithHexString:@"#e5e5e5"];
    //[UIColor colorWithHexString:@"#666666"];
    [headerView addSubview:line1];
    
    
    _homeTableView.tableHeaderView = headerView;



}
#pragma mark -- 加载轮播图
-(void)requestCycleScrollView{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
 //http://www.jnhyxx.com/user/newsNotice/newsImgList?type=2&_=1470373550162
  
    
    [SHPNetWorking postRequestWithNSDictionary:nil url:[NSString stringWithFormat:@"http://www.jnhyxx.com/user/newsNotice/newsImgList?type=2&_=%@",timeSp] successBlock:^(NSDictionary *dictionary) {
        

        if ([dictionary[@"code"]floatValue]==200) {
            
            cycleArr = dictionary[@"data"][@"news_notice_img_list"];

            cycleImageArr = [NSMutableArray array];
            cycleUrlArr = [NSMutableArray array];
            for (NSDictionary * dic  in cycleArr) {
                
                [cycleImageArr addObject:[NSString stringWithFormat:@"%@%@",RootURL,dic[@"middleBanner"]]];
                [cycleUrlArr addObject:[NSString stringWithFormat:@"%@%@",RootURL,dic[@"url"]]];
            }

            cycleScrollView.imageURLStringsGroup = cycleImageArr;
            
            
            
        }
        
        
    } failureBlock:^(NSError *error) {
        
    }];



}







-(void)dealloc{
    [priceTime invalidate];
    
}


-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:YES];
    [priceTime setFireDate:[NSDate distantFuture]];


}



@end
