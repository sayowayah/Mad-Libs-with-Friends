//
//  ViewController.h
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

//@interface ViewController : UIViewController <FBRequestDelegate>

@interface ViewController : UIViewController
<FBRequestDelegate>//,
//UITableViewDataSource,
//UITableViewDelegate>{
  /*NSMutableArray *myData;
  NSString *myAction;
  UILabel *messageLabel;
  UIView *messageView;*/
//}

@property (strong, nonatomic) Facebook *facebook;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)startGame:(id)sender;

@end
