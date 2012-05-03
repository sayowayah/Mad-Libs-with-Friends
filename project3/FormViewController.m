//
//  FormViewController.m
//  project3
//
//  Created by James Chou on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormViewController.h"
#import "GameSingleton.h"
#import "StoryViewController.h"

@interface FormViewController ()

@end

@implementation FormViewController

@synthesize templateBlanks = _templateBlanks;
@synthesize submitData = _submitData;
@synthesize wordList = _wordList;
@synthesize scrollView = _scrollView;
@synthesize connectionRequest = _connectionRequest;

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
    [wordInput setAutocorrectionType:UITextAutocorrectionTypeNo];
    
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
  
  // TODO: get appropriate userID from UserDefaults
  NSString *userId = [NSString stringWithFormat:@"%d", 1];
  
  // TODO: get appropriate opponentID (add a property)
  NSString *opponentId = [NSString stringWithFormat:@"%d", 2];
  
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  
  NSString *templateIdString = [NSString stringWithFormat:@"%d",gameSingleton.templateId];
  
  // TODO: delete after testing
  //int player = 1;
  gameSingleton.playerNumber = 2;
  
  
  // if player 1, create story instance first before submitting words
  if (gameSingleton.playerNumber == 1) {
    NSLog(@"Creating story instance");
    self.connectionRequest = 1;
    // Create submission array of templateId, userId, and userId2    
    NSArray *submitData = [[NSArray alloc] initWithObjects: templateIdString, userId, opponentId, nil];
    NSError* error = nil;
    
    // convert submission array into JSON, then submit via POST
    NSData* jsonSubmitData = [NSJSONSerialization dataWithJSONObject:submitData options:NSJSONWritingPrettyPrinted error:&error];  
    
    NSURL *url = [NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/createNewStory"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];  
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonSubmitData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonSubmitData];
    
    (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
  }
  // else if player 2, submit the words
  else {

    [self submitWords:self];
    
    /* trying to refactor into submitWords
    // iterate through all the textfields and create array of words with (wordId, word) key/value pairs
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
    
    // TODO: get appropriate storyID
    NSString *storyId = [NSString stringWithFormat:@"%d", 1];
    
    // Create submission array of userId, storyId, and wordList
    NSArray *submitData = [[NSArray alloc] initWithObjects: userId, storyId, wordList, nil];
    NSError* error = nil;
    
    // convert submission array into JSON, then submit via POST
    NSData* jsonSubmitData = [NSJSONSerialization dataWithJSONObject:submitData options:NSJSONWritingPrettyPrinted error:&error];  
    
    
    NSURL *url = [NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/submitStory"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];  
    [request setHTTPMethod:@"POST"];
     */
    //    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    /*[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonSubmitData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonSubmitData];
    
    (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
     */
  }  
}

- (void) submitWords:(id)sender {
  NSLog(@"Submitting words");
  self.connectionRequest = 2;
  
  // iterate through all the textfields and create array of words with (wordId, word) key/value pairs
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
  

  GameSingleton *gameSingleton = [GameSingleton getInstance];
  NSString *storyIdString = [NSString stringWithFormat:@"%d", gameSingleton.storyId];

  // TODO: delete once tested
  //  NSString *storyIdString = [NSString stringWithFormat:@"%d", 1];
  
  // TODO: get appropriate userID from UserDefaults
  NSString *userIdString = [NSString stringWithFormat:@"%d", 1];
  
  // Create submission array of userId, storyId, and wordList
  NSArray *submitData = [[NSArray alloc] initWithObjects: userIdString, storyIdString, wordList, nil];
  NSError* error = nil;
  
  // convert submission array into JSON, then submit via POST
  NSData* jsonSubmitData = [NSJSONSerialization dataWithJSONObject:submitData options:NSJSONWritingPrettyPrinted error:&error];  
  
  /*
   // TESTING: JSON format
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
  NSLog(@"Checking connection type");
  // TESTING
  //NSString *ReturnStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
  //NSLog(ReturnStr);
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  // if connectionRequest is 1, set storyId as given from server, then call submitWords method
  if (self.connectionRequest == 1){
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    GameSingleton *gameSingleton = [GameSingleton getInstance];
    gameSingleton.storyId = [dataString intValue];
    [self submitWords:self];
  }
  // proceed with game after words are submitted
  else if (self.connectionRequest == 2) {
    // if player 1, go back to ViewController
    NSLog(@"Checking player number");
    if (gameSingleton.playerNumber == 1) {
      // TODO: add in a SUBMIT SUCCESS pop up or something
      [self.navigationController popToRootViewControllerAnimated:YES];      
    }
    else {
    // TODO: if player 2, load completed story
      [self loadCompletedStory:self];
    }
  }
  else {
    // load new screen with completed story
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    StoryViewController *storyViewController = [[StoryViewController alloc] initWithNibName:@"StoryViewController" bundle:nil];
    storyViewController.completedStoryText = returnString;
    [self.navigationController pushViewController:storyViewController animated:YES];
  } 
  
}

- (void) loadCompletedStory:(id)sender {
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  self.connectionRequest = 3;
  //  NSString *requestString = [[NSString alloc] initWithFormat:@"storyId=%d",gameSingleton.storyId];
  
  //TESTING: delete below when done
    NSString *requestString = [[NSString alloc] initWithFormat:@"storyId=7"];
  
  NSData *requestData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURL *url = [NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/getCompletedStory"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
  [request setHTTPMethod:@"POST"];
  [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody: requestData];
  
  (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
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
