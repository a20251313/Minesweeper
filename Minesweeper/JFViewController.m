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
@synthesize titleView;


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_arrayStoreBtn = [[NSMutableArray alloc] init];
        
    }
    return self;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    JFMineLevelConfig  *config = [[JFMineLevelConfig alloc] init];
    config.mineNumber = 99;
    config.totalButtonNumber = 16*30;
    config.minePicNumber = 2;
    config.rowNumber = 16;
    config.colummNumber = 30;
    
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
    
    JFTitleClickButton  *titleViewTemp = [[JFTitleClickButton alloc] initWithFrame:CGRectMake(0, 0, 120+24, 48) WithConfig:self.mineConfig];
    titleViewTemp.delegate = self;
    self.navigationItem.titleView = titleViewTemp;
    self.titleView = titleViewTemp;
    [titleViewTemp startTimer];
    [titleViewTemp release];
    
    UIButton  *btn =[UIButton buttonWithType:UIButtonTypeInfoLight];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn addTarget:self action:@selector(clickInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem  *rightBaritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBaritem;
    [rightBaritem release];
    
    UIButton  *lButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 48)];
    [lButton setTitle:@"菜单" forState:UIControlStateNormal];
    [lButton setBackgroundColor:[UIColor clearColor]];
    [lButton addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barItem = [[UIBarButtonItem alloc] initWithCustomView:lButton];
    self.navigationItem.leftBarButtonItem = barItem;
    [lButton release];
    [barItem release];
    
    if (m_scorllView == nil)
    {
        CGRect frame = [UIScreen mainScreen].applicationFrame;
        
        //NSLog(@"frame:%@",[NSValue valueWithCGRect:frame]);
        m_scorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, frame.size.height-44-20)];
        m_scorllView.contentSize = m_scorllView.frame.size;
       // m_scorllView.contentOffset = CGPointMake(0, frame.size.width);
        m_fWidth = frame.size.width;
        m_fheight = frame.size.height-44;
        [self.view addSubview:m_scorllView];
        //m_scorllView.delegate = self;
    
    }
    
    [self initPlayViewWithConfig:self.mineConfig];
}


-(void)initPlayViewWithConfig:(JFMineLevelConfig*)config
{
    if (config != self.mineConfig)
    {
        self.mineConfig = config;
    }
    
    
    for (int i = 0; i < [m_arrayStoreBtn count]; i++)
    {
        JFMineButton  *btn = [m_arrayStoreBtn objectAtIndex:i];
        [btn removeFromSuperview];
        [m_arrayStoreBtn removeAllObjects];
    }
    CGFloat  fTempWidth = 48;
    CGFloat  fTempheight = 48;
    
    CGFloat  fYpoint = 0;
    CGFloat  fXpoint = 0;
    
    if (self.mineConfig.rowNumber*fTempheight < m_fheight)
    {
        fYpoint = (m_fheight-self.mineConfig.rowNumber*fTempheight)/2;
    }
    
    if (self.mineConfig.colummNumber*fTempWidth < m_fWidth)
    {
        fXpoint = (m_fWidth-self.mineConfig.colummNumber*fTempWidth)/2;
    }
    
    for (int i = 0 ; i < self.mineConfig.rowNumber * self.mineConfig.colummNumber; i++)
    {
        if (i%self.mineConfig.colummNumber == 0  && i != 0 )
        {
            if (self.mineConfig.colummNumber*fTempWidth < m_fWidth)
            {
                fXpoint = (m_fWidth-self.mineConfig.colummNumber*fTempWidth)/2;
            }else
            {
                fXpoint = 0;
            }
            fYpoint += fTempheight;
        }

        NSLog(@"fXpoint:%f fYpoint:%f",fXpoint,fYpoint);
        JFMineButton  *btnTemp = [[JFMineButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, fTempWidth, fTempheight) withPicNumber:self.mineConfig.minePicNumber];
        btnTemp.delegate = self;
        btnTemp.isMine = NO;
        btnTemp.tag = i;
        [m_scorllView addSubview:btnTemp];
         [m_arrayStoreBtn addObject:btnTemp];
        [btnTemp release];

        fXpoint+= fTempWidth;
       

    }
    
    
    NSMutableSet  *setNumber = [[NSMutableSet alloc] init];
    for (int i = 0; i < self.mineConfig.mineNumber; i++)
    {
       srandom(time(NULL));
        long  number = random()%(self.mineConfig.rowNumber*self.mineConfig.colummNumber);
        
        NSNumber  *longNumber = [NSNumber numberWithLong:number];
        
        BOOL  hasNumber = NO;
        
        while (!hasNumber)
        {
         
            if ([setNumber containsObject:longNumber])
            {
                number = random()%(self.mineConfig.rowNumber*self.mineConfig.colummNumber);
                longNumber = [NSNumber numberWithLong:number];
            }else
            {
                hasNumber = YES;
            }
        
        }
        
        
        
        [setNumber addObject:[NSNumber numberWithLong:number]];
        
        JFMineButton  *btn = [m_arrayStoreBtn objectAtIndex:number];
        btn.isMine = YES;
        NSLog(@"number:%ld",number);
        
        
    }
    
    NSLog(@"count:%d setNumber:%@",setNumber.count,setNumber);
    
    [self calutuleMineNumber];
    [m_scorllView setContentSize:CGSizeMake(self.mineConfig.rowNumber*fTempWidth, self.mineConfig.colummNumber*fTempheight)];
    [m_scorllView setContentOffset:CGPointMake(0, 0)];
    
}

