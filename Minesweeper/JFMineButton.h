//
//  JFMineButton.h
//  Minesweeper
//
//  Created by ran on 13-7-17.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    JFMineButtonFlagNone,
    JFMineButtonFlagIsMine,
    JFMineButtonFlagIsNotSure,
    JFMineButtonFlagShowMine,
    JFMineButtonFlagShowNumber,
    JFMineButtonFlagWrongMine,
    JFMineButtonFlagWMineExpo
}JFMineButtonFlag;

@class JFMineButton;
@protocol ClickMineButton <NSObject>
-(void)clickMineButton:(JFMineButton*)mineButton;
-(void)longPressMineButton:(JFMineButton*)mineButton;
@end

@interface JFMineButton : UIButton
{
    int    m_ipicMynumer;
    int    m_iMineNumber;
    JFMineButtonFlag    m_ibuttonFlag;
}


@property(nonatomic)int picMynumer;
@property(nonatomic)int mineNumber;

@end
