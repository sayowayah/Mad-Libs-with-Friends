//
//  TemplateViewController.m
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TemplateViewController.h"
#import "FormViewController.h"

@interface TemplateViewController ()

@end

@implementation TemplateViewController

@synthesize templates = _templates;
@synthesize templateBlanks = _templateBlanks;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.title = @"Templates";
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
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
  // return the number of templates in array returned by API call
  return [self.templates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  // Configure the cell...
  // no cell in cache, so allocate a new cell
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  // get list of template names
  cell.textLabel.text = [[self.templates objectAtIndex:indexPath.row] objectForKey:@"Name"];
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
  // Navigation logic may go here. Create and push another view controller.
  NSURL *url = [NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/getBlanksForStory"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
  NSData *requestData = [@"userId=1&storyId=3" dataUsingEncoding:NSUTF8StringEncoding];
  
  [request setHTTPMethod:@"POST"];
  [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody: requestData];
  
  [[NSURLConnection alloc] initWithRequest:request delegate:self];

  /*
  __autoreleasing NSError* error = nil;
  id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
  if (error != nil) return nil;
  //  return result;  
  */
  
  
  
  

  
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  //    NSData *results = data;
  //    NSString *ReturnStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
  //NSLog(ReturnStr);

  NSMutableArray *templateBlanks = [[NSMutableArray alloc] init];
  __autoreleasing NSError* error = nil;
  
  // TODO: check backend of getTemplateBlanks for unterminated strings

  templateBlanks = [NSJSONSerialization JSONObjectWithData:data 
                                              options:NSJSONReadingMutableContainers error:&error];
  if (templateBlanks == nil) {
    NSLog(@"error: %@", error);
  }
  else {
    NSLog(@"nothing wrong");
  }
  


  FormViewController *formViewController = [[FormViewController alloc] initWithNibName:@"FormViewController" bundle:nil];
  formViewController.templateBlanks = templateBlanks;
  // Pass the selected object to the new view controller.
  [self.navigationController pushViewController:formViewController animated:YES];
  
}

@end
