//
//  JFViewController.m
//  Minesweeper
//
//  Created by ran on 13-7-12.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFViewController.h"



@interface JFViewController ()

@end

@implementation JFViewController
@synthesize mineConfig = m_objMineConfig;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    JFMineLevelConfig  *config = [[JFMineLevelConfig alloc] init];
    config.mineNumber = 99;
    config.totalButtonNumber = 220;
    config.minePicNumber = 2;
    self.mineConfig = config;
    [config release];
  
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        
        NSString   *strPicName = [NSString stringWithFormat:@"%d-bar.png",m_objMineConfig.minePicNumber];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:strPicName] forBarMetrics:UIBarMetricsDefault];
    }

    
    [self initNowView];
 
   
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)dealloc
{
    self.mineConfig = nil;
    [super dealloc];
}

-(void)initNowView
{
    
    JFTitleClickButton  *titleView = [[JFTitleClickButton alloc] initWithFrame:CGRectMake(0, 0, 120+48, 48) WithConfig:self.mineConfig];
    self.navigationItem.titleView = titleView;
    [titleView release];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark JFTitleClickButton
-(void)clickTitleButton:(JFTitleClickButton*)buttonView
{
    
}

@end
