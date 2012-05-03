//
//  ViewController.h
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface ViewController : UIViewController <FBRequestDelegate> {
  Facebook *facebook;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Facebook *facebook;
- (IBAction)startGame:(id)sender;

@end
