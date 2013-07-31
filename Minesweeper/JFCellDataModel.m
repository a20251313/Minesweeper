//
//  JFCellDataModel.m
//  Minesweeper
//
//  Created by ran on 13-7-31.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFCellDataModel.h"

@interface JFCellDataModel ()

@end

@implementation JFCellDataModel

@synthesize cellType;
@synthesize title;
@synthesize rowCount;
@synthesize arrayText;
@synthesize arraySubText;
@synthesize arrayImage;
-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


-(void)dealloc
{
    self.title = nil;
    self.arrayImage = nil;
    self.arraySubText = nil;
    self.arrayText = nil;
    
    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"JFCellDataModel:<<%p>> \n cellType:%d  title:%@ rpwCount:%d arrayText:%@ arraySubText:%@ arrayImage:%@",self,self.cellType,self.title,self.rowCount,self.arrayText,self.arraySubText,self.arrayImage];
}
@end