-(void)calutuleMineNumber
{
   
    
    
    for (int i = 0; i < [m_arrayStoreBtn count]; i++)
    {
        JFMineButton  *btn = [m_arrayStoreBtn objectAtIndex:i];
        if (btn.isMine)
        {
            [btn setMineFlag:JFMineButtonFlagShowMine];
            continue;
        }
        
        int number = [self getAroundMineNumber:i mineConfig:self.mineConfig];
        btn.mineNumber = number;
        
        [btn setMineFlag:JFMineButtonFlagShowNumber];
        
    }
    
    
}


-(int)getAroundMineNumber:(int)i mineConfig:(JFMineLevelConfig *)config
{
    int  count = 0;
    int  rowNumber = self.mineConfig.rowNumber;
    int  columnNUmber= self.mineConfig.colummNumber;
    
    JFMineButton  *btnTemp = nil;
    //left isMine
    if (i-1 >= 0 && i-1 < rowNumber*columnNUmber)
    {
        if ((i-1)%columnNUmber == (columnNUmber-1))
        {
            
        }else
        {
            btnTemp = [m_arrayStoreBtn objectAtIndex:i-1];
            if (btnTemp.isMine)
            {
                count++;
            }
            
        }
        
    }
    
    
    //right
    if (i+1 >= 0 && i+1 < rowNumber*columnNUmber)
    {
        if ((i+1)%columnNUmber == 0)
        {
            
        }else
        {
            btnTemp = [m_arrayStoreBtn objectAtIndex:i+1];
            if (btnTemp.isMine)
            {
                count++;
            }
            
        }
        
    }
    
    
    //top 
    if (i-columnNUmber >= 0 && i-columnNUmber < rowNumber*columnNUmber)
    {
        
        btnTemp = [m_arrayStoreBtn objectAtIndex:i-columnNUmber];
        if (btnTemp.isMine)
        {
         count++;
        }
        
    }
    
    //top left
    if (i-columnNUmber-1 >= 0 && i-columnNUmber-1 < rowNumber*columnNUmber)
    {
        
        
        if ((i-columnNUmber-1)%columnNUmber == (columnNUmber-1))
        {
            
        }else
        {
            btnTemp = [m_arrayStoreBtn objectAtIndex:i-columnNUmber-1];
            if (btnTemp.isMine)
            {
                count++;
            }
            
        }
       
        
    }
    
    
    //top right
    if (i-columnNUmber+1 >= 0 && i-columnNUmber+1 < rowNumber*columnNUmber)
    {
        
        if ((i-columnNUmber+1)%columnNUmber == 0)
        {
            
        }else
        {
            btnTemp = [m_arrayStoreBtn objectAtIndex:i-columnNUmber+1];
            if (btnTemp.isMine)
            {
                count++;
            }
            
        }
        
 
        
    }
    
    
    //bottom 
    if (i+columnNUmber >= 0 && i+columnNUmber < rowNumber*columnNUmber)
    {
        
        btnTemp = [m_arrayStoreBtn objectAtIndex:i+columnNUmber];
        if (btnTemp.isMine)
        {
            count++;
        }
        
    }
    
    //bottom left
    if (i+columnNUmber-1 >= 0 && i+columnNUmber-1 < rowNumber*columnNUmber)
    {
        
        
        if ((i+columnNUmber-1)%columnNUmber == (columnNUmber-1))
        {
            
        }else
        {
            btnTemp = [m_arrayStoreBtn objectAtIndex:i+columnNUmber-1];
            if (btnTemp.isMine)
            {
                count++;
            }
            
        }
        
        
    }
    
    
    //top right
    if (i+columnNUmber+1 >= 0 && i+columnNUmber+1 < rowNumber*columnNUmber)
    {
        
        if ((i+columnNUmber+1)%columnNUmber == 0)
        {
            
        }else
        {
            btnTemp = [m_arrayStoreBtn objectAtIndex:i+columnNUmber+1];
            if (btnTemp.isMine)
            {
                count++;
            }
            
        }
        
    }
    
    return count;
}

-(void)clickMenu:(id)sender
{
    NSLog(@"clickMenu:%@",sender);
}
-(void)clickInfoAction:(id)sender
{
    NSLog(@"clickInfoAction:%@",sender);
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


-(void)clickMineButton:(JFMineButton*)mineButton
{
    
}
-(void)longPressMineButton:(JFMineButton*)mineButton
{
    
}


@end
