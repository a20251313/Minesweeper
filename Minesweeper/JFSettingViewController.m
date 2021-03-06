//
//  JFSettingViewController.m
//  Minesweeper
//
//  Created by ran on 13-7-31.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFSettingViewController.h"

@interface JFSettingViewController ()

@end

@implementation JFSettingViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (id)init
{
    self = [super init];
    if (self)
    {
        m_arrayData = [[NSMutableArray alloc] init];
        
        [self addDataSource:m_arrayData];
        // Custom initialization
    }
    return self;
}


-(void)addDataSource:(NSMutableArray *)array
{
    
    JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];
  
    [m_arrayData removeAllObjects];
    NSAssert(array != nil, @"addDataSource array == nil");
    
    JFCellDataModel  *model1 = [[JFCellDataModel alloc] init];
    model1.title = @"评分";
    model1.cellType = JFCellTypeNormal;
    model1.rowCount = 2;
    model1.arrayText = [NSArray arrayWithObjects:@"给我们评分",@"给我们发送邮件",nil];
    [array addObject:model1];
    [model1 release];
    
    
    JFCellDataModel  *model2= [[JFCellDataModel alloc] init];
    model2.title = @"难度";
    model2.cellType = JFCellTypeNormal;
    model2.rowCount = 4;
    model2.arrayText = [NSArray arrayWithObjects:@"初级",@"中级",@"高级",@"自定级",nil];
   
    
    
    if (info.mineConfig.minelevel != JFMineLevelSelfMake)
    {
         model2.arraySubText = [NSArray arrayWithObjects:@"9x9,10地雷",@"16x16,40地雷",@"16x30,99地雷",@"9x9,10地雷",nil];
    }else
    {
        JFMineLevelConfig  *config = info.mineConfig;
         model2.arraySubText = [NSArray arrayWithObjects:@"9x9,10地雷",@"16x16,40地雷",@"16x30,99地雷",[NSString stringWithFormat:@"%dx%d,%d地雷",config.rowNumber,config.colummNumber,config.mineNumber],nil];
    }
    
    
    [array addObject:model2];
    [model2 release];
    
    JFCellDataModel  *model3 = [[JFCellDataModel alloc] init];
    model3.title = @"难度";
    model3.cellType = JFCellTypeSwith;
    model3.rowCount = 2;
    model3.arrayText = [NSArray arrayWithObjects:@"声音效果",@"动画效果",nil];
    //model3.arraySubText = [NSArray arrayWithObjects:@"9x9,10地雷",@"16x16,40地雷",@"16x30,99地雷",@"9x9,10地雷",nil];
    [array addObject:model3];
    [model3 release];
    
    
    JFCellDataModel  *model4 = [[JFCellDataModel alloc] init];
    model4.title = @"版本";
    model4.cellType = JFCellTypeNormal;
    model4.rowCount = 1;
    model4.arrayText = [NSArray arrayWithObjects:@"1.0.0",nil];
    //model3.arraySubText = [NSArray arrayWithObjects:@"9x9,10地雷",@"16x16,40地雷",@"16x30,99地雷",@"9x9,10地雷",nil];
    [array addObject:model4];
    [model4 release];
    
    
    
}
-(void)loadView
{
     [super loadView];
    self.title = @"设置";
    self.tabBarItem.title = self.title;
    [self.tabBarItem setImage:[UIImage imageNamed:@"setting.png"]];
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-44-44) style:UITableViewStyleGrouped];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    [self.view addSubview:m_tableView];
    
    

    
   
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationController.title = @"设置";
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    UIBarButtonItem  *barBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.tabBarController.navigationItem.rightBarButtonItem = barBtn;
    [barBtn release];
}

