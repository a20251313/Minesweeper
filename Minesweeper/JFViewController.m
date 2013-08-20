//
//  JFViewController.m
//  Minesweeper
//
//  Created by ran on 13-7-12.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFViewController.h"

#define MineflagViewTag             1123123

@interface JFViewController ()

@end

@implementation JFViewController
@synthesize mineConfig = m_objMineConfig;
@synthesize titleView;


-(id)init
{
    self = [super init];
    if (self)
    {
        m_arrayStoreBtn = [[NSMutableArray alloc] init];
        self.mineConfig = [[JFGameInfoModel shareGameInfo] mineConfig];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initNavView:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userHasChnageInfo:) name:@"UserHasChangeConfig" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reInitView:) name:@"ReInitView" object:nil];
    }
    return self;
}


-(void)reInitView:(NSNotification*)note
{
    JFGameInfoModel  *gameModel = [JFGameInfoModel shareGameInfo];
    self.mineConfig = gameModel.mineConfig;
    [self initNowView];
}

-(void)initNavView:(NSNotification*)note
{
    
    
    CGRect frame = m_scorllView.frame;
    frame.origin.y = 0;
    m_scorllView.frame = frame;

    
}

-(void)userHasChnageInfo:(NSNotification*)note
{
    JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];
    self.mineConfig = info.mineConfig;
    [self redrawWhenConfigChange];
}

-(void)redrawWhenConfigChange
{
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        
        NSString   *strPicName = [NSString stringWithFormat:@"%d-bar.png",self.mineConfig.minePicNumber];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:strPicName] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    for (int i = 0; i < [m_arrayStoreBtn count]; i++)
    {
        JFMineButton *btn = [m_arrayStoreBtn objectAtIndex:i];
        btn.picMynumer = self.mineConfig.minePicNumber;
        [btn setMineFlag:btn.buttonFlag];
    }
    
}
-(void)loadView
{
    [super loadView];
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    m_fMineWidth = 48;

    
   
 //   [config release];
  
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        
        NSString   *strPicName = [NSString stringWithFormat:@"%d-bar.png",self.mineConfig.minePicNumber];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:strPicName] forBarMetrics:UIBarMetricsDefault];
    }
    self.wantsFullScreenLayout = YES;
    
  //  [self initNowView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self performSelector:@selector(initNowView) withObject:nil afterDelay:2];
    //[self performSelector:@selector(initNowView) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    [self initNowView];
}
-(void)dealloc
{
    self.mineConfig = nil;
    [m_nav release];
    m_nav = nil;
    [super dealloc];
}

-(void)initNowView
{
    
    JFTitleClickButton  *titleViewTemp = [[JFTitleClickButton alloc] initWithFrame:CGRectMake(0, 0, 120+24, 48) WithConfig:self.mineConfig];
    titleViewTemp.delegate = self;
    self.navigationItem.titleView = titleViewTemp;
    self.titleView = titleViewTemp;
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
        m_scorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, frame.size.height-44)];
        m_scorllView.contentSize = m_scorllView.frame.size;
       // m_scorllView.contentOffset = CGPointMake(0, frame.size.width);
        m_fWidth = frame.size.width;
        m_fheight = frame.size.height-44;
        [self.view addSubview:m_scorllView];
        //m_scorllView.delegate = self;
    
    }
    
    [self startGameWithConfig:self.mineConfig];
    //[self initPlayViewWithConfig:self.mineConfig];
}


