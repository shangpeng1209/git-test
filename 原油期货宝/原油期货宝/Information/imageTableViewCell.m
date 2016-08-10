//
//  imageTableViewCell.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/3.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "imageTableViewCell.h"

//@implementation imageTableViewCell

//
//  infoTableViewCell.m
//  原油期货宝
//
//  Created by 尚朋 on 16/8/1.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#import "imageTableViewCell.h"

@interface imageTableViewCell ()

@property (nonatomic, strong) NSString *imagePath;

@end


@implementation imageTableViewCell

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

-(void)loadUI{
    
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(40, 0, ScreenWidth-40, 150)];
   // _textView = textView;
    textView.userInteractionEnabled = NO;
    // [self.contentView addSubview:textView];
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    webView.userInteractionEnabled = NO;
    //    _webView = webView;
    //    [self.contentView addSubview:webView];
    
    
    
    
    
    _time = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 50, 10)];
    _time.backgroundColor = RGBA(231, 231, 231, 1);
    
    _time.font = [UIFont systemFontOfSize:8];
    [_time.layer setMasksToBounds:YES];
    [_time.layer setCornerRadius:5.0];
    
    
    
    
    [self.contentView addSubview:_time];
    _line = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 1, 15)];
    
    _line.backgroundColor = RGBA(231, 231, 231, 1);
    [self.contentView addSubview:_line];
    
    
    _line1= [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 20, 1)];
    
    _line1.backgroundColor = RGBA(231, 231, 231, 1);
    [self.contentView addSubview:_line1];
    
    UIView * redView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, 10, 10)];
    [redView.layer setMasksToBounds:YES];
    [redView.layer setCornerRadius:5];
    
    
    
    redView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:redView];
    
    
    _titleLable = [[UILabel alloc]init];
    _titleLable.numberOfLines = 0;
    [self.contentView addSubview:_titleLable];
    
    
    _firstImageView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_firstImageView];
    
    
    
    
    
    
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    //    self.headImageView.origin = CGPointMake(10, 10);
    //    self.firstImageView.size = getTextSize(self.userNameLabel.font, self.userNameLabel.text,
    //                                          self.contentView.width - self.headImageView.right);
    //    self.firstImageView.origin = CGPointMake(self.headImageView.right + 10, self.headImageView.y);
    
    
    
    
    
    
    
    
    
    
    
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
        [_firstImageView setImage:[UIImage imageNamed:@"findPage_04"]];
        
        //[_firstImageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"shareIcon"]];
        
        _firstImageView.frame = CGRectMake(_titleLable.current_x, _titleLable.current_y_h+10, _titleLable.current_w/3, 40);
        
        self.height = _firstImageView.current_y_h+10;
        
        
    }else{
        
        self.height = _titleLable.current_y_h+10;
        
        
    }
    
    _line.frame = CGRectMake(20, 5, 1, _height-5);
    
}

-(void)setMarkCellWithStr:(NSString *)value{
    
    
    
    _titleLable.text = value;
    
    self.height = 40;
    
    
    
}



- (void)prepareForReuse
{
    [super prepareForReuse];
    
    
    if (_imagePath == nil || [_imagePath isEqualToString:@""]) {
        
        
        for (id view in [self.contentView subviews])
            
        {
            
            if ([view isKindOfClass:[UIImageView class]])
                
            {
                
                [view removeFromSuperview];
                
            }
            
        }
        
    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    
    
    // Configure the view for the selected state
}



@end
