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
    
        self.title = @"外观";
        self.tabBarItem.image = [UIImage imageNamed:@"appearance.png"];
        self.tabBarItem.title = @"外观";
        
        self.navigationItem.leftBarButtonItem = nil;
        UIBarButtonItem  *barBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        self.navigationItem.rightBarButtonItem = barBtn;
        [barBtn release];
    }
    return self;
}


-(void)loadView
{
    [super loadView];
    

    
    self.view.backgroundColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1.0f];
    int  maxCount = 10;
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20-44-44)];
    m_scrollView.contentSize = CGSizeMake(320*maxCount, frame.size.height-20-44-44);
    [self.view addSubview:m_scrollView];
    m_scrollView.delegate = self;
    m_scrollView.pagingEnabled = YES;
    
    m_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, m_scrollView.frame.size.height-40, frame.size.width, 20)];
    m_pageControl.numberOfPages = maxCount;
    m_pageControl.currentPage = 0;
    [self.view addSubview:m_pageControl];
    
    
    
    for (int i = 0; i < 11; i++)
    {
        NSString  *strImageMame = [NSString stringWithFormat:@"%d-sample.png",i+1];
        UIView   *bgView = [[UIView alloc] initWithFrame:CGRectMake(0+i*frame.size.width, 0, frame.size.width, frame.size.height-20-44-44)];
        
        //216*216
        [m_scrollView addSubview:bgView];
        UIImageView   *view = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-216)/2, (bgView.frame.size.height-216)/2, 216, 216)];
        view.userInteractionEnabled = YES;
        view.tag = i+1;
        view.image = [UIImage imageNamed:strImageMame];
        [bgView addSubview:view];
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAppearenceView:)];
        [view addGestureRecognizer:tap];
        [tap release];
        [view release];
        [bgView release];
    }
    
    

}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationController.title = @"外观";
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    UIBarButtonItem  *barBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.tabBarController.navigationItem.rightBarButtonItem = barBtn;
    [barBtn release];
}

-(void)done:(id)sender
{
    [self.tabBarController.navigationController.view removeFromSuperview];
    //[self.navigationController popViewControllerAnimated:YES];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView//;      // called when scroll view grinds to a halt
{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    int page = scrollView.contentOffset.x/frame.size.width;
    m_pageControl.currentPage = page;
        
}


-(void)clickAppearenceView:(UITapGestureRecognizer *)tap
{
    DLOG(@"tap:%@ \n tapView:%@",tap,tap.view);
    
}
-(void)dealloc
{
    [m_scrollView release];
    m_scrollView = nil;
    [m_pageControl release];
    m_pageControl = nil;
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
