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
    [wordInput addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.scrollView addSubview:wordInput];
    
    
    
    UILabel *partOfSpeech = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + (i*40), 110, 30)];
    [partOfSpeech setText:[blanks objectForKey:@"PartOfSpeech"]];
    [self.scrollView addSubview:partOfSpeech];
    
    i++;

  }
  
  // make the scrollView height dynamic based on number of input rows (each screen fits about 7 rows)
  int numberOfScreens = (i / 7) + 0.5;
  self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*numberOfScreens);  
  
  // create submit button on the bottom of the page
  UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(100, 30 + (i*40), 120, 50)];
  [submit setBackgroundColor:[UIColor blueColor]];
  [submit setTitle:@"Submit" forState:UIControlStateNormal];
  [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.scrollView addSubview:submit];
  
}

// NICE TO HAVE: trying to hide keyboard when user presses on background
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  [self.view resignFirstResponder];
}

- (void) hideKeyboard:(id)sender {
  [sender resignFirstResponder];
}


- (void)submit:(id)sender {

  // iterate through all the textfields and put (wordId, word) as key/value pair into dictionary
  NSMutableArray *wordList = [[NSMutableArray alloc] init];
  

  for (UIView *view in [self.scrollView subviews]) {
    if ([view isKindOfClass:[UITextField class]]) {      
      NSMutableDictionary *word = [[NSMutableDictionary alloc] init];
      UITextField *textField = (UITextField *)view;
      [word setValue:textField.text forKey:@"word"];
      NSString *wordId = [NSString stringWithFormat:@"%d", textField.tag];
      [word setValue:wordId forKey:@"wordId"];
      [wordList addObject:word];
    }
  }

  // TODO: get appropriate userID and storyIDs. pass 0 as storyId if this is player 1
  NSString *userId = [NSString stringWithFormat:@"%d", 1];
  NSString *storyId = [NSString stringWithFormat:@"%d", 1];
  
  // Create submission array of userId, storyId, and wordList
  NSArray *submitData = [[NSArray alloc] initWithObjects: userId, storyId, wordList, nil];
  NSError* error = nil;

  // convert submission array into JSON, then submit via POST
  NSData* jsonSubmitData = [NSJSONSerialization dataWithJSONObject:submitData options:NSJSONWritingPrettyPrinted error:&error];  
  
  /*
  // test JSON format
  NSString *jsonString = [[NSString alloc] initWithData:jsonSubmitData encoding:NSUTF8StringEncoding];
  NSLog(jsonString);
  */
  
  NSURL *url = [NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/submitStory"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];  
  [request setHTTPMethod:@"POST"];
  [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setValue:[NSString stringWithFormat:@"%d", [jsonSubmitData length]] forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody: jsonSubmitData];
  
  (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
  
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  //NSString *ReturnStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
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
  
  
  // check if user is player 1 or 2
  // if player 1, go back to ViewController
  
  [self.navigationController popToRootViewControllerAnimated:YES];
  
  // if player 2, show completed story
  
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