-(void)initPlayViewWithConfig:(JFMineLevelConfig*)config
{
    
    [self.titleView setMineFlagNumber:config.mineNumber];
    m_iFlagMineNum = config.mineNumber;
    
    if (config != self.mineConfig)
    {
        self.mineConfig = config;
    }
    
    
    for (int i = 0; i < [m_arrayStoreBtn count]; i++)
    {
        JFMineButton  *btn = [m_arrayStoreBtn objectAtIndex:i];
        [btn removeFromSuperview];
    }
    [m_arrayStoreBtn removeAllObjects];
    
    
    
    m_scorllView.layer.contents = (id)[UIImage imageNamed:[NSString stringWithFormat:@"%d-background",self.mineConfig.minePicNumber]].CGImage;
    CGFloat  fTempWidth = m_fMineWidth;
    CGFloat  fTempheight = m_fMineWidth;
    
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

        //NSLog(@"fXpoint:%f fYpoint:%f",fXpoint,fYpoint);
        JFMineButton  *btnTemp = [[JFMineButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, fTempWidth, fTempheight) withPicNumber:self.mineConfig.minePicNumber];
        btnTemp.mineNumber = 0;
        btnTemp.delegate = self;
        btnTemp.isMine = NO;
        btnTemp.tag = i;
        btnTemp.buttonFlag = JFMineButtonFlagNone;
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
        btn.mineNumber = 0;
        btn.isMine = YES;
      //  NSLog(@"number:%ld",number); 
    }
    
//    NSLog(@"count:%d setNumber:%@",setNumber.count,setNumber);
    
    [self calutuleMineNumber];
    [m_scorllView setContentSize:CGSizeMake(self.mineConfig.colummNumber*fTempWidth, self.mineConfig.rowNumber*fTempheight)];
    [m_scorllView setContentOffset:CGPointMake(0, 0)];
    
}

-(void)calutuleMineNumber
{
   
    
    
    for (int i = 0; i < [m_arrayStoreBtn count]; i++)
    {
        JFMineButton  *btn = [m_arrayStoreBtn objectAtIndex:i];        
        int number = [self getAroundMineNumber:i mineConfig:self.mineConfig];
        btn.mineNumber = number;
        
        //[btn setMineFlag:JFMineButtonFlagShowNumber];
        
    }
    
    
}


-(int)getAroundMineNumber:(int)i mineConfig:(JFMineLevelConfig *)config
{
    
    
    int  count = 0;
    
    
    
    NSArray  *array = [self getArrayAccordIndex:i];
    for (int i = 0; i < [array count]; i++)
    {
        JFMineButton  *btnTemp = [m_arrayStoreBtn objectAtIndex:[[array objectAtIndex:i] intValue]];
        if (btnTemp.isMine)
        {
            count++;
        }
        
    }
    return count;
}

