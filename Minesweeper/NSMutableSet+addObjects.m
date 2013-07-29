//
//  NSMutableSet+addObjects.m
//  Minesweeper
//
//  Created by ran on 13-7-29.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "NSMutableSet+addObjects.h"

@implementation NSMutableSet (addObjects)



-(void)addobjectFromSet:(NSSet*)addset
{
    
    for (int i = 0; i < [addset allObjects].count; i++)
    {
        
        [self addObject:[[addset allObjects] objectAtIndex:i]];
    }
    
}
@end