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

@synthesize templateBlanks = _templateBlanks;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Enter words";
  
  // iterate through array of blank words and create row for each blank word
  int i=0;
  for (NSDictionary *blanks in self.templateBlanks) {
    
    UITextField *wordInput = [[UITextField alloc] initWithFrame:CGRectMake(150, 15 + (i*40), 120, 30)];
    wordInput.borderStyle = UITextBorderStyleRoundedRect;
    [wordInput setTag:[[blanks objectForKey:@"Word_ID"] intValue]];
    [self.view addSubview:wordInput];
    
    
    UILabel *partOfSpeech = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + (i*40), 110, 30)];
    [partOfSpeech setText:[blanks objectForKey:@"PartOfSpeech"]];
    [self.view addSubview:partOfSpeech];
    
    i++;
  }

  UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(100, 30 + (i*40), 120, 50)];
  [submit setBackgroundColor:[UIColor blueColor]];
  [submit setTitle:@"Submit" forState:UIControlStateNormal];
  
  // TODO: add in submit functionality sending tags of input fields to the server
  //  [submit addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:submit];
  
}


- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