-(void)clickMenu:(id)sender
{
      NSString   *strPicName = [NSString stringWithFormat:@"%d-bar.png",m_objMineConfig.minePicNumber];
        
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    if (m_nav == nil)
    {
        
      
        UITabBarController *tabBar = [[UITabBarController alloc] init];
       // m_tabBar.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-53, 320, 53);
        JFSettingViewController   *setControl = [[JFSettingViewController alloc] init];
        
        
        JFAppearenceViewController  *appControl = [[JFAppearenceViewController alloc] init];
        
        
        JFHelpViewController        *helpContrl = [[JFHelpViewController alloc] init];
        
        
        JFVictoryViewController    *victContrl = [[JFVictoryViewController alloc] init];
        
        

        
        
        NSArray  *arrayControlss = [NSArray arrayWithObjects:setControl,appControl,helpContrl,victContrl,nil];
        tabBar.viewControllers = arrayControlss;

        m_nav = [[UINavigationController alloc] initWithRootViewController:tabBar];
        [UIApplication sharedApplication].statusBarHidden = YES;
        
        
        
       
        
      //  [self.navigationController pushViewController:nav animated:YES];

        [setControl release];
        [appControl release];
        [helpContrl release];
        [victContrl release];
              // [self.view addSubview:m_tabBar.view];
        
    }
   
    
    [m_nav.navigationBar setBackgroundColor:[UIColor blackColor]];
    if ([m_nav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [m_nav.navigationBar setBackgroundImage:[UIImage imageNamed:strPicName] forBarMetrics:UIBarMetricsDefault];
    }
    [self.view.window addSubview:m_nav.view];    
    NSLog(@"clickMenu:%@",sender);
}



/*-(void)clickMenu:(id)sender
{
    NSString   *strPicName = [NSString stringWithFormat:@"%d-bar.png",m_objMineConfig.minePicNumber];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    if (m_tar == nil)
    {
        
        
       m_tar  = [[UITabBarController alloc] init];
        // m_tabBar.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-53, 320, 53);
        JFSettingViewController   *setControl = [[JFSettingViewController alloc] init];
        
        
        JFAppearenceViewController  *appControl = [[JFAppearenceViewController alloc] init];
        
        
        JFHelpViewController        *helpContrl = [[JFHelpViewController alloc] init];
        
        
        JFVictoryViewController    *victContrl = [[JFVictoryViewController alloc] init];
        

        
        
        NSArray  *arrayControlss = [NSArray arrayWithObjects:setControl,appControl,helpContrl,victContrl,nil];
        m_tar.viewControllers = arrayControlss;
        

        
        
        
        
        
        //  [self.navigationController pushViewController:nav animated:YES];
        
        [setControl release];
        [appControl release];
        [helpContrl release];
        [victContrl release];
        // [self.view addSubview:m_tabBar.view];
        
    }
    

    [self.view.window addSubview:m_tar.view];
    // [self.navigationController pushViewController:m_tabBar animated:YES];
    
    // [self.navigationController pushViewController:m_tabBar animated:YES];
    
    NSLog(@"clickMenu:%@",sender);
}*/


-(void)clickInfoAction:(id)sender
{
    NSLog(@"clickInfoAction:%@",sender);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSMutableArray*)getArrayAccordIndex:(int)tag
{
    
    NSMutableArray  *array = [NSMutableArray arrayWithCapacity:8];
    int  rowNumber = self.mineConfig.rowNumber;
    int  columnNUmber= self.mineConfig.colummNumber;
    int totalNumber = self.mineConfig.rowNumber*self.mineConfig.colummNumber;
    
    //left
    if (tag-1 > 0 && tag-1 < totalNumber)
    {
        
        if ((tag-1)%columnNUmber != (columnNUmber-1))
        {
            [array addObject:[NSNumber numberWithInt:tag-1]];
        }
        
        
    }
    
    //right
    if (tag+1 > 0 && tag+1 < totalNumber)
    {
        if ((tag+1)%columnNUmber != 0)
        {
            [array addObject:[NSNumber numberWithInt:tag+1]];
        }
        
    }
    
    //top
    if (tag-columnNUmber >= 0 && tag-columnNUmber < rowNumber*columnNUmber)
    {
        
        [array addObject:[NSNumber numberWithInt:tag-columnNUmber]];
    }
    
    //top left
    if (tag-columnNUmber-1 >= 0 && tag-columnNUmber-1 < rowNumber*columnNUmber)
    {
        
        
        if ((tag-columnNUmber-1)%columnNUmber != (columnNUmber-1))
        {
            [array addObject:[NSNumber numberWithInt:tag-columnNUmber-1]];
        }
        
        
    }
    
    //top right
    if (tag-columnNUmber+1 >= 0 && tag-columnNUmber+1 < rowNumber*columnNUmber)
    {
        
        if ((tag-columnNUmber+1)%columnNUmber != 0)
        {
            [array addObject:[NSNumber numberWithInt:tag-columnNUmber+1]];
        }
        
        
        
    }
    
    
    //bottom
    if (tag+columnNUmber >= 0 && tag+columnNUmber < rowNumber*columnNUmber)
    {
        
        [array addObject:[NSNumber numberWithInt:tag+columnNUmber]];
        
    }
    
    
    //bottom left
    if (tag+columnNUmber-1 >= 0 && tag+columnNUmber-1 < rowNumber*columnNUmber)
    {
        
        
        if ((tag+columnNUmber-1)%columnNUmber != (columnNUmber-1))
        {
            [array addObject:[NSNumber numberWithInt:tag+columnNUmber-1]];
        }
        
        
    }
    
    
    
    //top right
    if (tag+columnNUmber+1 >= 0 && tag+columnNUmber+1 < rowNumber*columnNUmber)
    {
        
        if ((tag+columnNUmber+1)%columnNUmber != 0)
        {
            [array addObject:[NSNumber numberWithInt:tag+columnNUmber+1]];
        }
        
    }
    
    return array;
}



/*
-(NSMutableSet*)getSetAccordIndex:(int)tag
{
    
    NSMutableSet  *set = [NSMutableSet setWithCapacity:8];
    return set;
    int  rowNumber = self.mineConfig.rowNumber;
    int  columnNUmber= self.mineConfig.colummNumber;
    int totalNumber = self.mineConfig.rowNumber*self.mineConfig.colummNumber;
    if (tag-1 > 0 && tag-1 < totalNumber)
    {
        
        if ((tag-1)%columnNUmber != (columnNUmber-1))
        {
           [set addObject:[NSNumber numberWithInt:tag-1]]; 
        }
        
        
    }
    
    if (tag+1 > 0 && tag+1 < totalNumber)
    {
        if ((tag+1)%columnNUmber != 0)
        {
                 [set addObject:[NSNumber numberWithInt:tag+1]];
        }
        
    }
    
    //top
    if (tag-columnNUmber >= 0 && tag-columnNUmber < rowNumber*columnNUmber)
    {
        
        [set addObject:[NSNumber numberWithInt:tag-columnNUmber]];        
    }
    
    //top left
    if (tag-columnNUmber-1 >= 0 && tag-columnNUmber-1 < rowNumber*columnNUmber)
    {
        
        
        if ((tag-columnNUmber-1)%columnNUmber != (columnNUmber-1))
        {
            [set addObject:[NSNumber numberWithInt:tag-columnNUmber-1]];
        }
        
        
    }
    
    //top right
    if (tag-columnNUmber+1 >= 0 && tag-columnNUmber+1 < rowNumber*columnNUmber)
    {
        
        if ((tag-columnNUmber+1)%columnNUmber != 0)
        {
            [set addObject:[NSNumber numberWithInt:tag-columnNUmber+1]];
        }
        
        
        
    }
    
    
    //bottom
    if (tag+columnNUmber >= 0 && tag+columnNUmber < rowNumber*columnNUmber)
    {
        
        [set addObject:[NSNumber numberWithInt:tag+columnNUmber]];
        
    }
    
    
    //bottom left
    if (tag+columnNUmber-1 >= 0 && tag+columnNUmber-1 < rowNumber*columnNUmber)
    {
        
        
        if ((tag+columnNUmber-1)%columnNUmber != (columnNUmber-1))
        {
            [set addObject:[NSNumber numberWithInt:tag+columnNUmber-1]];
        }
        
        
    }
    
    
    
    //top right
    if (tag+columnNUmber+1 >= 0 && tag+columnNUmber+1 < rowNumber*columnNUmber)
    {
        
        if ((tag+columnNUmber+1)%columnNUmber != 0)
        {
            [set addObject:[NSNumber numberWithInt:tag+columnNUmber+1]];
        }
        
    }
    
    return set;
}*/

-(void)showBtnNumber:(JFMineButton *)mineButton
{
    if (mineButton.IsShow || mineButton.buttonFlag != JFMineButtonFlagNone)
    {
        return;
    }

   // [NSException raise:@"mineButton" format:@"mineButton"];
    mineButton.IsShow = YES;
    [mineButton setMineFlag:JFMineButtonFlagShowNumber];

    if (mineButton.mineNumber <= 0)
    {
        NSArray  *array = [self getArrayAccordIndex:mineButton.tag];
        
        for (int i = 0; i < [array count]; i++)
        {
            JFMineButton  *btnTemp = (JFMineButton *)[m_arrayStoreBtn objectAtIndex:[[array objectAtIndex:i] intValue]];
            
            
            if (btnTemp.mineNumber <= 0 )
            {
                [self showBtnNumber:btnTemp];
                //[self performSelector:@selector(showBtnNumber:) withObject:btnTemp];
               // [self showBtnNumber:btnTemp];
            }
            
           /* if (mineButton.buttonFlag == JFMineButtonFlagNone)
            {
                [btnTemp.layer addAnimation:[CABasicAnimation aniAlpha:0.2 fromValue:0.75 tovalue:1] forKey:nil];
            }*/
            [btnTemp setMineFlag:JFMineButtonFlagShowNumber];
            
        }
               
        
    }
    
}



-(void)showFlagSucOrFail:(JFMineButton *)mineButton
{
    
    int  mineNumber = mineButton.mineNumber;
    if (mineNumber == 0)
    {
        return;
    }
    
    mineButton.IsShow = YES;
    int tag = mineButton.tag;
    int count = 0;
    int  errorFlagNumber = 0;
    
    NSMutableArray  *array =  [NSMutableArray arrayWithCapacity:8];
    NSArray  *arrayNumberTag = [self getArrayAccordIndex:tag];
    
    JFMineButton  *btnTemp = nil;
    for (int i = 0; i < [arrayNumberTag count]; i++)
    {
        
        btnTemp = [m_arrayStoreBtn objectAtIndex:[[arrayNumberTag objectAtIndex:i] intValue]];
        if (btnTemp.isMine && btnTemp.buttonFlag == JFMineButtonFlagIsMine)
        {
            count++;
        }
        
        if (!btnTemp.isMine && btnTemp.buttonFlag == JFMineButtonFlagIsMine)
        {
            errorFlagNumber++;
        }
        [array addObject:btnTemp];    
        
    }
    
    if (errorFlagNumber > 0)
    {
    
        [self GameOver:nil];
        return;
    }
    
    if (mineNumber <= count)
    {
        
        //suc 
        for (int i = 0; i < [array count]; i++)
        {
            JFMineButton  *btn = [array objectAtIndex:i];
            if (btn.buttonFlag != JFMineButtonFlagIsNotSure && btn.buttonFlag != JFMineButtonFlagIsMine)
            {
                
                if (btn.mineNumber > 0)
                {
                     [btn setMineFlag:JFMineButtonFlagShowNumber];
                     btn.IsShow = YES;
                     // btn.IsShow = YES;
                }else
                {
                    [self showBtnNumber:btn];
                }
            }else
            {
                if (btn.mineNumber <= 0 && btn.buttonFlag == JFMineButtonFlagNone)
                {
                    [self showBtnNumber:btn];
                }
                
            }
            
          
        }
        
        NSLog(@"mineNumber <= count  :%d %d",mineNumber,count);
    }else
    {
      //  return;
        //fail 
        for (int i = 0; i < [array count]; i++)
        {
            JFMineButton  *btn = [array objectAtIndex:i];
            btn.IsShow = YES;
            
            
            if (JFMineButtonFlagNone == btn.buttonFlag)
            {
                CABasicAnimation  *ani =  [CABasicAnimation aniRotate:0.25 tovalue:-M_PI_4/2 fromValue:0];// [CABasicAnimation aniRotate:0.25 floatRotate:0.1 view:nil];
               // btn.layer.anchorPoint = CGPointMake(0.5, 0.5);
                 [btn.layer addAnimation:ani forKey:nil];
                
            }
        }
        
    }
    
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim.name isEqualToString:@"flag.png"])
    {
        UIView  *view = [anim valueForKey:@"fromView"];
        JFMineButton  *btnTemp = [anim valueForKey:@"toView"];
        [view removeFromSuperview];
        [btnTemp setMineFlag:JFMineButtonFlagIsMine];
        
        [btnTemp.layer addAnimation:[CABasicAnimation aniRotate:0.245 tovalue:M_PI_4/2 fromValue:0] forKey:nil];
    }
}