-(void)done:(id)sender
{
    
    
    [self.tabBarController.navigationController.view removeFromSuperview];
    [JFGameInfoModel storeGameInfo];
    //[self.navigationntroller popViewControllerAnimated:YES];
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

-(void)dealloc
{
    [m_tableView release];
    m_tableView = nil;
    
    [m_arrayData release];
    m_arrayData = nil;
    
    [super dealloc];
}

#pragma mark  UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1)
    {
        int  rowNumber = 0;
        int  columnNumber = 0;
        int  mineNumber = 0;
        JFMineLevel  mymineLevel = JFMineLevelSimple;
        switch (indexPath.row)
        {
            case 0:
                rowNumber = 9;
                columnNumber = 9;
                mineNumber = 10;
                mymineLevel = JFMineLevelSimple;
                break;
            case 1:
                rowNumber = 16;
                columnNumber = 16;
                mineNumber = 40;
                mymineLevel = JFMineLevelNormal;
                break;
            case 2:
                rowNumber = 16;
                columnNumber = 30;
                mineNumber = 99;
                mymineLevel = JFMineLevelHard;
                break;
            case 3:
            {
                JFDIYMineLevelView  *levelView = [[JFDIYMineLevelView alloc] initWithFrame:CGRectMake(10, 20, 260, 200)];
                levelView.delegate = self;
                [self.view addSubview:levelView];
                levelView.center = self.view.center;
                return;
            }
                break;
                
            default:
                break;
        }
   
        JFMineLevelConfig  *mineLevelConfig = [[JFMineLevelConfig alloc] init];
        mineLevelConfig.minelevel = mymineLevel;
        mineLevelConfig.rowNumber = rowNumber;
        mineLevelConfig.colummNumber = columnNumber;
        mineLevelConfig.mineNumber = mineNumber;
        [self getMineLevel:mineLevelConfig];
        [mineLevelConfig release];
    }else if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            [self GoToITunesStore];
            //go to itunes
        }else
        {
            [self launchMailAppOnDevice];
            //go to sendEmail
        }
        
        
    }else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    

    
    
}

-(void)GoToITunesStore
{
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",514865541];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:a20251313@163.com?&subject=mineSweeper advise!";
	NSString *body = @"&body=Hello,I Found a bugs on this app,Let me tell you.......";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}



