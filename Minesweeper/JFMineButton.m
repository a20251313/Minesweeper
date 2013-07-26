//
//  JFMineButton.m
//  Minesweeper
//
//  Created by ran on 13-7-17.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFMineButton.h"


//#define MYPICNUMBER 1

//48*48
@implementation JFMineButton
@synthesize picMynumer = m_ipicMynumer;
@synthesize mineNumber = m_iMineNumber;
@synthesize delegate;
@synthesize isMine = m_bIsMine;
@synthesize userMark;
@synthesize IsShow;
@synthesize buttonFlag = m_ibuttonFlag;

- (id)initWithFrame:(CGRect)frame withPicNumber:(int)picNumber
{
    self.buttonFlag = JFMineButtonFlagNone;
    m_ipicMynumer = picNumber;
    m_iMineNumber = 0;
    IsShow = NO;
    
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-tile.png",m_ipicMynumer]] forState:UIControlStateNormal];
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMineButton:)];
        [self addGestureRecognizer:tap];
        [tap release];
        
        UILongPressGestureRecognizer  *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMineButton:)];
        [self addGestureRecognizer:longPress];
        [longPress release];
        
        
        m_bIsMine = NO;
        
        [self addTarget:self action:@selector(eventInfo:) forControlEvents:UIControlEventAllTouchEvents];
        // Initialization code
    }
    return self;
}

-(void)eventInfo:(id)info
{
    NSLog(@"info:%@",info);
}


-(void)clickMineButton:(id)sender
{
    if (delegate  && [delegate respondsToSelector:@selector(clickMineButton:)])
    {
        [delegate clickMineButton:self];
    }
    NSLog(@"clickMineButton:%@",sender);
}


-(void)longPressMineButton:(UILongPressGestureRecognizer *)tap
{
    
    if (tap.state != UIGestureRecognizerStateEnded)
    {
        return;
    }
    if (delegate  && [delegate respondsToSelector:@selector(longPressMineButton:)])
    {
        [delegate longPressMineButton:self];
    }
    
    NSLog(@"longPressMineButton:%@",tap);
}
-(void)setMineNumber:(int)number
{
    m_iMineNumber = number;
  //  [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-%d.png",m_ipicMynumer,number]] forState:UIControlStateNormal];
}

-(void)modifyPicNumber:(int)picNumber
{
     m_ipicMynumer = picNumber;
    [self setMineFlag:m_ibuttonFlag];
}

-(void)setMineFlag:(JFMineButtonFlag)flag
{
    self.buttonFlag = flag;
    switch (flag)
    {
        case JFMineButtonFlagNone:
             [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-tile.png",m_ipicMynumer]] forState:UIControlStateNormal];
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
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-%d.png",m_ipicMynumer,self.mineNumber]] forState:UIControlStateNormal];
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
    
  //  NSLog(@"%@",self);
}

-(void)showUserMark:(JFUserMark)mark
{
    self.userMark = mark;
    
    switch (m_iUserMark)
    {
        case JFUserMarkMine:
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-tile_flag.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        case JFUserMarkNone:
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-tile.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        case JFUserMarkQuestion:
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-tile_question.png",m_ipicMynumer]] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"address:<%p>,self.userMark:%d self.buttonFlag:%d self.mineNumber:%d self.IsMine:%d self.isShow:%d self.picNumber:%d",self,self.userMark,self.buttonFlag,self.mineNumber,self.isMine,self.IsShow,self.picMynumer];
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
