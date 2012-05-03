//
//  StoryViewController.m
//  project3
//
//  Created by James Chou on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoryViewController.h"

@interface StoryViewController ()

@end

@implementation StoryViewController

@synthesize completedStoryText = _completedStoryText;
@synthesize exit = _exit;
@synthesize scroll = _scroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)exit:(id)sender{
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Completed Story";
  // TODO: hide back button
    int numberOfScreens = ([self.completedStoryText length] / 600) + 0.5;
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*numberOfScreens);  
  UILabel *story = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 300, self.view.frame.size.height*numberOfScreens)];
  
  // TODO: fix scroll
  // TODO: add button
    story.text = self.completedStoryText;
  [self.scroll addSubview:story];
  
  
  // about 30 characters per line, about 20 lines per screen = 600 characters

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
