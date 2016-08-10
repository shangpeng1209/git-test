//
//  detailViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/22.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "detailViewController.h"
#import "detailTableViewCell.h"
@interface detailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSInteger pageNumber;//第几页
    NSInteger pageSize; //每页显示个数
    
    //无信息界面
    BOOL showNoMessage;
    
    //
    UIView * View;
    
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSMutableArray *detail;
@end

@implementation detailViewController


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    pageNumber = 1;
    pageSize = 20;
    showNoMessage = NO;
    
    if (_detail==nil) {
        _detail = [NSMutableArray array];
    }
    
    if (self.urlType == 0) {
        self.url =FinancyFlowList;//资金
    }else if (self.urlType == 1){
        self.url =ScoreOrderList;//积分

    }
    
   
//    UILabel * headerLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 0)];
//    [self.view addSubview:headerLable];
   // self.navigationItem.leftBarButtonItem
    
    UITableView * tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
   // tableView.mj_header.automaticallyChangeAlpha = YES;
    
    _tableView = tableView;
    [self Refrash];
    [_tableView.mj_header beginRefreshing];
    
   
    
}
#pragma mark -- 获取资金积分详情
-(void)getMessage{

    
    
    
        NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
        NSDictionary * dic = @{@"token":token,
                               @"version":Version};
        
        
        [SHPNetWorking postRequestWithNSDictionary:dic url:FinancyMain successBlock:^(NSDictionary *dictionary) {
            
            
            if ([dictionary[@"code"]floatValue] == 200) {
                
                [self setUpTableHeaderViewWithDic:dictionary[@"data"]];

                
            }
            
            
            
            
        } failureBlock:^(NSError *error) {
            
            
        }];
        
        
        
    
    
    

}



-(void)setUpTableHeaderViewWithDic:(NSDictionary *)dic{
    UIView * tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    
    UILabel * headerLable = [[UILabel alloc]initWithFrame:CGRectMake(50, tableHeaderView.current_h/4, ScreenWidth-100, tableHeaderView.current_h/2)];
    
    UILabel * footLable = [[UILabel alloc]initWithFrame:CGRectMake(headerLable.current_x, headerLable.current_y_h, headerLable.current_w, headerLable.current_h/2)];
    footLable.textAlignment = NSTextAlignmentCenter;
    footLable.font = [UIFont systemFontOfSize:10];
    footLable.text = @"冻结保证金";
    
    
    
    NSString * Score = [Helper translateStr:dic[@"curCashScore"]];
    
    NSString * scoreStr= [NSString stringWithFormat:@"%@积分",Score];
    
    
    NSString * Fund =[Helper translateStr:dic[@"curCashFund"]];
    NSString * fundStr = [NSString stringWithFormat:@"%@元",Fund];
    
    NSRange range ;
    NSString * currentStr;
    if (self.urlType == 0) {
    //资金
        currentStr = fundStr;
        
        range.location = 0;
        range.length = Fund.length;
        
        
    }else if (self.urlType == 1){
    //积分
        currentStr = scoreStr;
        
        range.location = 0;
        range.length = Score.length;
        
    }
    
    

    
//curCashScore
//    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                   [UIFont systemFontOfSize:15.0],NSFontAttributeName,
//                                   [UIColor redColor],NSForegroundColorAttributeName,
//                                   NSUnderlineStyleAttributeName,NSUnderlineStyleSingle,nil];
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"今天天气不错呀" attributes:attributeDict];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:currentStr];
    headerLable.font = [UIFont systemFontOfSize:10];

    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:36.0]
     
                          range:range];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:range];
   
    headerLable.attributedText = AttributedStr;
    headerLable.numberOfLines=1;
    headerLable.textAlignment = NSTextAlignmentCenter;
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    [tableHeaderView addSubview:headerLable];
    [tableHeaderView addSubview:footLable];
    _tableView.tableHeaderView = tableHeaderView;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    
    return @"收支明细";
}


-(void)Refrash{
    
    //下拉刷新
    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageNumber = 1;
        pageSize = 10;
        
        
        [self laodRequest];
        [self getMessage];
       
    }];
    
    // 上拉刷新
    _tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        pageNumber ++;
    // [self addNews];
        [_tableView.mj_footer endRefreshing];
    }];
}

-(void)laodRequest{


   // NSArray * urlArr = @[@"http://test.jnhyxx.com/sms/message/systemMessages",@"http://test.jnhyxx.com/sms/message/systemMessages"];
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    
    if (token == nil || [token isEqualToString:@""]) {
        
        token = @"";
        
        
    }
    
    
    NSDictionary * dic = @{@"token":token,
                           @"pageNo":[NSString stringWithFormat:@"%d",pageNumber],
                           @"pageSize":[NSString stringWithFormat:@"%d",pageSize],
                           @"version":Version};
    
    [self.tableView.mj_header beginRefreshing];
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:self.url successBlock:^(NSDictionary *dictionary) {
//        [_tableView.mj_footer endRefreshingWithNoMoreData];

        if ([dictionary[@"code"]floatValue] == 41022) {
            //跳转到登陆页
            
            
        }else if([dictionary[@"code"]floatValue] == 200){
            
            //_newsArr = dictionary[@"data"];
            
            _detail = [NSMutableArray arrayWithArray:dictionary[@"data"]];
//
            if (_detail.count == 0) {
                showNoMessage = YES;
            }else{
            }
            
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];

            
        }
        
    } failureBlock:^(NSError *error) {
        [_tableView.mj_header endRefreshing];


    }];

}


//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeigth)];
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(30, 10, ScreenWidth-60, 30)];
//    
//    [button setTitle:@"暂无数据" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [headerView addSubview:button];
//    
//    if (section == 0 && showNoMessage == YES) {
//        
//        
//        return headerView;
//    }
//    
//    
//    
//    return nil;
//
//}
//

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0 && showNoMessage == YES) {
//        
//        _tableView.scrollEnabled = NO;
//
//        return ScreenHeigth - 64;
//        
//    }

    return 30.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    
    return _detail.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"mycell";
    
    detailTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        cell=[[detailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
   // CGSize requiredSize = [cell.textLabel.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:boundSize lineBreakMode:UILineBreakModeWordWrap];
    NSLog(@"row = %ld",indexPath.row);
    CGRect rect = cell.frame;
    rect.size.height = cell.height;
    cell.frame = rect;
    
    [cell setCellWithDictionary:_detail[indexPath.row]];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    return cell.frame.size.height;

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
