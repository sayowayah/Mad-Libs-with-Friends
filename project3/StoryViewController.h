//
//  StoryViewController.h
//  project3
//
//  Created by James Chou on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryViewController : UIViewController

@property (strong, nonatomic) NSString *completedStoryText;
@property (weak, nonatomic) IBOutlet UIButton *exit;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
- (IBAction)exit:(id)sender;

@end
