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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-base.png",m_ipicMynumer]] forState:UIControlStateNormal];
        
        // Initialization code
    }
    return self;
}


-(void)setMineNumber:(int)number
{
    [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-%d.png",m_ipicMynumer,number]] forState:UIControlStateNormal];
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
