//
//  JFMineLevelConfig.m
//  Minesweeper
//
//  Created by ran on 13-7-22.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFMineLevelConfig.h"

@implementation JFMineLevelConfig

@synthesize minePicNumber;
@synthesize mineNumber;
@synthesize totalButtonNumber;
@synthesize colummNumber;
@synthesize rowNumber;
@synthesize minelevel;


-(NSString *)description
{

    return [NSString stringWithFormat:@"address:<%p>,minePicNumber:%d mineNumber:%d totalButtonNumber:%d level:%d",self,self.minePicNumber,self.mineNumber,self.totalButtonNumber,self.minelevel];
}

@end
