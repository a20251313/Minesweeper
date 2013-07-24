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
    JFMineButtonFlagNone = 1,
    JFMineButtonFlagIsMine,
    JFMineButtonFlagIsNotSure,
    JFMineButtonFlagShowMine,
    JFMineButtonFlagShowNumber,
    JFMineButtonFlagWrongMine,
    JFMineButtonFlagWMineExpo
}JFMineButtonFlag;


typedef enum
{
    JFUserMarkNone = 1,
    JFUserMarkQuestion,
    JFUserMarkMine
}JFUserMark;

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
    JFUserMark          m_iUserMark;
    id<JFMineButtonDelegate>  delegate;
}
@property(nonatomic,assign)id<JFMineButtonDelegate> delegate;

@property(nonatomic)int picMynumer;
@property(nonatomic)int mineNumber;
@property(nonatomic)BOOL isMine;
@property(nonatomic)JFUserMark userMark;;
@property(nonatomic)BOOL       IsShow;
@property(nonatomic)JFMineButtonFlag       buttonFlag;

- (id)initWithFrame:(CGRect)frame withPicNumber:(int)picNumber;
-(void)modifyPicNumber:(int)picNumber;
-(void)showUserMark:(JFUserMark)mark;
-(void)setMineFlag:(JFMineButtonFlag)flag;

@end
