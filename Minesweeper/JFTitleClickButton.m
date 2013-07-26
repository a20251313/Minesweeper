//
//  JFTitleClickButton.m
//  Minesweeper
//
//  Created by ran on 13-7-22.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFTitleClickButton.h"


#define LeftLabelTag        60
#define RightLabelTag        61
#define SmileViewTag        62

@implementation JFTitleClickButton
//120+24  48
@synthesize mineConfig = m_objConfig;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame WithConfig:(JFMineLevelConfig*)config
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.mineConfig = config;
        
        m_iSeconds = 0;
        UILabel  *labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 55, 24)];
        labelLeft.textAlignment = UITextAlignmentRight;
        labelLeft.textColor = [UIColor redColor];
        labelLeft.text = [NSString stringWithFormat:@"%d",self.mineConfig.mineNumber];
        labelLeft.backgroundColor = [UIColor clearColor];
        labelLeft.font = [UIFont systemFontOfSize:18];
        labelLeft.tag = LeftLabelTag;
        [self addSubview:labelLeft];
        [labelLeft release];
        
        
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 12, 24, 24)];
        imageView.image = [UIImage imageNamed:@"smile1.png"];
        imageView.userInteractionEnabled = YES;
        imageView.tag = SmileViewTag;
        [self addSubview:imageView];
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSmileView:)];
        [imageView addGestureRecognizer:tap];
        [tap release];
        [imageView release];
        
        
        
        
        
        UILabel  *labelRight = [[UILabel alloc] initWithFrame:CGRectMake(65+24, 12, 60, 24)];
        labelRight.textAlignment = UITextAlignmentLeft;
        labelRight.textColor = [UIColor redColor];
        labelRight.text = @"00:00";
        labelRight.backgroundColor = [UIColor clearColor];
        labelRight.font = [UIFont systemFontOfSize:18];
        labelRight.tag = RightLabelTag;
        [self addSubview:labelRight];
        [labelRight release];
    
        // Initialization code
    }
    return self;
}



-(void)setMineFlagNumber:(int)flagNumber
{
    UILabel  *label = (UILabel *)[self viewWithTag:LeftLabelTag];
    if (flagNumber < 10)
    {
       [label setText:[NSString stringWithFormat:@"0%d",flagNumber]]; 
    }else
    {
        [label setText:[NSString stringWithFormat:@"0%d",flagNumber]]; 
    }
    
}

-(void)startTimer
{
    m_iSeconds = 0;
    if (m_timer)
    {
        [m_timer invalidate];
        [m_timer release];
         m_timer = nil;
    }
    
    m_timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(timeChange:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer
{
    if (m_timer)
    {
        [m_timer release];
        m_timer = nil;
    }
    
}

-(void)timeChange:(NSTimer *)timer
{
    m_iSeconds++;
    
    int seconds = m_iSeconds%60;
    int minutes = m_iSeconds/60;
    
    NSString  *strTime = @"";
    
    if (minutes < 10)
    {
        strTime = [NSString stringWithFormat:@"0%d:",minutes];
    }else
    {
        strTime = [NSString stringWithFormat:@"%d:",minutes];
    }
    
    if (seconds < 10)
    {
        strTime = [NSString stringWithFormat:@"%@0%d",strTime,seconds];
    }else
    {
        strTime = [NSString stringWithFormat:@"%@%d",strTime,seconds];
    }
    
    UILabel  *labelTime = (UILabel *)[self viewWithTag:RightLabelTag];
    
    if (labelTime)
    {
        [labelTime setText:strTime];
    }
    
  //  NSLog(@"timeChange:%@",strTime);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)clickSmileView:(UITapGestureRecognizer *)tap
{
    
    if (delegate && [delegate respondsToSelector:@selector(clickTitleButton:)])
    {
        [delegate clickTitleButton:self];
    }
    
    NSLog(@"clickSmileView:%@",tap);
}

-(void)dealloc
{
    if (m_timer)
    {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
    self.mineConfig = nil;
    [super dealloc];
}

@end
