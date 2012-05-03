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
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  self.title = @"Choose a Friend";
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
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  // TODO: fill in data for cell.textLabel.text (name) and cell.textLabel.tag (userId)
  cell.textLabel.text = @"Hello";
  return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  // TODO: set opponentId after FB friend is chosen
  gameSingleton.opponentId = 2;
  
  // get NSArray of templates from JSON API call
  NSArray* templates = [NSArray arrayWithContentsOfJSONURLString:@"http://six6.ca/friendlibs_api/index.php/main/getStoryTemplates"];
  
  TemplateViewController *controller = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController" bundle:nil];
  controller.templates = templates;
  [self.navigationController pushViewController:controller animated:YES];
  
  
  
}

@end
