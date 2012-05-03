//
//  TemplateViewController.h
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemplateViewController : UITableViewController

@property (strong, nonatomic) NSArray *templates;
@property (strong, nonatomic) NSMutableArray *templateBlanks;
@property (assign, nonatomic) NSInteger requestedTemplate;

@end
