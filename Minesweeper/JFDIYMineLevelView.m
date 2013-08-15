//
//  JFDIYMineLevelView.m
//  Minesweeper
//
//  Created by ran on 13-8-15.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFDIYMineLevelView.h"
#import <QuartzCore/QuartzCore.h>
@implementation JFDIYMineLevelView
@synthesize delegate;

//260*160
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        self.layer.contents = (id)[UIImage imageNamed:@"10-board-background.png"].CGImage;
        
        CGFloat  fXpoint = 5;
        CGFloat  fYpoint = 5;
        CGFloat  fSlideWidth = 120;
        CGFloat  fLabelWidth = 60;
        CGFloat  fLabelHeigth = 21;
        CGFloat  fSep = 10;
        
        UILabel  *labelName = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+15, fLabelWidth, fLabelHeigth)];
        labelName.backgroundColor = [UIColor clearColor];
        labelName.font = [UIFont systemFontOfSize:17];
        labelName.text = @"宽度";
        labelName.textColor = [UIColor blueColor];
        labelName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelName];
        [labelName release];
        
        
        fXpoint += fLabelWidth;
        sliderWidth = [[UISlider alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+25, fSlideWidth, fLabelHeigth)];
        sliderWidth.layer.anchorPoint = CGPointMake(0.5, 1);
        sliderWidth.transform = CGAffineTransformMakeRotation(M_PI*2);
        sliderWidth.minimumValue = 9;
        sliderWidth.maximumValue = 24;
        sliderWidth.continuous = NO;
        [sliderWidth setValue:9];
        [sliderWidth addTarget:self action:@selector(slideValueChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:sliderWidth];
        
        fXpoint += fSep+fSlideWidth;
        labelWidth = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+15, fLabelWidth, fLabelHeigth)];
        labelWidth.backgroundColor = [UIColor clearColor];
        labelWidth.font = [UIFont systemFontOfSize:17];
        labelWidth.text = @"9/24";
        labelWidth.textColor = [UIColor blueColor];
        [self addSubview:labelWidth];
 
        
        fXpoint = 5;
        fYpoint += fLabelHeigth+fSep;
        
        
        
        UILabel  *labelNameHeight = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+15, fLabelWidth, fLabelHeigth)];
        labelNameHeight.backgroundColor = [UIColor clearColor];
        labelNameHeight.font = [UIFont systemFontOfSize:17];
        labelNameHeight.text = @"高度";
        labelNameHeight.textColor = [UIColor blueColor];
        labelNameHeight.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelNameHeight];
        [labelNameHeight release];
        
        
        fXpoint += fLabelWidth;//+fSep+fSlideWidth;
        sliderHeight = [[UISlider alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+25, fSlideWidth, fLabelHeigth)];
        sliderHeight.layer.anchorPoint = CGPointMake(0.5, 1);
        sliderHeight.transform = CGAffineTransformMakeRotation(M_PI*2);
        sliderHeight.minimumValue = 9;
        sliderHeight.maximumValue = 30;
        sliderHeight.continuous = NO;
        [sliderHeight setValue:9];
        [sliderHeight addTarget:self action:@selector(slideValueChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:sliderHeight];
        
        fXpoint += fSep+fSlideWidth;
        labelHeight = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+15, fLabelWidth, fLabelHeigth)];
        labelHeight.backgroundColor = [UIColor clearColor];
        labelHeight.font = [UIFont systemFontOfSize:17];
        labelHeight.text = @"9/30";
        labelHeight.textColor = [UIColor blueColor];
        [self addSubview:labelHeight];
        
        
        fXpoint = 5;
        fYpoint += fLabelHeigth+fSep;
        
        
        
        UILabel  *labelNameMinenumber = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+15, fLabelWidth, fLabelHeigth)];
        labelNameMinenumber.backgroundColor = [UIColor clearColor];
        labelNameMinenumber.font = [UIFont systemFontOfSize:17];
        labelNameMinenumber.text = @"地雷";
        labelNameMinenumber.textColor = [UIColor blueColor];
        labelNameMinenumber.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelNameMinenumber];
        [labelNameMinenumber release];
        
        
        fXpoint += fLabelWidth;
        sliderMineNumber = [[UISlider alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+25, fSlideWidth, fLabelHeigth)];
        sliderMineNumber.layer.anchorPoint = CGPointMake(0.5, 1);
        sliderMineNumber.transform = CGAffineTransformMakeRotation(M_PI*2);
        sliderMineNumber.minimumValue = 10;
        sliderMineNumber.maximumValue = 64;
        sliderMineNumber.continuous = NO;
        [sliderMineNumber setValue:10];
        [sliderMineNumber addTarget:self action:@selector(slideValueChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:sliderMineNumber];
        
        fXpoint += fSep+fSlideWidth;
        labelMineNumber = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+15, fLabelWidth+40, fLabelHeigth)];
        labelMineNumber.backgroundColor = [UIColor clearColor];
        labelMineNumber.font = [UIFont systemFontOfSize:17];
        labelMineNumber.text = @"10/64";
        labelMineNumber.textColor = [UIColor blueColor];
        [self addSubview:labelMineNumber];
        
        
        
        fXpoint = 20;
        fYpoint += fLabelHeigth+fSep;
        
        
        //85 *40
        UIButton  *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+35, 85, 40)];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancel setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        btnCancel.layer.masksToBounds = YES;
        btnCancel.layer.cornerRadius = 5;
        [btnCancel addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCancel];
        [btnCancel release];
        
        
        
        fXpoint += fSep+120;
        UIButton  *btnSure = [[UIButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint+35, 85, 40)];
        [btnSure setTitle:@"确定" forState:UIControlStateNormal];
        btnSure.layer.masksToBounds = YES;
        btnSure.layer.cornerRadius = 5;
        
        [btnSure setBackgroundImage:[UIImage imageNamed:@"makesure"] forState:UIControlStateNormal];
        [btnSure addTarget:self action:@selector(clickSure:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnSure];
        [btnSure release];
        
        
       
        
        // Initialization code
    }//200
    return self;
}