#pragma mark  UITableViewDataSouurce delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    JFCellDataModel  *model = [m_arrayData objectAtIndex:section];
    return model.title;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [m_arrayData count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < [m_arrayData count])
    {
        JFCellDataModel  *model  = [m_arrayData objectAtIndex:section];
        return model.rowCount;
    }
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString   *strIiden = [NSString stringWithFormat:@"%d",indexPath.section];
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:strIiden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strIiden];
    }
    
    JFCellDataModel *model = [m_arrayData objectAtIndex:indexPath.section];
    NSString  *strTemp = nil;
    NSString  *strImageName = nil;
    NSString  *strSubText = nil;
    UISwitch  *myswitch = nil;
    switch (model.cellType)
    {
        case JFCellTypeNone:
            break;
        case JFCellTypeSubText:
            if (model && [model.arrayText count])
            {
                
                strTemp = [model.arrayText objectAtIndex:indexPath.row];
                cell.textLabel.text = strTemp;
            }
            if (model && [model.arraySubText count])
            {
                
                UILabel  *label = (UILabel *)[cell.contentView viewWithTag:101];
                if (label == nil)
                {
                    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 21)];
                    label.tag = 101;
                    label.textAlignment = UITextAlignmentLeft;
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor colorWithRed:0 green:0 blue:0.5 alpha:1];
                    label.font = [UIFont systemFontOfSize:17];
                    [cell.contentView addSubview:label];
                    [label release];
                    
                }
                
                strSubText = [model.arraySubText objectAtIndex:indexPath.row];
                
                label.text = strSubText;
               // cell.detailTextLabel.text = strSubText;
            }
            
            if (model && [model.arrayImage count])
            {
                strImageName = [model.arrayImage objectAtIndex:indexPath.row];
                cell.imageView.image = [UIImage imageNamed:strImageName];
            }
            break;
        case JFCellTypeSwith:
            if (model && [model.arrayText count])
            {
                
                strTemp = [model.arrayText objectAtIndex:indexPath.row];
                cell.textLabel.text = strTemp;
            }
            
            myswitch = (UISwitch *)[cell.contentView viewWithTag:100];
            if (myswitch == nil)
            {
                myswitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 25, 20)];
                myswitch.tag = 100;
                [myswitch setOn:YES];
                [cell.contentView addSubview:myswitch];
                [myswitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
                [myswitch release];
            }
            
            if (indexPath.row == 0)
            {
                JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];
                [myswitch setOn:info.IsAudio];
            }else if (indexPath.row == 1)
            {
                JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];
                [myswitch setOn:info.IsAni];
                
            }
            
               
            
            break;
        case JFCellTypeNormal:
            if (model && [model.arrayText count])
            {
                
                strTemp = [model.arrayText objectAtIndex:indexPath.row];
                cell.textLabel.text = strTemp;
            }
            if (model && [model.arraySubText count])
            {
                
                UILabel  *label = (UILabel *)[cell.contentView viewWithTag:101];
                if (label == nil)
                {
                     label = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 120, 21)];
                    label.tag = 101;
                    label.textAlignment = UITextAlignmentRight;
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor colorWithRed:0 green:0 blue:0.5 alpha:1];
                    label.font = [UIFont systemFontOfSize:17];
                    [cell.contentView addSubview:label];
                    [label release];
                    
                }
                
                strSubText = [model.arraySubText objectAtIndex:indexPath.row];
                
                label.text = strSubText;
                // cell.detailTextLabel.text = strSubText;
            }
            
            if (model && [model.arrayImage count])
            {
                strImageName = [model.arrayImage objectAtIndex:indexPath.row];
                cell.imageView.image = [UIImage imageNamed:strImageName];
            }
            break;
            
        default:
            break;
    }
    
    
    
    
    UIImageView  *view = (UIImageView *)[cell.contentView viewWithTag:1001122];
    if (indexPath.section == 1)
    {
        JFMineLevelConfig  *config = [[JFGameInfoModel shareGameInfo] mineConfig];
        
        BOOL   bNeed = NO;
        switch (indexPath.row)
        {
            case 0:
                if (config.minelevel == JFMineLevelSimple)
                {
                    bNeed = YES;
                }
                break;
            case 1:
                if (config.minelevel == JFMineLevelNormal)
                {
                    bNeed = YES;
                }
                break;
            case 2:
                if (config.minelevel == JFMineLevelHard)
                {
                    bNeed = YES;
                }
                break;
            case 3:
                if (config.minelevel == JFMineLevelSelfMake)
                {
                    bNeed = YES;
                }
                break;
                
            default:
                break;
        }
        
        if (bNeed)
        {
            if (view == nil)
            {
                view = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 24, 24)];
                view.image = [UIImage imageNamed:@"check.png"];
                view.tag = 1001122;
                view.userInteractionEnabled = YES;
                [cell.contentView addSubview:view];
                [view release];
            }
        }else
        {
            [view removeFromSuperview];
        }
    
    }else
    {
        [view removeFromSuperview];
    }
    
    
    return cell;
}


-(void)switchValueChange:(UISwitch*)sendswitch
{
    
    CGPoint point = sendswitch.center;
    point = [m_tableView convertPoint:point fromView:sendswitch.superview];
    NSIndexPath* indexpath = [m_tableView indexPathForRowAtPoint:point];
  //  UITableViewCell *cell = [m_tableView cellForRowAtIndexPath:indexpath];
    
    JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];

    if (indexpath.row == 0)
    {
        info.IsAudio = sendswitch.isOn;
    }else if (indexpath.row == 1)
    {
        info.IsAni = sendswitch.isOn;
    }
    
 
    
}
#pragma mark JFDIYMineLevelViewDelegate

-(void)getMineLevel:(JFMineLevelConfig *)mineConfig
{
    JFGameInfoModel  *gameInfo = [JFGameInfoModel shareGameInfo];
    mineConfig.minePicNumber = gameInfo.mineConfig.minePicNumber;
    gameInfo.mineConfig = mineConfig;
    [self addDataSource:m_arrayData];
    [m_tableView reloadData];
    

    
    [self done:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReInitView" object:nil];
    
}




@end
