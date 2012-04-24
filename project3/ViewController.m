//
//  ViewController.m
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "TemplateViewController.h"
#import "FormViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)startGame:(id)sender {

  // TODO: Link instead to FB friends when implemented
  /*
   FormViewController *controller = [[FormViewController alloc] initWithNibName:@"FormViewController" bundle:nil];
   */
  TemplateViewController *controller = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController" bundle:nil];

  
  // create new navigation stack on the template view controller
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
  navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
  [self presentModalViewController:navController animated:YES];
  
  //  [self.navigationController pushViewController:controller animated:YES];
  
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
