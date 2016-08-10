//
//  NewsViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/21.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "NewsViewController.h"
#import "loginViewController.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MJRefreshAutoStateFooter *footer;
    NSInteger pageNumber;//第几页
    NSInteger pageSize; //每页显示个数
    NSInteger newsIdfa; //全局标识 0，系统消息 1，交易详情
    
    
    


}

@property (nonatomic, strong) UISegmentedControl *newsControl;

@property (nonatomic, strong) NSMutableArray *systemNews;
@property (nonatomic, strong) NSMutableArray *tradeNews;

@property (nonatomic, strong) NSMutableArray *newsArr;
@property (nonatomic, strong) UITableView *tableView;



@end

@implementation NewsViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = YES;
    
    
    
    
      
   
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息中心";
    
    if (_systemNews == nil) {
        _systemNews =[NSMutableArray array];
        
    }
    if (_tradeNews == nil) {
        _tradeNews = [NSMutableArray array];
    }
    if (_newsArr == nil) {
        _newsArr = [NSMutableArray array];
    }

    
//    [self.navigationItem.leftBarButtonItem setBackButtonBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal style:UIBarButtonItemStyleDone barMetrics:UIBarMetricsDefault];
    
    //[self.navigationItem.backBarButtonItem];

   // UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(test)];
    
    // self.navigationController.navigationItem.le
    
    
    pageSize =10;
    pageNumber = 1;
    
    
    NSArray *arr=@[@"系统消息",@"交易提醒"];
    UISegmentedControl *newsControl=[[UISegmentedControl alloc]initWithItems:arr];
    
    newsControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
   // newsControl.backgroundColor = [UIColor blackColor];
    newsControl.tintColor = [UIColor redColor];
    /*
//    NSDictionary * selectedTextAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]};
//    [newsControl setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
//    
//    NSDictionary * unselectedTextAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor redColor]};
//    [newsControl setTitleTextAttributes:unselectedTextAttr forState:UIControlStateNormal];*/
    
    if (self.NewsType == 1000) {
        newsControl.selectedSegmentIndex=0;

    }else if(self.NewsType == 1001){
    
        newsControl.selectedSegmentIndex=1;
    
    }else{
        newsControl.selectedSegmentIndex=0;

    }
    
    newsIdfa = newsControl.selectedSegmentIndex;
    
    [newsControl addTarget:self action:@selector(clickedSegmented:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:newsControl];

    _newsControl = newsControl;
    
    
    
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeigth-64-40) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;


    [self Refrash];
   [self.tableView.mj_header beginRefreshing];

    
    
    
    
    
    
}



-(void)Refrash{
    


    _tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
            // 结束刷新
            
            pageSize =10;
            pageNumber = 1;
            
            [self loadNewRequest];
            
            
            
    
    }];
    
    // 上拉刷新
     //   _tableView.mj_footer
    footer= [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            pageNumber ++;
            [self addNews];
    

        }];
    
    
  
    _tableView.mj_footer = footer;
    
//    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
//    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
   // footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    //footer.stateLabel.textColor = [UIColor blueColor];
}


-(void)loadNewRequest{


    NSArray * urlArr = @[@"http://test.jnhyxx.com/sms/message/systemMessages",@"http://test.jnhyxx.com/sms/message/systemMessages"];
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    
    if (token == nil || [token isEqualToString:@""]) {
        
        token = @"";
        
        
    }
    
    
    NSDictionary * dic = @{@"token":token,
                           @"pageNo":[NSString stringWithFormat:@"%d",pageNumber],
                           @"pageSize":[NSString stringWithFormat:@"%d",pageSize]};
    newsIdfa = _newsControl.selectedSegmentIndex;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self.tableView.mj_header beginRefreshing];
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:urlArr[newsIdfa] successBlock:^(NSDictionary *dictionary) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        if ([dictionary[@"code"]floatValue] == 41022) {
            //跳转到登陆页
            
            
        }else if([dictionary[@"code"]floatValue] == 200){
            
            [_newsArr removeAllObjects];
            _newsArr = [NSMutableArray arrayWithArray:dictionary[@"data"]];
            
            [_tableView reloadData];

            
        }
        [_tableView.mj_header endRefreshing];

    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_tableView.mj_header endRefreshing];

    }];
    


}

-(void)addNews{

    NSArray * urlArr = @[@"http://test.jnhyxx.com/sms/message/systemMessages",@"http://test.jnhyxx.com/sms/message/systemMessages"];
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:UserToken];
    if (token == nil || [token isEqualToString:@""]) {
        token = @"";
    }

    NSDictionary * dic = @{@"token":token,
                           @"pageNo":[NSString stringWithFormat:@"%d",pageNumber],
                           @"pageSize":[NSString stringWithFormat:@"%d",pageSize]};
    newsIdfa = _newsControl.selectedSegmentIndex;
    
    [self.tableView.mj_footer beginRefreshing];
    
    [SHPNetWorking postRequestWithNSDictionary:dic url:urlArr[newsIdfa] successBlock:^(NSDictionary *dictionary) {
        
        if ([dictionary[@"code"]floatValue] == 41022) {
            //跳转到登陆页
            
            
        }else if ([dictionary[@"code"]floatValue] == 200){
            
            
        NSMutableArray * arr =[NSMutableArray array];
            
        [arr addObjectsFromArray:_newsArr];
            NSArray * dicArr = dictionary[@"data"];
        [arr addObjectsFromArray:dictionary[@"data"]];

        
        [_newsArr removeAllObjects];
        [_newsArr addObjectsFromArray:arr];
            
            if (dicArr.count == 0&&pageNumber>=2) {
                pageNumber --;

                [footer setTitle:@"没有更多了" forState:MJRefreshStateIdle];
//                [footer setTitle:@"没有更多了" forState:MJRefreshStateRefreshing];
//                [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
            
            }
            
        

        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];

        }
        
    } failureBlock:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];

        pageSize --;
        
    }];



}



-(void)clickedSegmented:(UISegmentedControl *)sender
{
    [self.tableView.mj_header beginRefreshing];

    _newsArr = nil;
    [_tableView reloadData];
    
    
    
    if (sender.selectedSegmentIndex==0) {
       
        newsIdfa = 0;
        pageNumber =1;

        
        
        
        
    }
    else
    {
        newsIdfa = 1;
        pageNumber =1;


        
        
    } 
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    
    return _newsArr.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"mycell";
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    
    if (_newsArr.count==0) {
        return cell;
    }
    
    NSDictionary * dic = _newsArr[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"updateDate"];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



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
