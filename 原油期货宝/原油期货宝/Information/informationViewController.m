//
//  informationViewController.m
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "informationViewController.h"
#import "infoTableViewCell.h"
#import "imageTableViewCell.h"
#import "infoModel.h"

@interface informationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * currentArr;
    UITableView * tableViews;
    NSMutableArray * heightArr;
    NSMutableDictionary * cellHeight;

    int ii ;
}


@end

@implementation informationViewController




-(void)viewDidLoad{

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [UIEngine sharedInstance].progressStyle=2;
    [[UIEngine sharedInstance]showProgress];
    
    heightArr = [NSMutableArray array];
    cellHeight = [NSMutableDictionary dictionary];
    NSArray *arr=@[@"资讯直播",@"行情分析",@"行业资讯"];
    UISegmentedControl *infoControl=[[UISegmentedControl alloc]initWithItems:arr];
    
    infoControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    // newsControl.backgroundColor = [UIColor blackColor];
    infoControl.tintColor = [UIColor redColor];
    [self.view addSubview:infoControl];

    
    ii = 1;
    
    
    
    
    tableViews = [[UITableView alloc]initWithFrame:CGRectMake(0, 40,ScreenWidth, ScreenHeigth-64-40-44) style:UITableViewStylePlain];
    tableViews.delegate = self;
    tableViews.dataSource =self;
    tableViews.mj_header.automaticallyChangeAlpha = YES;
    tableViews.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViews];
    [self loadRequest];
}


-(void)loadRequest{

    NSLog(@"开始加载");
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSMutableSet *set=[NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    
    [set addObject:@"text/html"];
    
    //读取保存cookie
    /*   NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:RootURL]];
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
     [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"cookie"];
     */
    
    //设置cookie
    /*
     NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:UserToken];
     if([cookiesdata length]) {
     NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
     NSHTTPCookie *cookie;
     for (cookie in cookies) {
     [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
     }
     }
     */
    manager.responseSerializer.acceptableContentTypes = set;
    manager.requestSerializer.timeoutInterval = 10;
 [manager POST:@"http://www.jnhyxx.com/user/newsNotice/newsByUrl?url=http%3A%2F%2Fm.jin10.com%2Fflash%3FmaxId%3D0" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
     
 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSArray * arr = responseObject;
     
     NSLog(@"加载完成");
     NSMutableArray * muArr = [NSMutableArray arrayWithArray:arr];
     
     NSMutableIndexSet * set = [NSMutableIndexSet indexSet];
     
     for (int i = 0; i<muArr.count; i++) {
         
         NSString * str = muArr[i];
         if ([str rangeOfString:@"src"].location != NSNotFound) {
             
             [set addIndex:i];
             
         }
         
     }
     [muArr removeObjectsAtIndexes:set];
     
//     if (muArr.count>20) {
//         //currentArr = [muArr subarrayWithRange:NSMakeRange(0, 10)];
//         
//         currentArr = [NSMutableArray arrayWithArray:[muArr subarrayWithRange:NSMakeRange(0, 10)]];
//         
//     }else{
//         currentArr = muArr;
//
//     }
     
     currentArr = muArr;

     
     [tableViews reloadData];
     NSLog(@"tableView加载完成");
     [[UIEngine sharedInstance]hideProgress];
     
//     dispatch_async(dispatch_get_main_queue(), ^{
//         
//         currentArr = muArr;
//         [NSThread sleepForTimeInterval:40];
//         
//         [tableViews reloadData];
//         NSLog(@"tableView二次加载完成");
//
//         
//         
//     });
     
     
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
 }];


}



#pragma mark - Table view data source 返回分区数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

