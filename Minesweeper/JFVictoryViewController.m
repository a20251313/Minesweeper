//
//  JFVictoryViewController.m
//  Minesweeper
//
//  Created by ran on 13-7-31.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFVictoryViewController.h"

@interface JFVictoryViewController ()

@end

@implementation JFVictoryViewController

-(id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"战果";
        self.tabBarItem.title = self.title;
        [self.tabBarItem setImage:[UIImage imageNamed:@"statistic.png"]];
        m_arrayData = [[NSMutableArray alloc] init];
        
        [self addDataSource:m_arrayData];
    }
    return self;
}

-(NSString *)getTimeString:(int)m_isecond
{
    int seconds = m_isecond%60;
    int minutes = m_isecond/60;
    
    NSString  *strTime = @"";
    
    if (minutes < 10)
    {
        strTime = [NSString stringWithFormat:@"0%d:",minutes];
    }else
    {
        strTime = [NSString stringWithFormat:@"%d:",minutes];
    }
    
    if (seconds < 10)
    {
        strTime = [NSString stringWithFormat:@"%@0%d",strTime,seconds];
    }else
    {
        strTime = [NSString stringWithFormat:@"%@%d",strTime,seconds];
    }
    
    
    return strTime;
}
-(void)addDataSource:(NSMutableArray *)array
{
    
    JFGameInfoModel  *info = [JFGameInfoModel shareGameInfo];
    
    
    NSAssert(array != nil, @"addDataSource array == nil");
    
    JFCellDataModel  *model1 = [[JFCellDataModel alloc] init];
    model1.title = @"初级";
    model1.cellType = JFCellTypeNormal;
    model1.rowCount = 5;
    model1.arrayText = [NSArray arrayWithObjects:@"最佳时间",@"次数",@"胜场",@"胜率",@"清空记录",nil];
    model1.arraySubText = [NSArray arrayWithObjects:[self getTimeString:info.simpleResult.bestCostTime],[NSString stringWithFormat:@"%d",info.simpleResult.playTimes],[NSString stringWithFormat:@"%d",info.simpleResult.winTimes],[NSString stringWithFormat:@"%0.2f%%",100*(info.simpleResult.playTimes == 0?0:info.simpleResult.winTimes*1.0f/(info.simpleResult.playTimes*1.0f))],@"",nil];
    [array addObject:model1];
    [model1 release];
    
    
    JFCellDataModel  *model2 = [[JFCellDataModel alloc] init];
    model2.title = @"中级";
    model2.cellType = JFCellTypeNormal;
    model2.rowCount = 5;
    model2.arrayText = [NSArray arrayWithObjects:@"最佳时间",@"次数",@"胜场",@"胜率",@"清空记录",nil];
    model2.arraySubText = [NSArray arrayWithObjects:[self getTimeString:info.NormalResult.bestCostTime],[NSString stringWithFormat:@"%d",info.NormalResult.playTimes],[NSString stringWithFormat:@"%d",info.NormalResult.winTimes],[NSString stringWithFormat:@"%0.2f%%",100*(info.NormalResult.playTimes == 0?0:info.NormalResult.winTimes*1.0f/(info.NormalResult.playTimes*1.0f))],@"",nil];
    [array addObject:model2];
    [model2 release];
    
    
    JFCellDataModel  *model3 = [[JFCellDataModel alloc] init];
    model3.title = @"高级";
    model3.cellType = JFCellTypeNormal;
    model3.rowCount = 5;
    model3.arrayText = [NSArray arrayWithObjects:@"最佳时间",@"次数",@"胜场",@"胜率",@"清空记录",nil];
    model3.arraySubText = [NSArray arrayWithObjects:[self getTimeString:info.HardResult.bestCostTime],[NSString stringWithFormat:@"%d",info.HardResult.playTimes],[NSString stringWithFormat:@"%d",info.HardResult.winTimes],[NSString stringWithFormat:@"%0.2f%%",100*(info.HardResult.playTimes == 0?0:info.HardResult.winTimes*1.0f/(info.HardResult.playTimes*1.0f))],@"",nil];
    [array addObject:model3];
    [model3 release];
    
    JFCellDataModel  *model4 = [[JFCellDataModel alloc] init];
    model4.title = @"高级";
    model4.cellType = JFCellTypeNormal;
    model4.rowCount = 5;
    model4.arrayText = [NSArray arrayWithObjects:@"最佳时间",@"次数",@"胜场",@"胜率",@"清空记录",nil];
    model4.arraySubText = [NSArray arrayWithObjects:[self getTimeString:info.DIYResult.bestCostTime],[NSString stringWithFormat:@"%d",info.DIYResult.playTimes],[NSString stringWithFormat:@"%d",info.DIYResult.winTimes],[NSString stringWithFormat:@"%0.2f%%",100*(info.DIYResult.playTimes == 0?0:info.DIYResult.winTimes*1.0f/(info.DIYResult.playTimes*1.0f))],@"",nil];
    [array addObject:model4];
    [model4 release];
    

    
    
    
}
-(void)loadView
{
    [super loadView];
   
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-44-44) style:UITableViewStyleGrouped];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    [self.view addSubview:m_tableView];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationController.title = @"战果";
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
                [myswitch release];
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
    
    
    return cell;
}

@end
