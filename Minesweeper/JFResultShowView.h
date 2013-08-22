//
//  JFResultShowView.h
//  Minesweeper
//
//  Created by ran on 13-8-20.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "JFMineLevelConfig.h"


@interface JFResultShowModel:NSObject
{
    
}

@property(nonatomic)JFMineLevel  level;
@property(nonatomic)int          winTime;
@property(nonatomic)int          bestTime;
@end



@protocol JFResultShowViewDelegate <NSObject>
-(void)restartGame:(id)sender;
@end

@interface JFResultShowView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    id<JFResultShowViewDelegate>  delegate;
    
    UITableView                 *_tableView;
}

@property(nonatomic,assign)id<JFResultShowViewDelegate> delagate;
@property(nonatomic,retain)JFResultShowModel  *mineModel;
@end
