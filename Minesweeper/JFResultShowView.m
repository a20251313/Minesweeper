//
//  JFResultShowView.m
//  Minesweeper
//
//  Created by ran on 13-8-20.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFResultShowView.h"



@implementation JFResultShowModel

@synthesize level;
@synthesize bestTime;
@synthesize winTime;

@end


@implementation JFResultShowView
@synthesize delagate;
@synthesize mineModel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
         self.layer.contents = (id)[UIImage imageNamed:@"10-board-background.png"].CGImage;
        
        CGFloat   fHeight = frame.size.height-20;
        CGFloat   fwidth = frame.size.width-20;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, fwidth, fHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //_tableView.center = self.center;
        [self addSubview:_tableView];
        [_tableView reloadData];
        
        
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


#pragma mark UITableViewdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
      
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    UILabel  *label = (UILabel *)[cell.contentView viewWithTag:100];
    if (label == nil)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor purpleColor];
        label.font = [UIFont systemFontOfSize:17];
        label.tag = 100;
        label.center = cell.contentView.center;
        [cell.contentView addSubview:label];
        [label release];
    }
    
    
    NSString  *strInfo = nil;
    switch (indexPath.row)
    {
        case 0:
            strInfo = [NSString stringWithFormat:@"扫雷"];
            break;
        case 1:
            strInfo = [NSString stringWithFormat:@"级别:%@",[self levelString:self.mineModel.level]];
            break;
        case 2:
            strInfo = [NSString stringWithFormat:@"本次时间:%@",[self getTimeString:self.mineModel.winTime]];
            break;
        case 3:
            strInfo = [NSString stringWithFormat:@"最佳时间:%@",[self getTimeString:self.mineModel.bestTime]];
            break;
        case 4:
            strInfo = [NSString stringWithFormat:@"再次开始"];
            break;            
        default:
            break;
    }
    label.text = strInfo;
    return cell;
}


-(NSString*)levelString:(JFMineLevel)level
{
    NSString  *strInfo = nil;
    switch (level)
    {
        case JFMineLevelSimple:
            strInfo = @"初级";
            break;
        case JFMineLevelNormal:
            strInfo = @"中级";
            break;
        case JFMineLevelHard:
            strInfo = @"高级";
            break;
        case JFMineLevelSelfMake:
            strInfo = @"自定义级";
            break;
        default:
            break;
    }
    return strInfo;
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



#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.frame.size.height-20)/5;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4)
    {
        [self removeFromSuperview];
        
        if (delagate  && [delagate respondsToSelector:@selector(restartGame:)])
        {
            [delagate restartGame:self];
        }
    }
}

@end
