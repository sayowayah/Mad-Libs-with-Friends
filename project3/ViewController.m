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

// extend NSDictionary class with JSON decoding and encoding functionality

@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
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

  // get NSArray of templates from JSON API call
  NSArray* templates = [NSArray arrayWithContentsOfJSONURLString:@"http://six6.ca/friendlibs_api/index.php/main/getStoryTemplates"];
  
  [self.navigationController setNavigationBarHidden:NO animated:YES];
  TemplateViewController *controller = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController" bundle:nil];
  controller.templates = templates;
  [self.navigationController pushViewController:controller animated:YES];
  
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
      return 2;
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
    cell.textLabel.text = @"second section!";
    return cell;    
  }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // TODO: load game
  // TODO: figure out what to do when user clicks on game that's on their turn
}



@end
