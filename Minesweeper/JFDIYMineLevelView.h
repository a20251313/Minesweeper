//
//  JFDIYMineLevelView.h
//  Minesweeper
//
//  Created by ran on 13-8-15.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFMineLevelConfig.h"
@protocol JFDIYMineLevelViewDelegate <NSObject>

-(void)getMineLevel:(JFMineLevelConfig *)mineConfig;

@end
@interface JFDIYMineLevelView : UIView
{
    UILabel     *labelWidth;
    UILabel     *labelHeight;
    UILabel     *labelMineNumber;
    
    UISlider    *sliderWidth;
    UISlider    *sliderHeight;
    UISlider    *sliderMineNumber;
    
    id<JFDIYMineLevelViewDelegate>  delegate;
}

@property(nonatomic,assign)id<JFDIYMineLevelViewDelegate> delegate;
@end
