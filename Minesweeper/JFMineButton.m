//
//  JFMineButton.m
//  Minesweeper
//
//  Created by ran on 13-7-17.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFMineButton.h"


//#define MYPICNUMBER 1

//24*24
@implementation JFMineButton
@synthesize picMynumer = m_ipicMynumer;
@synthesize mineNumber = m_iMineNumber;
@synthesize delegate;
@synthesize isMine = m_bIsMine;

- (id)initWithFrame:(CGRect)frame withPicNumber:(int)picNumber
{
    m_ibuttonFlag = JFMineButtonFlagNone;
    m_ipicMynumer = picNumber;
    
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-base.png",m_ipicMynumer]] forState:UIControlStateNormal];
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMineButton:)];
        [self addGestureRecognizer:tap];
        [tap release];
        
        UILongPressGestureRecognizer  *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMineButton:)];
        [self addGestureRecognizer:longPress];
        [longPress release];
        
        
        m_bIsMine = NO;
        // Initialization code
    }
    return self;
}



-(void)clickMineButton:(id)sender
{
    if (delegate  && [delegate respondsToSelector:@selector(clickMineButton:)])
    {
        [delegate clickMineButton:self];
    }
    NSLog(@"clickMineButton:%@",sender);
}


-(void)longPressMineButton:(id)sender
{
    if (delegate  && [delegate respondsToSelector:@selector(longPressMineButton:)])
    {
        [delegate longPressMineButton:self];
    }
    
    NSLog(@"longPressMineButton:%@",sender);
}
-(void)setMineNumber:(int)number
{
    [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-%d.png",m_ipicMynumer,number]] forState:UIControlStateNormal];
}

-(void)modifyPicNumber:(int)picNumber
{
    m_ipicMynumer = picNumber;
    [self setMineFlag:m_ibuttonFlag];
}

-(void)setMineFlag:(JFMineButtonFlag)flag
{
    m_ibuttonFlag = JFMineButtonFlagNone;
    switch (flag)
    {
        case JFMineButtonFlagNone:
             [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-base.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        case JFMineButtonFlagIsMine:
             [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-tile_flag.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        case JFMineButtonFlagIsNotSure:
             [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-tile_question.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        case JFMineButtonFlagShowMine:
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-mine.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        case JFMineButtonFlagShowNumber:
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-%d.png",m_ipicMynumer,m_iMineNumber]] forState:UIControlStateNormal];
            break;
        case JFMineButtonFlagWrongMine:
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-wrong_flag.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        case JFMineButtonFlagWMineExpo:
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-mine_expo.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
