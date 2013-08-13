//
//  JFAppearenceViewController.h
//  Minesweeper
//
//  Created by ran on 13-7-31.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFGameInfoModel.h"

@interface JFAppearenceViewController : UIViewController<UIScrollViewDelegate,UIPageViewControllerDelegate>
{
    UIScrollView            *m_scrollView;
    UIPageControl           *m_pageControl;
}

@end
