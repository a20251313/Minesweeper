//
//  JFDIYMineLevelView.h
//  Minesweeper
//
//  Created by ran on 13-8-15.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFDIYMineLevelView : UIView
{
    UILabel     *labelWidth;
    UILabel     *labelHeight;
    UILabel     *labelMineNumber;
    
    UISlider    *sliderWidth;
    UISlider    *sliderHeight;
    UISlider    *sliderMineNumber;
}

@end
