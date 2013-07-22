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
//120+48  48
@synthesize mineConfig = m_objConfig;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame WithConfig:(JFMineLevelConfig*)config
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.mineConfig = config;
        
        
        UILabel  *labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 60, 24)];
        labelLeft.textAlignment = UITextAlignmentRight;
        labelLeft.textColor = [UIColor redColor];
        labelLeft.text = [NSString stringWithFormat:@"%d",self.mineConfig.mineNumber];
        labelLeft.backgroundColor = [UIColor clearColor];
        labelLeft.font = [UIFont systemFontOfSize:18];
        labelLeft.tag = LeftLabelTag;
        [self addSubview:labelLeft];
        [labelLeft release];
        
        
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 0, 48, 48)];
        imageView.image = [UIImage imageNamed:@"smile1.png"];
        imageView.userInteractionEnabled = YES;
        imageView.tag = SmileViewTag;
        [self addSubview:imageView];
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSmileView:)];
        [imageView addGestureRecognizer:tap];
        [tap release];
        [imageView release];
        
        
        
        
        
        UILabel  *labelRight = [[UILabel alloc] initWithFrame:CGRectMake(60+48, 12, 60, 24)];
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
    
    self.mineConfig = nil;
    [super dealloc];
}

@end