-(void)aniForFlagToSomeMineBtn:(JFMineButton*)mineBtn
{
    
    JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];
    if (!info.IsAni)
    {
        
        [mineBtn setMineFlag:JFMineButtonFlagIsMine];
        return;
    }

   // CGRect  frame = [UIApplication sharedApplication];
    UIImageView  *view = [[UIImageView alloc] initWithFrame:CGRectMake((m_fWidth-m_fMineWidth)/2, 5, m_fMineWidth, m_fMineWidth)];
    view.tag = MineflagViewTag;
    view.image = [UIImage imageNamed:@"flag.png"];
    [self.view addSubview:view];
    
    CGPoint topoint = [self.view convertPoint:mineBtn.center fromView:m_scorllView];
    //CGPointMake((int)mineBtn.center.x%(int)m_fWidth, (int)mineBtn.center.y%(int)m_fheight)
    CABasicAnimation  *ani = [CABasicAnimation aniWithPosition:0.35 fromValue:view.center tovalue:topoint];
    ani.delegate = self;
    ani.name = @"flag.png";
    [ani setValue:view forKey:@"fromView"];
    [ani setValue:mineBtn forKey:@"toView"];
    [view.layer addAnimation:ani forKey:nil];
    [view.layer addAnimation:[CABasicAnimation aniWithScale:0.35 tovalue:0.65 fromValue:1] forKey:nil];
    [view release];
}