#pragma mark --返回行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    
    return currentArr.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //UITableViewCell * cell;
    
  
    
   // cell.textView.text = currentArr[indexPath.row];
    
    NSString * news =currentArr[indexPath.row];
    
     NSArray *array = [news componentsSeparatedByString:@"#"];
    
    
   // [cell.webView loadHTMLString:currentArr[indexPath.row] baseURL:nil];
    // cell.backgroundColor = [UIColor clearColor];
  //  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    // NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[array[3] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
  //  if (array[6] == nil || [array[6] isEqualToString:@""]) {
        static NSString * cellid=@"mycell";
        
      infoTableViewCell*   cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell==nil) {
            cell=[[infoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            
            
            
        }
        
        
        if ([array[0] floatValue]==0&&[array[1] floatValue]==0) {
            
          //  [cell setCellWithString:currentArr[indexPath.row]];
            
            cell.titleLable.textColor = [UIColor redColor];
            
            infoModel * model = [[infoModel alloc]init];
            [model setModelWithStr:news];
            
            
//            NSString * time = array[2];//时间
//            NSString * titleL = array[3];//内容
//            NSString * image = array [6];
            
            [cell setCellWithTime:model.time title:model.text image:model.imagePath];
            
            
        }else if ([array[0] floatValue]==0&&[array[1] floatValue]==1){
            
          //  [cell setCellWithString:currentArr[indexPath.row]];
            cell.titleLable.textColor = [UIColor blackColor];
            
//            NSString * time = array[2];//时间
//            NSString * titleL = array[3];//内容
//            NSString * image = array [6];
            infoModel * model = [[infoModel alloc]init];
            [model setModelWithStr:news];
//            [cell setCellWithTime:time title:titleL image:image];
            [cell setCellWithTime:model.time title:model.text image:model.imagePath];

            
        }else if ([array[0] floatValue]==1){
            // [cell setCellWithString:currentArr[indexPath.row]];
            [cell setMarkCellWithStr:@"---------null--------"];
            
            
            cell.titleLable.textColor = [UIColor greenColor];
        }else{
            
            cell.textView.text = @"---------null--------";
            
            cell.titleLable.text = @"---------null--------";
        }
        
        CGRect rect = cell.frame;
        rect.size.height = cell.height;
        cell.frame = rect;
    NSNumber  * number = [NSNumber numberWithFloat:cell.height];
    
    [cellHeight setObject:number forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    
        [heightArr addObject:[NSNumber numberWithFloat:cell.height]];
        cell.userInteractionEnabled = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
//    }else{
//    
//        static NSString * cellid=@"mycellImage";
//        
//        imageTableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:cellid];
//        
//        if (cell==nil) {
//            cell=[[imageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//        }
//        
//        
//        
//        if ([array[0] floatValue]==0&&[array[1] floatValue]==0) {
//            
//            [cell setCellWithString:currentArr[indexPath.row]];
//            
//            cell.titleLable.textColor = [UIColor redColor];
//            
//        }else if ([array[0] floatValue]==0&&[array[1] floatValue]==1){
//            
//            [cell setCellWithString:currentArr[indexPath.row]];
//            cell.titleLable.textColor = [UIColor blackColor];
//            
//        }else if ([array[0] floatValue]==1){
//            // [cell setCellWithString:currentArr[indexPath.row]];
//            [cell setMarkCellWithStr:@"---------null--------"];
//            
//            
//            cell.titleLable.textColor = [UIColor greenColor];
//        }else{
//            
//            cell.textView.text = @"---------null--------";
//            
//            cell.titleLable.text = @"---------null--------";
//        }
//        
//        CGRect rect = cell.frame;
//        rect.size.height = cell.height;
//        cell.frame = rect;
//        [heightArr addObject:[NSNumber numberWithFloat:cell.height]];
//
//        cell.userInteractionEnabled = YES;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//        
//    }
    
    
    
    

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    
//    [cell setNeedsDisplay];
//    
//    NSLog(@"iii=%d",ii++);
//    
//    
//    if (cell.frame.size.height == 0) {
//        return 50;
//    }
//    return cell.frame.size.height;
    
    
    NSNumber * number = [cellHeight objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    
    if (number == nil) {
        return 50;
    }else{
    
        return [number floatValue];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"select");


}


@end
