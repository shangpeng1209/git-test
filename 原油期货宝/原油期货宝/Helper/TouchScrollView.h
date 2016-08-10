//
//  TouchScrollView.h
//  微油宝
//
//  Created by 尚朋 on 16/6/3.
//  Copyright © 2016年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIScrollViewTouchesDelegate
-(void)scrollViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event whichView:(id)scrollView;
@end


@interface TouchScrollView : UIScrollView

@property(nonatomic,assign) id<UIScrollViewTouchesDelegate> touchesdelegate;

@end
