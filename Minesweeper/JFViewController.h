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



@interface JFViewController : UIViewController<JFTitleClickButtonDelegate>
{
    JFMineLevelConfig  *m_objMineConfig;
    
}
@property(nonatomic,retain)JFMineLevelConfig *mineConfig;

@end
