//
//  FormViewController.h
//  project3
//
//  Created by James Chou on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormViewController : UIViewController

@property (strong, nonatomic) NSArray *templateBlanks;
@property (strong, nonatomic) NSMutableArray *wordList;
@property (strong, nonatomic) NSArray *submitData;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)submit:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
