//
//  project3Tests.m
//  project3Tests
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "project3Tests.h"
#import "GameSingleton.h"

@implementation project3Tests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in project3Tests");
}


// if the user plays a w, and the words below are in the dictionary, then the model shoudl return woo and wee
-(void)testGameSingleton
{  
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  
  // playerNumber should be 0 
  STAssertTrue(gameSingleton.playerNumber == 0, @"playerNumber set to 0");
  STAssertTrue(gameSingleton.templateId == 0, @"templateId set to 0");
  STAssertTrue(gameSingleton.storyId == 0, @"storyId set to 0");
  STAssertTrue(gameSingleton.opponentId == 0, @"opponentId set to 0");
}

@end
