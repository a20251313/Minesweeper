//
//  JFHelpViewController.m
//  Minesweeper
//
//  Created by ran on 13-7-31.
//  Copyright (c) 2013年 com.jingfu.ran. All rights reserved.
//

#import "JFHelpViewController.h"

@interface JFHelpViewController ()

@end

@implementation JFHelpViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        // Custom initialization
    }
    return self;
}*/

-(id)init
{
    self = [super init];
    if (self)
    {
        
        self.title = @"帮助";
        self.tabBarItem.image = [UIImage imageNamed:@"help.png"];
        self.tabBarItem.title = @"帮助";
    }
    return self;
}

-(void)loadView
{
    
      [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1.0f];
    NSError  *error = nil;
    NSString  *strPath = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"txt"];
    NSString  *strHelp = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        DLOG(@"error:%@",error);
    }
     CGRect frame = [UIScreen mainScreen].applicationFrame;
     UITextView  *view = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, frame.size.width-20, frame.size.height-44-44-40)];
     view.backgroundColor = [UIColor clearColor];
     view.font = [UIFont systemFontOfSize:17];
     view.text = strHelp;
     view.editable = NO;
     [self.view addSubview:view];
     [view release];
    
  
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
