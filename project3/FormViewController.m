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
@synthesize submitData = _submitData;
@synthesize wordList = _wordList;
@synthesize scrollView = _scrollView;

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
    [self.scrollView addSubview:wordInput];
    
    
    UILabel *partOfSpeech = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + (i*40), 110, 30)];
    [partOfSpeech setText:[blanks objectForKey:@"PartOfSpeech"]];
    [self.scrollView addSubview:partOfSpeech];
    
    i++;

  }

  // Make the scrollView height dynamic based on number of input rows (each screen fits about 7 rows)
  int numberOfScreens = (i / 7) + 0.5;
  self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*numberOfScreens);
  
  UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(100, 30 + (i*40), 120, 50)];
  [submit setBackgroundColor:[UIColor blueColor]];
  [submit setTitle:@"Submit" forState:UIControlStateNormal];
  
  // TODO: add in submit functionality sending tags of input fields to the server
  //[submit addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
  [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.scrollView addSubview:submit];
  
}



- (void)submit:(id)sender {

  // iterate through all the textfields and put (wordId, word) as key/value pair into dictionary
  NSMutableDictionary *wordList = [[NSMutableDictionary alloc] init];
  for (UIView *view in [self.view subviews]) {
    if ([view isKindOfClass:[UITextField class]]) {      
      UITextField *textField = (UITextField *)view;
      NSString *wordId = [NSString stringWithFormat:@"%d", textField.tag];
      [wordList setValue:textField.text forKey:wordId];
    }
  }

  // TODO: get appropriate userID and storyIDs
  NSString *userId = [NSString stringWithFormat:@"%d", 1];
  NSString *storyId = [NSString stringWithFormat:@"%d", 1];
  NSArray *submitData = [[NSArray alloc] initWithObjects: userId, storyId, wordList, nil];
  NSError* error = nil;
  NSData* jsonSubmitData = [NSJSONSerialization dataWithJSONObject:submitData options:NSJSONWritingPrettyPrinted error:&error];
  
  
  NSURL *url = [NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/submitStory"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
  [request setHTTPMethod:@"POST"];
  [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setValue:[NSString stringWithFormat:@"%d", [jsonSubmitData length]] forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody: jsonSubmitData];
  
  [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
  
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  //    NSData *results = data;
  //    NSString *ReturnStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
  //NSLog(ReturnStr);
  
  NSMutableArray *results = [[NSMutableArray alloc] init];
  NSError* error = nil;
  
  results = [NSJSONSerialization JSONObjectWithData:data 
                                                   options:NSJSONReadingMutableContainers error:&error];
  if (results == nil) {
    NSLog(@"error: %@", error);
  }
  else {
    NSLog(@"nothing wrong. data:  %@", results);
  }
  
  
  /*
  FormViewController *formViewController = [[FormViewController alloc] initWithNibName:@"FormViewController" bundle:nil];
  formViewController.templateBlanks = templateBlanks;
  // Pass the selected object to the new view controller.
  [self.navigationController pushViewController:formViewController animated:YES];
  */
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
