//
//  infoTableViewCell.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/1.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "infoTableViewCell.h"
#import "infoModel.h"
@interface infoTableViewCell ()<UIScrollViewDelegate>
{
    UIScrollView * _backView;
    UIImageView * _QRImageView;
    
    CGRect imageRect;
    
    //TouchScrollView *_backView;
    

}
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *image;
@end


@implementation infoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadUI];

    }
    
    
    return self;
}


-(void)layoutSubviews{

    [super layoutSubviews];
    CGSize size = _firstImageView.image.size;
    
    _firstImageView.frame = CGRectMake(_titleLable.current_x, _titleLable.current_y_h+10, size.width, size.height);
    _firstImageView.contentMode = UIViewContentModeScaleAspectFit;

}

-(void)loadUI{

    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(40, 0, ScreenWidth-40, 150)];
    _textView = textView;
    textView.userInteractionEnabled = NO;
   // [self.contentView addSubview:textView];

    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    webView.userInteractionEnabled = NO;
//    _webView = webView;
//    [self.contentView addSubview:webView];

    
    
    

    _time = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 50, 14)];
    _time.backgroundColor = RGBA(231, 231, 231, 1);
    _time.textAlignment = NSTextAlignmentCenter;
    _time.font = [UIFont systemFontOfSize:10];
    [_time.layer setMasksToBounds:YES];
    [_time.layer setCornerRadius:7.0];
    
   
    
    [self.contentView addSubview:_time];
     _line = [[UILabel alloc]initWithFrame:CGRectMake(20, 7, 1, 15)];
    
    _line.backgroundColor = RGBA(231, 231, 231, 1);
    [self.contentView addSubview:_line];
    
    
    _line1= [[UILabel alloc]initWithFrame:CGRectMake(20, 7, 20, 1)];
    
    _line1.backgroundColor = RGBA(231, 231, 231, 1);
    [self.contentView addSubview:_line1];
    
    UIView * redView = [[UIView alloc]initWithFrame:CGRectMake(15, 2, 10, 10)];
    
    [redView.layer setMasksToBounds:YES];
    [redView.layer setCornerRadius:5];
 
    redView.layer.borderWidth = 2;//边框宽度
    redView.layer.borderColor = [UIColor whiteColor].CGColor;//边框颜色
    redView.backgroundColor = [UIColor redColor];
    
    
    
    [self.contentView addSubview:redView];
    
    
    _titleLable = [[UILabel alloc]init];
    _titleLable.numberOfLines = 0;
    _titleLable.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_titleLable];
    
    
    _firstImageView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_firstImageView];
    
 
}


-(void)setCellWithTime:(NSString *)time title:(NSString *)title image:(NSString *)image{

    
    
    _image = image;
    _time.text = time;
     _titleLable.frame = CGRectMake(_time.current_x, _time.current_y_h+5, ScreenWidth - _time.current_x -10, 0);
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[title dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    _titleLable.attributedText = attrStr;
    _titleLable.font = [UIFont systemFontOfSize:16];
    [_titleLable sizeToFit];
    
    if (image == nil || [image isEqualToString:@""]) {
        
       

        self.height = _titleLable.current_y_h+10;
        
        
    }else{
    
        NSString *  path = [NSString stringWithFormat:@"https://res.6006.com/jin10/%@",image];//图片
        _imagePath = path;
        [_firstImageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"shareIcon"]];
        
//        [_firstImageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//            NSLog(@"加载完毕");
//           
//        }];
        
        _firstImageView.frame = CGRectMake(_titleLable.current_x, _titleLable.current_y_h+10, _titleLable.current_w/3, 40);
        _firstImageView.userInteractionEnabled = YES;
        CGSize size = _firstImageView.image.size;

        
        _firstImageView.frame = CGRectMake(_titleLable.current_x, _titleLable.current_y_h+10, size.width, size.height);
        [self.contentView reloadInputViews];
        //添加点击事件
        UITapGestureRecognizer*tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
        //设定点击次数
        tgr.numberOfTapsRequired=1;
        _firstImageView.contentMode = UIViewContentModeScaleAspectFit;
      
        [_firstImageView addGestureRecognizer:tgr];
        
        
        self.height = _firstImageView.current_y_h+10;

        
    }
    
    _line.frame = CGRectMake(20, 5, 1, _height-5);



}




-(void)drawRect:(CGRect)rect{

    [self setNeedsDisplay];

    
    //[self loadUI];

    
}


-(void)setCellWithString:(NSString *)string{


    
    NSArray * arr = [string componentsSeparatedByString:@"#"];
    
    
    NSString * time = arr[2];//时间
    NSString * titleL = arr[3];//内容
    NSString *  path = [NSString stringWithFormat:@"https://res.6006.com/jin10/%@",arr[6]];//图片
    
    
    _time.text = time;
    
     NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[titleL dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    _titleLable.attributedText = attrStr;
    
    
    
    
    
    _titleLable.font = [UIFont systemFontOfSize:14];
    NSString *titleContent = arr[3];
    _titleLable.textColor = [UIColor blackColor];
//    CGSize titleSize = [titleContent boundingRectWithSize:CGSizeMake(ScreenWidth - _time.current_x -10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;

    

    _titleLable.frame = CGRectMake(_time.current_x, _time.current_y_h+5, ScreenWidth - _time.current_x -10, 0);
    [_titleLable sizeToFit];
    _imagePath = arr[6];
    
    
    if (arr[6] != nil &&![arr[6] isEqualToString:@""] ) {
        
        _imagePath = path;
        [_firstImageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"shareIcon"]];
        _firstImageView.frame = CGRectMake(_titleLable.current_x, _titleLable.current_y_h+10, _titleLable.current_w/3, 40);
        _firstImageView.userInteractionEnabled = YES;
        //添加点击事件
        UITapGestureRecognizer*tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
        //设定点击次数
        tgr.numberOfTapsRequired=1;
        
        [_firstImageView addGestureRecognizer:tgr];

        _firstImageView.contentMode = UIViewContentModeScaleAspectFit;

        
        self.height = _firstImageView.current_y_h+10;
    
    
    }else{
    
        self.height = _titleLable.current_y_h+10;

    
    }
 
    _line.frame = CGRectMake(20, 5, 1, _height-5);

}

