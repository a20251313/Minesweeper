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
#import "CABasicAnimation+someAniForProp.h"
#import "NSMutableSet+addObjects.h"
#import "JFSettingViewController.h"
#import "JFAppearenceViewController.h"
#import "JFHelpViewController.h"
#import "JFVictoryViewController.h"


@interface JFViewController : UIViewController<JFTitleClickButtonDelegate,JFMineButtonDelegate>
{
    JFMineLevelConfig  *m_objMineConfig;
    NSMutableArray     *m_arrayStoreBtn;
    
    UIScrollView       *m_scorllView;
    
    
    CGFloat             m_fWidth;
    CGFloat             m_fheight;
    
    int                 m_iFlagMineNum;     //mine flag number
    
    BOOL                m_bIsStart;
    int                 m_iFlagRightNumber;
    
    CGFloat             m_fMineWidth;

    
    UINavigationController  *m_nav;
    
}
@property(nonatomic,retain)JFMineLevelConfig *mineConfig;
@property(nonatomic,retain)JFTitleClickButton *titleView;

@end
