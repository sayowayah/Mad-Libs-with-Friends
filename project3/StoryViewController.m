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
  
  self.navigationItem.hidesBackButton = YES;
  
  UILabel *story = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 10)];
  story.lineBreakMode = UILineBreakModeWordWrap;
  story.numberOfLines = 0;
  
  //Calculate the expected size based on the font and linebreak mode of story label
  CGSize maximumLabelSize = CGSizeMake(280,9999);
  CGSize expectedLabelSize = [self.completedStoryText sizeWithFont:story.font 
                                                 constrainedToSize:maximumLabelSize 
                                                     lineBreakMode:story.lineBreakMode]; 
  //adjust the label to the new height.
  CGRect newFrame = story.frame;
  newFrame.size.height = expectedLabelSize.height;
  story.frame = newFrame;
  
  NSString *text = [[NSString alloc] initWithString:self.completedStoryText];
  [story setText:text];
  
  [self.scroll addSubview:story];
  
  self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, newFrame.size.height + 200);
  
  UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake(100, 80 + newFrame.size.height, 120, 50)];
  [exit setBackgroundColor:[UIColor blueColor]];
  [exit setTitle:@"Exit" forState:UIControlStateNormal];
  [exit addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.scroll addSubview:exit];
  
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