-(void)slideValueChange:(UISlider *)slider
{
    
    if (slider == sliderMineNumber)
    {
        
         labelMineNumber.text = [NSString stringWithFormat:@"%d/%d",(int)sliderMineNumber.value,(int)sliderMineNumber.maximumValue];
        return;
    }
    CGFloat  fMinRate = 10.0/(9*9*1.0f);
    CGFloat  fMaxRate = 64.0f/(9*9*1.0f);
    
    int  width = sliderWidth.value;
    int  height = sliderHeight.value;
    
    int minMine = width*height*fMinRate;
    int maxMine = width*height*fMaxRate;
    
    sliderMineNumber.minimumValue = minMine;
    sliderMineNumber.maximumValue = maxMine;
    [sliderMineNumber setValue:minMine];
    
    labelWidth.text = [NSString stringWithFormat:@"%d/%d",(int)sliderWidth.value,(int)sliderWidth.maximumValue];
    labelHeight.text = [NSString stringWithFormat:@"%d/%d",(int)sliderHeight.value,(int)sliderHeight.maximumValue];
    labelMineNumber.text = [NSString stringWithFormat:@"%d/%d",minMine,maxMine];
    
    
    DLOG(@"sliderValue:%f",slider.value);
}
-(void)clickCancel:(id)sender
{
    
    [self removeFromSuperview];
     DLOG(@"clickCancel:%@",sender);
}

-(void)clickSure:(id)sender
{
    
   
    
    if (delegate && [delegate respondsToSelector:@selector(getMineLevel:)])
    {
        
        JFMineLevelConfig  *levelConfig = [[JFMineLevelConfig alloc] init];
        levelConfig.minelevel = JFMineLevelSelfMake;
        levelConfig.mineNumber = sliderMineNumber.value;
        levelConfig.rowNumber = sliderWidth.value;
        levelConfig.colummNumber = sliderHeight.value;

        [delegate getMineLevel:levelConfig];
        [levelConfig release];
    }
    
    
     [self removeFromSuperview];
    DLOG(@"clickSure:%@",sender);
}


-(void)dealloc
{
    [labelHeight release];
    [labelMineNumber release];
    [labelWidth release];
    
    [sliderMineNumber release];
    [sliderHeight release];
    [sliderWidth release];
    
    [super dealloc];
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
