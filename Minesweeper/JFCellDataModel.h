//
//  JFCellDataModel.h
//  Minesweeper
//
//  Created by ran on 13-7-31.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  enum
{
    JFCellTypeNone = 1,
    JFCellTypeNormal,
    JFCellTypeSubText,
    JFCellTypeSwith,
    JFCellTypeNormalAndSlide,
    JFCellTypeImage
}JFCellType;
@interface JFCellDataModel : NSObject



@property(nonatomic,copy)NSString  *title;
@property(nonatomic)JFCellType        cellType;
@property(nonatomic)int        rowCount;
@property(nonatomic,retain)NSArray  *arrayText;
@property(nonatomic,retain)NSArray  *arraySubText;
@property(nonatomic,retain)NSArray  *arrayImage;

@end
