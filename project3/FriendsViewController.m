//
//  FriendsViewController.m
//  project3
//
//  Created by James Chou on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewController.h"
#import "TemplateViewController.h"
#import "GameSingleton.h"

@interface FriendsViewController ()

@end



// extend NSArray class with JSON decoding and encoding functionality

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

@implementation FriendsViewController

@synthesize friendData = _friendData;

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = @"Choose a Friend";
  // FUTURE TODO: search bar
  // FUTURE TODO: sorted friend list
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
  // TODO: return the number of total friends
  return [[self.friendData objectForKey:@"data"] count];
  //  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  // TODO: fill in data for cell.textLabel.text (name) and cell.textLabel.tag (userId)
  NSString *name = [[NSString alloc] initWithString:[[[self.friendData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"name"]];
  NSInteger userId = [[[NSString alloc] initWithString:[[[self.friendData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"id"]] intValue];
  //cell.textLabel.text = [[[self.friendData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"Name"];
  cell.textLabel.text = name;
  cell.textLabel.tag  = userId;
  return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  // TODO: set opponentId after FB friend is chosen
  gameSingleton.opponentId = cell.tag;
  
  // get NSArray of templates from JSON API call
  NSArray* templates = [NSArray arrayWithContentsOfJSONURLString:@"http://six6.ca/friendlibs_api/index.php/main/getStoryTemplates"];
  
  TemplateViewController *controller = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController" bundle:nil];
  controller.templates = templates;
  [self.navigationController pushViewController:controller animated:YES];
  
  
  
}

@end
