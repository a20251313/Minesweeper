//
//  JFVictoryViewController.h
//  Minesweeper
//
//  Created by ran on 13-7-31.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFCellDataModel.h"
#import "JFGameInfoModel.h"

@interface JFVictoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView   *m_tableView;
    NSMutableArray  *m_arrayData;
}

@end
