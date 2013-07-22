//
//  JFTitleClickButton.h
//  Minesweeper
//
//  Created by ran on 13-7-22.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JFMineLevelConfig.h"

@class JFTitleClickButton;



@protocol JFTitleClickButtonDelegate <NSObject>

-(void)clickTitleButton:(JFTitleClickButton*)buttonView;

@end



@interface JFTitleClickButton : UIButton
{
    JFMineLevelConfig  *m_objConfig;
    id<JFTitleClickButtonDelegate>  delegate;
}
@property(nonatomic,retain)JFMineLevelConfig  *mineConfig;
@property(nonatomic,assign)id<JFTitleClickButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame WithConfig:(JFMineLevelConfig*)config;
@end
