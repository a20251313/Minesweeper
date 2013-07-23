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


-(NSString *)description
{

    return [NSString stringWithFormat:@"address:<%p>,minePicNumber:%d mineNumber:%d totalButtonNumber:%d",self,self.minePicNumber,self.mineNumber,self.totalButtonNumber];
}

@end
