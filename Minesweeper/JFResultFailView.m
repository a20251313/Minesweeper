//
//  JFResultFailView.m
//  Minesweeper
//
//  Created by ran on 13-8-22.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFResultFailView.h"

@implementation JFResultFailView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.contents = (id)[UIImage imageNamed:@"10-board-background.png"].CGImage;
        
        CGFloat   fHeight = frame.size.height-20;
        CGFloat   fwidth = frame.size.width-60;
        
    //    CGFloat   fXpoint = 10;
        CGFloat   fYpoint = fHeight - 44*2-10*2;
        
        
        
        UILabel   *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, self.frame.size.width, 21)];
        label.backgroundColor = [UIColor clearColor];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor purpleColor]];
        [label setText:@"您踩到地雷了！"];
        [self addSubview:label];
        [label release];
        
        UIButton    *btnRestart = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width-fwidth)/2, fYpoint, fwidth, 44)];
        [btnRestart setTitle:@"再来一次" forState:UIControlStateNormal];
        [btnRestart setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [btnRestart setBackgroundImage:[UIImage imageNamed:@"restart_game.png"] forState:UIControlStateNormal];
        [btnRestart addTarget:self action:@selector(restartGame:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnRestart];
        [btnRestart release];
        
        
        fYpoint += 44+10;
        UIButton    *btnQuit = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width-fwidth)/2, fYpoint, fwidth, 44)];
        [btnQuit setBackgroundImage:[UIImage imageNamed:@"quit_choice.png"] forState:UIControlStateNormal];
        [btnQuit addTarget:self action:@selector(quitGame:) forControlEvents:UIControlEventTouchUpInside];
        [btnQuit setTitle:@"退  出" forState:UIControlStateNormal];
        [btnQuit setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [self addSubview:btnQuit];
        [btnQuit release];
        
        
        UIButton        *btn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-26, -13, 26, 26)];
        [btn setBackgroundImage:[UIImage imageNamed:@"close_info@2x.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn release];
        
        
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)restartGame:(id)sender
{
    

    if (delegate  && [delegate respondsToSelector:@selector(restartGame:)])
    {
        [delegate restartGame:self];
    }
    [self removeFromSuperview];
}


-(void)quitGame:(id)sender
{
    [self removeFromSuperview];
}
@end