-(void)aniForFlagQuestionMineBtn:(JFMineButton*)mineBtn
{
    
    JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];
    if (!info.IsAni)
    {
        
        [mineBtn setMineFlag:JFMineButtonFlagIsNotSure];
        return;
    }
    
    
    CGPoint frompoint = [self.view convertPoint:mineBtn.center fromView:m_scorllView];
    
    UIImageView  *view = [[UIImageView alloc] initWithFrame:CGRectMake((m_fWidth-m_fMineWidth)/2, 5, m_fMineWidth, m_fMineWidth)];
    view.tag = MineflagViewTag;
    view.image = [UIImage imageNamed:@"flag.png"];
    [self.view addSubview:view];
    view.center = frompoint;
    
    
    CGPoint  topoint = CGPointMake(-24, frompoint.y);
    CABasicAnimation  *ani = [CABasicAnimation aniWithPosition:0.35 fromValue:view.center tovalue:topoint];
    ani.delegate = self;
    ani.name = @"flagquestion";
    [ani setValue:view forKey:@"fromView"];
    [view.layer addAnimation:ani forKey:nil];
    
    CABasicAnimation  *aniRote = [CABasicAnimation aniRotate:0.20 tovalue:M_PI_4/2 fromValue:0];
    aniRote.repeatCount = 2;
    [mineBtn.layer addAnimation:aniRote forKey:nil];
    [view release];
}

