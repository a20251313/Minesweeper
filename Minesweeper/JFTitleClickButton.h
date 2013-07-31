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
    int                m_iSeconds;
    NSTimer            *m_timer;
}
@property(nonatomic,retain)JFMineLevelConfig  *mineConfig;
@property(nonatomic,assign)id<JFTitleClickButtonDelegate> delegate;
-(void)startTimer;

- (id)initWithFrame:(CGRect)frame WithConfig:(JFMineLevelConfig*)config;
-(void)setMineFlagNumber:(int)flagNumber;
-(int)stopTimer;
@end
