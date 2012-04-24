//
//  FormViewController.m
//  project3
//
//  Created by James Chou on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormViewController.h"

@interface FormViewController ()

@end

@implementation FormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.title = @"Enter words";
  
  // TODO: get array of blank words from web service
  // TODO: iterate through array and create row for each blank word
  UITextField *wordInput = [[UITextField alloc] initWithFrame:CGRectMake(120, 15, 150, 40)];
  wordInput.borderStyle = UITextBorderStyleRoundedRect;
  [self.view addSubview:wordInput];
  
  UILabel *partOfSpeech = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 40)];
  partOfSpeech.text = @"noun";
  [self.view addSubview:partOfSpeech];
  
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
