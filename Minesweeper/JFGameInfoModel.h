//
//  JFGameInfoModel.h
//  Minesweeper
//
//  Created by ran on 13-8-1.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFMineLevelConfig.h"
#import "JFGameResultModel.h"

@interface JFGameInfoModel : NSObject

@property(nonatomic)BOOL   IsAni;
@property(nonatomic)BOOL   IsAudio;

@property(nonatomic,retain)JFMineLevelConfig   *mineConfig;
@property(nonatomic,retain)JFGameResultModel  *simpleResult;
@property(nonatomic,retain)JFGameResultModel  *NormalResult;
@property(nonatomic,retain)JFGameResultModel  *HardResult;
@property(nonatomic,retain)JFGameResultModel  *DIYResult;


+(id)shareGameInfo;
+(void)storeGameInfo;
+(void)GetGameInfo;
@end
