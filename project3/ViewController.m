//
//  ViewController.m
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import "ViewController.h"
#import "TemplateViewController.h"
#import "FormViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad {
  [super viewDidLoad];
  // hide the navigation bar upon load
  [self.navigationController setNavigationBarHidden:YES animated:YES];
	// Do any additional setup after loading the view, typically from a nib.
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
  
  // TODO: Link instead to FB friends when implemented
  /*
   FormViewController *controller = [[FormViewController alloc] initWithNibName:@"FormViewController" bundle:nil];
   
*/  
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://six6.ca/friendlibs_api/index.php/main/getStoryTemplates"]];
  NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  //NSString *get = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
  //NSLog(get);

  NSError* error;
  NSArray* templates = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
  
    NSLog(@"templates: %@", templates); //3
  

  [self.navigationController setNavigationBarHidden:NO animated:YES];
  TemplateViewController *controller = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController" bundle:nil];
  controller.templates = templates;
  [self.navigationController pushViewController:controller animated:YES];
  
}

- (void)fetchedData:(NSData *)responseData {
  //parse out the json data
  NSError* error;
  NSArray* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
  
  NSDictionary* templates = [json objectAtIndex:0]; //2
  
  NSLog(@"templates: %@", templates); //3
}



- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Two groups of on-going games: "Your Turn" and "Their Turn"
  return 2;
}


- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
  // TODO: call webservice API to get number of array of outstanding stories
  // TODO: return number of outstanding stories
  return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  switch (section) {      
    case 0:
      return @"Your Turn";
      
    case 1:
      return @"Their Turn";
      
      //    default:
      //break;
  }
  return nil;
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
  //  cell.textLabel.text = [self.tfs objectAtIndex:indexPath.row];
  cell.textLabel.text = @"Hello!";
  return cell;
}




@end
