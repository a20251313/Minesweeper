//
//  JFGameInfoModel.m
//  Minesweeper
//
//  Created by ran on 13-8-1.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFGameInfoModel.h"
static JFGameInfoModel  *info = nil;

@implementation JFGameInfoModel
@synthesize IsAni;
@synthesize IsAudio;
@synthesize mineConfig;
@synthesize simpleResult;
@synthesize NormalResult;
@synthesize HardResult;
@synthesize DIYResult;
+(id)shareGameInfo
{
  
    if (info == nil)
    {
        info = [[JFGameInfoModel alloc] init];
        [JFGameInfoModel GetGameInfo];
    }
    return info;
}



+(void)storeGameInfo
{
    NSMutableDictionary  *dicInfo = [NSMutableDictionary dictionaryWithCapacity:5];
    NSDictionary  *dicConfig = [NSDictionary dictionaryWithObjectsAndKeys:@(info.mineConfig.minelevel),@"level",@(info.mineConfig.mineNumber),@"mineNumber",@(info.mineConfig.rowNumber),@"rowNumber",@(info.mineConfig.colummNumber),@"colummNumber",@(info.mineConfig.minePicNumber),@"minePicNumber",nil];
    [dicInfo setObject:dicConfig forKey:@"mineConfig"];
    
    NSDictionary   *dicsimpleResult = [NSDictionary dictionaryWithObjectsAndKeys:@(info.simpleResult.level),@"level",@(info.simpleResult.bestCostTime),@"bestCostTime",@(info.simpleResult.playTimes),@"playTimes",@(info.simpleResult.winTimes),@"winTimes", nil];
    [dicInfo setObject:dicsimpleResult forKey:@"simpleResult"];
    
    
    NSDictionary   *dicNormalResult = [NSDictionary dictionaryWithObjectsAndKeys:@(info.NormalResult.level),@"level",@(info.NormalResult.bestCostTime),@"bestCostTime",@(info.NormalResult.playTimes),@"playTimes",@(info.NormalResult.winTimes),@"winTimes", nil];
    [dicInfo setObject:dicNormalResult forKey:@"NormalResult"];
    
    
    NSDictionary   *dicHardResult = [NSDictionary dictionaryWithObjectsAndKeys:@(info.HardResult.level),@"level",@(info.HardResult.bestCostTime),@"bestCostTime",@(info.HardResult.playTimes),@"playTimes",@(info.HardResult.winTimes),@"winTimes", nil];
    [dicInfo setObject:dicHardResult forKey:@"HardResult"];
    
    
    NSDictionary   *dicDIYResult = [NSDictionary dictionaryWithObjectsAndKeys:@(info.DIYResult.level),@"level",@(info.DIYResult.bestCostTime),@"bestCostTime",@(info.DIYResult.playTimes),@"playTimes",@(info.DIYResult.winTimes),@"winTimes", nil];
    [dicInfo setObject:dicDIYResult forKey:@"DIYResult"];
    
    
    [dicInfo setObject:@(info.IsAni) forKey:@"ISANI"];
    [dicInfo setObject:@(info.IsAudio) forKey:@"IsAudio"];
    
    [[NSUserDefaults standardUserDefaults] setObject:dicInfo forKey:@"JFGameInfoModel"];
}

