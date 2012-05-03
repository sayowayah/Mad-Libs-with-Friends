//
//  ViewController.m
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "AppDelegate.h"
#import "ViewController.h"
#import "TemplateViewController.h"
#import "FormViewController.h"
#import "GameSingleton.h"
#import "FriendsViewController.h"

@interface ViewController ()

@end

@interface NSArray(JSONCategories)
+(NSArray*)arrayWithContentsOfJSONURLString:
(NSString*)urlAddress;
-(NSData*)toJSON;
@end
@implementation NSArray(JSONCategories)
+(NSArray*)arrayWithContentsOfJSONURLString:
(NSString*)urlAddress
{
  NSData* data = [NSData dataWithContentsOfURL:
                  [NSURL URLWithString: urlAddress] ];
  
  
  __autoreleasing NSError* error = nil;
  id result = [NSJSONSerialization JSONObjectWithData:data 
                                              options:kNilOptions error:&error];
  if (error != nil) return nil;
  return result;
}

-(NSData*)toJSON
{
  NSError* error = nil;
  id result = [NSJSONSerialization dataWithJSONObject:self 
                                              options:kNilOptions error:&error];
  if (error != nil) return nil;
  return result;    
}
@end
@implementation ViewController

@synthesize tableView = _tableView;
@synthesize theirs = _theirs;
@synthesize mine = _mine;
@synthesize facebook;

- (void)viewDidLoad {
  [super viewDidLoad];
  // hide the navigation bar upon load
  [self.navigationController setNavigationBarHidden:YES animated:YES];
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  [gameSingleton reset];
  
  
  // get NSArray of outstanding stories from JSON API call
  NSString *requestString = [[NSString alloc] initWithFormat:@"userId=%d",1];
  NSData *requestData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
  NSURL *url = [NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/getStoriesOutstanding"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
  [request setHTTPMethod:@"POST"];
  [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody: requestData];
  
  (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  
  NSMutableArray *theirs = [[NSMutableArray alloc] init];
  NSError* error = nil;
  
  theirs = [NSJSONSerialization JSONObjectWithData:data 
                                                   options:NSJSONReadingMutableContainers error:&error];
  if (theirs == nil) {
    NSLog(@"error: %@", error);
  }
  else {
    NSLog(@"nothing wrong");
    self.theirs = theirs;
    [self.tableView reloadData];

  }
  
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
  // hide the navigation bar if user presses back from next screen
  [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)startGame:(id)sender {
  
  // set player number global variable to 1
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  gameSingleton.playerNumber = 1;
  
  // load FB friends from API
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  [[delegate facebook] requestWithGraphPath:@"me/friends" andDelegate:self];  
  
}

- (void) request:(FBRequest *)request didLoad:(id)result {
  NSMutableDictionary *friendData = [[NSMutableDictionary alloc] initWithDictionary:result];

  [self.navigationController setNavigationBarHidden:NO animated:YES];
  FriendsViewController *controller = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:nil];
  // set the controller friendData = the data FB returns
  controller.friendData = friendData;
  [self.navigationController pushViewController:controller animated:YES];
  
}

-(void) request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}


- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Two groups of on-going games: "Your Turn" and "Their Turn"
  return 2;
}




- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  switch (section) {
    case 0:
  // TODO: call webservice API to get number of array of outstanding stories then return this number
      return 2;
      
    case 1:
      // TODO: call webservice API to get number of array of outstanding stories then return this number
      return [self.theirs count];
    default:
      return 0;
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
    return nil;
  }
  else {
    switch (section) {      
      case 0:
        
        return @"Your Turn";
        
      case 1:
        return @"Their Turn";
        
    }
    return nil;
  }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // identifier that allows cell to be pulled from cache
  static NSString *CellIdentifier = @"Cell";
  
  // try to get cell from cache
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  // no cell in cache, so allocate a new cell
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  // TODO: get name of story and opposing player
  // TODO: add storyId to the cell.textfield.tag
  // TODO: add in detail text of story and words
  //  cell.textLabel.text = [self.tfs objectAtIndex:indexPath.row];
  if (indexPath.section == 0) {
    cell.textLabel.text = @"first section!";
    return cell;    
  }
  else {
    cell.textLabel.text = [[self.theirs objectAtIndex:indexPath.row] objectForKey:@"Name"];
    //cell.textLabel.text = @"second section!";
    return cell;    
  }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1){
  // TODO: load game, remember to set gameSingleton.playerNumber = 2    
  }
  else {
  // TODO: figure out what to do when user clicks on game that's on their turn    
  }

}



@end