-(void)setMarkCellWithStr:(NSString *)value{

    
    
    _titleLable.text = value;
    _titleLable.frame = CGRectMake(_time.current_x, _time.current_y_h+5, 500, 50);
    self.height = 50;



}



- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.contentView reloadInputViews];
    
    self.firstImageView.image = nil;
    self.titleLable.text = nil;
    self.time.text = nil;
    // 更新位置
    
}
-(void)Tap:(UITapGestureRecognizer *)sender{

    CGPoint point = [sender locationInView:self];

    NSLog(@"path = %f",point.y);
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSArray * array = [[UIApplication sharedApplication] windows];
    
    if (array.count >= 2) {
        
        window = [array objectAtIndex:1];
        
    }
    
    
    //获取在屏幕上的位置
    CGRect rect1 = [_firstImageView convertRect:_firstImageView.frame fromView:self.contentView];     //获取_firstImageView在contentView的位置
    
    CGRect rect2 = [_firstImageView convertRect:rect1 toView:window];         //获取_firstImageView在window的位置
    
    CGRect rect3 = CGRectInset(rect2, -0.5 * 8, -0.5 * 8);
    
    imageRect = rect3;
    
    NSLog(@"--%f--%f--%f--%f---",rect3.origin.x,rect3.origin.y,rect3.size.width,rect3.size.height);
    
    
    
    
    
    
    UIScrollView * backView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    backView.scrollEnabled = YES;
    backView.contentSize = CGSizeMake(ScreenWidth, ScreenHeigth);
    
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0;
    
    [window addSubview:backView];
    _backView = backView;
    backView.delegate=self;
   // backView.touchesdelegate = self;
    //设置最大伸缩比例
    backView.maximumZoomScale=5.0;
    //设置最小伸缩比例
    backView.minimumZoomScale=0.5;
    
    //添加点击事件
    UITapGestureRecognizer*tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearWidow:)];
    //设定点击次数
    tgr.numberOfTapsRequired=1;
    
    [backView addGestureRecognizer:tgr];
    
    
    
    
    
    UIImageView * QRImageView = [[UIImageView alloc]initWithFrame:rect3];
    //[QRImageView sizeToFit];
    
    //CGRectMake(0, 0, ScreenWidth-20, ScreenWidth-140)
    backView.alpha = 1;

    [UIView animateWithDuration:0.5 animations:^{
        
        QRImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);

         QRImageView.center = window.center;

        
    } completion:^(BOOL finished) {
        
        QRImageView.center = window.center;
        
    }];
    
   // QRImageView.center = window.center;
    [QRImageView.layer setMasksToBounds:YES];
    [QRImageView.layer setCornerRadius:6.0];
    QRImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NSMutableString * str = [NSMutableString stringWithString:_imagePath];
    // 删除指定的字符
    NSRange range = [str rangeOfString:@"_lite"];// 先确定要删除的字符的范围(位置，长度)
    //[str deleteCharactersInRange:<#(NSRange)#>]
    [str deleteCharactersInRange:range]; // 调用删除字符方法
    
    [QRImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:_firstImageView.image];
   
    //QRImageView.userInteractionEnabled = YES;
    
    [backView addSubview:QRImageView];
    
    _QRImageView = QRImageView;
   // QRImageView.frame = CGRectMake(0, 0, QRImageView.image.size.width, QRImageView.image.size.height);
    UILongPressGestureRecognizer *longPressGR =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleLongPress:)];
   // longPressGR.allowableMovement=NO;
    longPressGR.minimumPressDuration = 1;
   // [QRImageView addGestureRecognizer:longPressGR];
    backView.contentSize=QRImageView.frame.size;
    
    
    
}

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
return _QRImageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"----%f",scrollView.contentSize.width);
    
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    [_QRImageView setCenter:CGPointMake(xcenter, ycenter)];
 

}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view

{

}

-(void)clearWidow:(UITapGestureRecognizer *)sender{
    
    _QRImageView.frame = CGRectMake(0, 0, _QRImageView.image.size.width, _QRImageView.image.size.height);
    _QRImageView.contentMode = UIViewContentModeScaleAspectFit;
    _backView.contentOffset = CGPointMake(0, 0);
    _backView.contentSize=_QRImageView.frame.size;
    _QRImageView.center = _backView.center;
    [UIView animateWithDuration:0.7 animations:^{
        
        _QRImageView.frame = imageRect;
        _backView.alpha = 0;
       // _QRImageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [_backView removeFromSuperview];
        [_QRImageView removeFromSuperview];

    }];
    
    
    
    
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)sender{
    
    
    CGRect rect = _QRImageView.frame;
    
    
    _QRImageView.frame = CGRectMake(0, 0, rect.size.width*1.5, rect.size.height*1.5);
    _backView.contentSize = CGSizeMake(rect.size.width*1.5, rect.size.width*1.5);
    
    _backView.scrollEnabled = YES;
    _QRImageView.center = _backView.center;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll");
    NSLog(@"scroll = %f---%f----%f",scrollView.contentOffset.x,_backView.contentOffset.x,_backView.contentOffset.y);
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
    
    // Configure the view for the selected state
}

@end