+(void)GetGameInfo
{
    
    NSDictionary  *dicInfo = [[NSUserDefaults standardUserDefaults] valueForKey:@"JFGameInfoModel"];
    
    JFMineLevelConfig  *config = [[JFMineLevelConfig alloc] init];
    info.mineConfig = config;
    
    JFGameResultModel  *simleResult = [[JFGameResultModel alloc] init];
    info.simpleResult = simleResult;
    
    JFGameResultModel  *NormalResult = [[JFGameResultModel alloc] init];
    info.NormalResult = NormalResult;
    
    JFGameResultModel  *HardResult = [[JFGameResultModel alloc] init];
    info.HardResult = HardResult;
    
    JFGameResultModel  *DIYResult = [[JFGameResultModel alloc] init];
    info.DIYResult = DIYResult;
    
    
    
    if (dicInfo)
    {
        NSDictionary  *dicConfig = [dicInfo valueForKey:@"mineConfig"];
        config.minelevel = [[dicConfig valueForKey:@"level"] intValue];
        config.mineNumber = [[dicConfig valueForKey:@"mineNumber"] intValue];
        config.rowNumber = [[dicConfig valueForKey:@"rowNumber"] intValue];
        config.colummNumber = [[dicConfig valueForKey:@"colummNumber"] intValue];
        config.totalButtonNumber = config.rowNumber*config.colummNumber;
        config.minePicNumber = [[dicConfig valueForKey:@"minePicNumber"] intValue];
        
        NSDictionary  *dicResult = [dicInfo valueForKey:@"simpleResult"];
        simleResult.bestCostTime = [[dicResult valueForKey:@"bestCostTime"] intValue];
        simleResult.level = [[dicResult valueForKey:@"level"] intValue];
        simleResult.playTimes = [[dicResult valueForKey:@"playTimes"] intValue];
        simleResult.winTimes = [[dicResult valueForKey:@"winTimes"] intValue];
        
        
        dicResult = [dicInfo valueForKey:@"NormalResult"];
        NormalResult.bestCostTime = [[dicResult valueForKey:@"bestCostTime"] intValue];
        NormalResult.level = [[dicResult valueForKey:@"level"] intValue];
        NormalResult.playTimes = [[dicResult valueForKey:@"playTimes"] intValue];
        NormalResult.winTimes = [[dicResult valueForKey:@"winTimes"] intValue];
        
        
        dicResult = [dicInfo valueForKey:@"HardResult"];
        HardResult.bestCostTime = [[dicResult valueForKey:@"bestCostTime"] intValue];
        HardResult.level = [[dicResult valueForKey:@"level"] intValue];
        HardResult.playTimes = [[dicResult valueForKey:@"playTimes"] intValue];
        HardResult.winTimes = [[dicResult valueForKey:@"winTimes"] intValue];
        
        
        dicResult = [dicInfo valueForKey:@"DIYResult"];
        DIYResult.bestCostTime = [[dicResult valueForKey:@"bestCostTime"] intValue];
        DIYResult.level = [[dicResult valueForKey:@"level"] intValue];
        DIYResult.playTimes = [[dicResult valueForKey:@"playTimes"] intValue];
        DIYResult.winTimes = [[dicResult valueForKey:@"winTimes"] intValue];
        
        info.IsAni = [[dicInfo valueForKey:@"ISANI"] boolValue];
        info.IsAudio = [[dicInfo valueForKey:@"IsAudio"] boolValue];
    }else
    {
        config.minelevel = JFMineLevelSimple;
        config.mineNumber = 40;
        config.rowNumber = 16;
        config.colummNumber = 16;
        config.minePicNumber = 2;
        info.IsAudio = YES;
        info.IsAni = YES;
        
        simleResult.bestCostTime = 0;
        simleResult.playTimes = 0;
        simleResult.winTimes = 0;
        simleResult.level = JFMineLevelSimple;
        
        NormalResult.bestCostTime = 0;
        NormalResult.playTimes = 0;
        NormalResult.winTimes = 0;
        NormalResult.level = JFMineLevelNormal;
        
        HardResult.bestCostTime = 0;
        HardResult.playTimes = 0;
        HardResult.winTimes = 0;
        HardResult.level = JFMineLevelHard;
        
        
        DIYResult.bestCostTime = 0;
        DIYResult.playTimes = 0;
        DIYResult.winTimes = 0;
        DIYResult.level = JFMineLevelSelfMake;
        
    }
    
    [config release];
    [simleResult release];
    [HardResult release];
    [NormalResult release];
    [DIYResult release];

}

-(void)dealloc
{
    self.mineConfig = nil;
    self.simpleResult = nil;
    self.NormalResult = nil;
    self.HardResult = nil;
    self.DIYResult = nil;
    [super dealloc];
}
@end
