//
//  project3Tests.m
//  project3Tests
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "project3Tests.h"
#import "GameSingleton.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "FriendsViewController.h"
#import "TemplateViewController.h"
#import "FormViewController.h"
#import "StoryViewController.h"

@interface project3Tests ()

@property (nonatomic, readwrite, weak) AppDelegate *appDelegate;
@property (nonatomic, readwrite, weak) ViewController *viewController;
@property (nonatomic, readwrite, weak) FriendsViewController *friendsViewController;
@property (nonatomic, readwrite, weak) TemplateViewController *templateViewController;
@property (nonatomic, readwrite, weak) FormViewController *formViewController;
@property (nonatomic, readwrite, weak) StoryViewController *storyViewController;
@property (nonatomic, readwrite, weak) UIView *view;

@end


@implementation project3Tests

@synthesize appDelegate = _appDelegate;
@synthesize viewController = _viewController;
@synthesize friendsViewController = _friendsViewController;
@synthesize templateViewController = _templateViewController;
@synthesize formViewController = _formViewController;
@synthesize storyViewController = _storyViewController;
@synthesize view = _view;

- (void)setUp
{
  [super setUp];
  
  self.appDelegate = [[UIApplication sharedApplication] delegate];
  self.viewController = self.appDelegate.viewController;
  self.view = self.viewController.view;
}

/***LOGIC TESTS***/
// upon initialization, all values should be 0
-(void)testGameSingleton_init
{  
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  
  // playerNumber should be 0 
  STAssertTrue(gameSingleton.playerNumber == 0, @"playerNumber should be set to 0");
  
  // templateId should be 0 
  STAssertTrue(gameSingleton.templateId == 0, @"templateId should be set to 0");
  
  // storyId should be 0 
  STAssertTrue(gameSingleton.storyId == 0, @"storyId should be set to 0");
  
  // opponentId should be 0 
  STAssertTrue(gameSingleton.opponentId == 0, @"opponentId should be set to 0");
}


// should be able to set initialization values
-(void)testGameSingleton_set
{  
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  
  gameSingleton.playerNumber = 1;
  gameSingleton.templateId = 2;
  gameSingleton.storyId = 3;
  gameSingleton.opponentId = 4;
  
  // playerNumber should be 1 
  STAssertTrue(gameSingleton.playerNumber == 1, @"playerNumber isn't set correctly");
  
  // templateId should be 2
  STAssertTrue(gameSingleton.templateId == 2, @"templateId isn't set correctly");
  
  // storyId should be 3
  STAssertTrue(gameSingleton.storyId == 3, @"storyId isn't set correctly");
  
  // opponentId should be 4 
  STAssertTrue(gameSingleton.opponentId == 4, @"opponentId isn't set correctly");
}


// after setting values, reset should return all back to 0
-(void)testGameSingleton_reset
{  
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  
  gameSingleton.playerNumber = 1;
  gameSingleton.templateId = 2;
  gameSingleton.storyId = 3;
  gameSingleton.opponentId = 4;
  
  // reset
  [gameSingleton reset];
  
  // playerNumber should be 0 
  STAssertTrue(gameSingleton.playerNumber == 0, @"playerNumber should be set to 0");
  
  // templateId should be 0 
  STAssertTrue(gameSingleton.templateId == 0, @"templateId should be set to 0");
  
  // storyId should be 0 
  STAssertTrue(gameSingleton.storyId == 0, @"storyId should be set to 0");
  
  // opponentId should be 0 
  STAssertTrue(gameSingleton.opponentId == 0, @"opponentId should be set to 0");
}

/***APPLICATION TESTS***/




- (void)tearDown
{
  // Tear-down code here.
  
  [super tearDown];
}



- (void)testAppDelegate
{
  //STAssertNotNil((self.appDelegate, @"Cannot find the application delegate");
  
}


//@interface project3Tests ()






@end
