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
    NSMutableArray     *m_arrayStoreBtn;
    
    UIScrollView       *m_scorllView;
    
    
    CGFloat             m_fWidth;
    CGFloat             m_fheight;
    
    int                 m_iFlagMineNum;     //mine flag number
    
    BOOL                m_bIsStart;
    int                 m_iFlagRightNumber;
    
}
@property(nonatomic,retain)JFMineLevelConfig *mineConfig;
@property(nonatomic,retain)JFTitleClickButton *titleView;

@end
