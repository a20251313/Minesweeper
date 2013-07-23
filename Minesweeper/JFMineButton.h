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

@protocol JFMineButtonDelegate <NSObject>
-(void)clickMineButton:(JFMineButton*)mineButton;
-(void)longPressMineButton:(JFMineButton*)mineButton;
@end

@interface JFMineButton : UIButton
{
    int    m_ipicMynumer;
    int    m_iMineNumber;
    BOOL   m_bIsMine;
    JFMineButtonFlag    m_ibuttonFlag;
    id<JFMineButtonDelegate>  delegate;
}
@property(nonatomic,assign)id<JFMineButtonDelegate> delegate;

@property(nonatomic)int picMynumer;
@property(nonatomic)int mineNumber;
@property(nonatomic)BOOL isMine;

- (id)initWithFrame:(CGRect)frame withPicNumber:(int)picNumber;
-(void)modifyPicNumber:(int)picNumber;

@end
