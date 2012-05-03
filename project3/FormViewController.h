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
@property (assign, nonatomic) NSInteger connectionRequest;

- (IBAction)submit:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (void) submitWords:(id)sender;
- (void) loadCompletedStory:(id)sender;

@end