-(void)startGameWithConfig:(JFMineLevelConfig *)TemmineConfig
{
    
    if (self.mineConfig != TemmineConfig)
    {
        self.mineConfig  = TemmineConfig;
    }

    [self initPlayViewWithConfig:self.mineConfig];
 // [self.titleView startTimer];
    
}
-(void)GameOver:(JFMineButton*)btn
{
    
    [self.titleView stopTimer];
    for (int i = 0; i < [m_arrayStoreBtn count]; i++)
    {
        JFMineButton  *btnTemp = [m_arrayStoreBtn objectAtIndex:i];
        
        if (btnTemp.isMine)
        {
            
            [btnTemp setMineFlag:JFMineButtonFlagShowMine];
            
        }else
        {
            if (btnTemp.buttonFlag == JFMineButtonFlagIsMine)
            {
                [btnTemp setMineFlag:JFMineButtonFlagWrongMine];
            }else
            {
                [btnTemp setMineFlag:JFMineButtonFlagShowNumber];
            }
        }
        
    }
    
    [self storeGameInfoWhenGameOver:NO];
    NSLog(@"game over");
}

-(void)WinGame:(JFMineButton *)mineButton
{
    
    int second = [self.titleView stopTimer];
    
    for (int i = 0; i < [m_arrayStoreBtn count]; i++)
    {
        JFMineButton  *btnTemp = [m_arrayStoreBtn objectAtIndex:i];
        if (btnTemp.buttonFlag == JFMineButtonFlagNone || btnTemp.buttonFlag == JFMineButtonFlagIsNotSure)
        {
            [btnTemp setMineFlag:JFMineButtonFlagShowNumber];
        }
    }
    [self storeGameInfoWhenGameOver:YES];
    DLOG(@"WinGame:%@ second:%d",mineButton,second);
    
}


