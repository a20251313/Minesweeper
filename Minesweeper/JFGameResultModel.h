//
//  JFGameResultModel.h
//  Minesweeper
//
//  Created by ran on 13-8-1.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFMineLevelConfig.h"

@interface JFGameResultModel : NSObject

@property(nonatomic)JFMineLevel  level;
@property(nonatomic)int bestCostTime;
@property(nonatomic)int playTimes;
@property(nonatomic)int winTimes;

@end
