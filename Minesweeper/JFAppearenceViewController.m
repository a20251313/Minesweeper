//
//  JFAppearenceViewController.m
//  Minesweeper
//
//  Created by ran on 13-7-31.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFAppearenceViewController.h"

@interface JFAppearenceViewController ()

@end

@implementation JFAppearenceViewController

-(id)init
{
    self = [super init];
    if (self)
    {
    
    }
    return self;
}


-(void)loadView
{
    [super loadView];
    
    self.title = @"外观";
    self.tabBarItem.image = [UIImage imageNamed:@""];
    self.tabBarItem.title = self.title;
    
    
    int  maxCount = 10;
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, frame.size.height-44-44)];
    m_scrollView.contentSize = CGSizeMake(320*maxCount, frame.size.height-44-44);
    [self.view addSubview:m_scrollView];
    
    
    
    
    
}


-(void)dealloc
{
    [m_scrollView release];
    m_scrollView = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
