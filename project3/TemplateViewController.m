//
//  TemplateViewController.m
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TemplateViewController.h"
#import "FormViewController.h"
#import "GameSingleton.h"

@interface TemplateViewController ()

@end

@implementation TemplateViewController

@synthesize templates = _templates;
@synthesize templateBlanks = _templateBlanks;
@synthesize requestedTemplate = _requestedTemplate;

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
  
  // no cell in cache, so allocate a new cell
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  // get list of template names
  cell.textLabel.text = [[self.templates objectAtIndex:indexPath.row] objectForKey:@"Name"];
  // store template ID into textLabel tag
  cell.textLabel.tag = [[[self.templates objectAtIndex:indexPath.row] objectForKey:@"ID"] intValue];
  return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

  // get templateId, which is stored in the textLabel tag, and create a data request
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  self.requestedTemplate = cell.textLabel.tag;
  NSString *requestString = [[NSString alloc] initWithFormat:@"templateId=%d",self.requestedTemplate];
  NSData *requestData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
  
  // Navigation logic may go here. Create and push another view controller.
  NSURL *url = [NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/getTemplateBlanks"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
  [request setHTTPMethod:@"POST"];
  [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody: requestData];
  
  (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  //    NSData *results = data;
  //    NSString *ReturnStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
  //NSLog(ReturnStr);

  NSMutableArray *templateBlanks = [[NSMutableArray alloc] init];
  NSError* error = nil;

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
  
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  gameSingleton.templateId = self.requestedTemplate;
  
  // Pass the selected object to the new view controller.
  [self.navigationController pushViewController:formViewController animated:YES];
  
}

@end
