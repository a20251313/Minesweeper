//
//  JFResultShowView.m
//  Minesweeper
//
//  Created by ran on 13-8-20.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFResultShowView.h"

@implementation JFResultShowView
@synthesize delagate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat   fHeight = frame.size.height-20;
        CGFloat   fwidth = frame.size.width-20;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, fwidth, fHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        [_tableView reloadData];
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
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor purpleColor];
        label.font = [UIFont systemFontOfSize:17];
    }
    
    NSString  *strInfo = nil;
    switch (indexPath.row)
    {
        case 0:
            strInfo = [NSString stringWithFormat:@"时间:%@",@"11"];
            break;
        case 1:
            strInfo = [NSString stringWithFormat:@"时间:%@",@"11"];
            break;
        case 2:
            strInfo = [NSString stringWithFormat:@"时间:%@",@"11"];
            break;
        case 3:
            strInfo = [NSString stringWithFormat:@"时间:%@",@"11"];
            break;
        case 4:
            strInfo = [NSString stringWithFormat:@"时间:%@",@"11"];
            break;
            
        default:
            break;
    }
    label.text = strInfo;
    return cell;
}


#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
