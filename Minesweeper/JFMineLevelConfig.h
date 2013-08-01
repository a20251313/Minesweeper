//
//  JFMineLevelConfig.h
//  Minesweeper
//
//  Created by ran on 13-7-22.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef  enum
{
    JFMineLevelSimple,
    JFMineLevelNormal,
    JFMineLevelHard,
    JFMineLevelSelfMake,
}JFMineLevel;

@interface JFMineLevelConfig: NSObject

@property(nonatomic)JFMineLevel  minelevel;
@property(nonatomic)int mineNumber;
@property(nonatomic)int totalButtonNumber;
@property(nonatomic)int rowNumber;
@property(nonatomic)int colummNumber;
@property(nonatomic)int minePicNumber;

@end
