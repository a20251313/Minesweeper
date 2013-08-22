//
//  JFResultFailView.h
//  Minesweeper
//
//  Created by ran on 13-8-22.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFResultShowView.h"
@interface JFResultFailView : UIView
{
    id<JFResultShowViewDelegate>  delegate;
}


@property(nonatomic,assign)id<JFResultShowViewDelegate>  delegate;

@end