-(void)storeGameInfoWhenGameOver:(BOOL)bIsWin
{
    
    JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];
    JFGameResultModel  *model = nil;
    switch (self.mineConfig.minelevel)
    {
        case JFMineLevelNormal:
            model = info.NormalResult;
            break;
        case JFMineLevelSimple:
            model = info.simpleResult;
            break;
        case JFMineLevelHard:
            model = info.HardResult;
            break;
        case JFMineLevelSelfMake:
            model = info.DIYResult;
            break;
        default:
            break;
    }
    
    
    model.playTimes ++;
    if(bIsWin)
    {
        model.winTimes++;
        
        if(model.bestCostTime == 0)
        {
            model.bestCostTime = self.titleView.secondTime;
        }else
        {
            if(self.titleView.secondTime < model.bestCostTime)
            {
                model.bestCostTime = self.titleView.secondTime;
            }
        }
    }
    [JFGameInfoModel storeGameInfo];

}
#pragma mark JFTitleClickButton
-(void)clickTitleButton:(JFTitleClickButton*)buttonView
{
    m_iFlagMineNum = self.mineConfig.mineNumber;
    m_iFlagRightNumber = 0;
    [self startGameWithConfig:self.mineConfig];
    
}


-(void)clickMineButton:(JFMineButton*)mineButton
{
    
    if (!m_bIsStart)
    {
        m_bIsStart = YES;
        [self.titleView startTimer];
    }
    if (mineButton.isMine && mineButton.buttonFlag != JFMineButtonFlagIsMine)
    {
        [self GameOver:mineButton];
        [mineButton setMineFlag:JFMineButtonFlagWMineExpo];
        return;
    }
 
    if (mineButton.buttonFlag == JFMineButtonFlagIsMine || mineButton.buttonFlag == JFMineButtonFlagShowMine ||
        mineButton.buttonFlag == JFMineButtonFlagWMineExpo || mineButton.buttonFlag == JFMineButtonFlagWrongMine)
    {
        return;
    }
    
    if (mineButton.buttonFlag == JFMineButtonFlagShowNumber)
    {
        
        [self showFlagSucOrFail:mineButton];
        return;
    }
    

    
    //follow are no mine
    if (mineButton.mineNumber >= 0 && mineButton.buttonFlag == JFMineButtonFlagNone)
    {
        [self showBtnNumber:mineButton];
        return;
    }
    [mineButton.layer addAnimation:[CABasicAnimation aniAlpha:0.45 fromValue:0.7 tovalue:1] forKey:@""];
}



-(void)longPressMineButton:(JFMineButton*)mineButton
{
    if (mineButton.buttonFlag == JFMineButtonFlagNone)
    {
        [self aniForFlagToSomeMineBtn:mineButton];
       // [mineButton setMineFlag:JFMineButtonFlagIsMine];
        if (mineButton.isMine)
        {
            m_iFlagRightNumber++;
        }
        m_iFlagMineNum--;
        
        if (m_iFlagRightNumber == self.mineConfig.mineNumber)
        {
            [self WinGame:mineButton];
        }
    }else if (mineButton.buttonFlag == JFMineButtonFlagIsMine)
    {
        [mineButton setMineFlag:JFMineButtonFlagIsNotSure];
        if (mineButton.isMine)
        {
            m_iFlagRightNumber--;
        }
        m_iFlagMineNum++;
        [self aniForFlagQuestionMineBtn:mineButton];
    }else if (mineButton.buttonFlag == JFMineButtonFlagIsNotSure)
    {
        
        CABasicAnimation *ani = [CABasicAnimation aniRotate:0.25 tovalue:M_PI_4/2 fromValue:0];
        ani.repeatCount = 2;
        [mineButton.layer addAnimation:ani forKey:nil];
        [mineButton setMineFlag:JFMineButtonFlagNone];
    }
    
    if (m_iFlagMineNum <= 0)
    {
        m_iFlagMineNum = 0;
    }
    [self.titleView setMineFlagNumber:m_iFlagMineNum];
    
}


@end
