//
//  JFViewController.h
//  Minesweeper
//
//  Created by ran on 13-7-12.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFTitleClickButton.h"
#import "JFMineLevelConfig.h"
#import "JFMineButton.h"


@interface JFViewController : UIViewController<JFTitleClickButtonDelegate,JFMineButtonDelegate>
{
    JFMineLevelConfig  *m_objMineConfig;
    
    UIScrollView       *m_scorllView;
    
    
    CGFloat             m_fWidth;
    CGFloat             m_fheight;
    
}
@property(nonatomic,retain)JFMineLevelConfig *mineConfig;
@property(nonatomic,retain)JFTitleClickButton *titleView;

@end
