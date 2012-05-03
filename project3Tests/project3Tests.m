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


// upon initialization, all values should be 0
-(void)testGameSingleton_init
{  
  GameSingleton *gameSingleton = [GameSingleton getInstance];
  
  // playerNumber should be 0 
  STAssertTrue(gameSingleton.playerNumber == 0, @"playerNumber set to 0");
  
  // templateId should be 0 
  STAssertTrue(gameSingleton.templateId == 0, @"templateId set to 0");
  
  // storyId should be 0 
  STAssertTrue(gameSingleton.storyId == 0, @"storyId set to 0");
  
  // opponentId should be 0 
  STAssertTrue(gameSingleton.opponentId == 0, @"opponentId set to 0");
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
  STAssertTrue(gameSingleton.playerNumber == 1, @"playerNumber set correctly");
  
  // templateId should be 2
  STAssertTrue(gameSingleton.templateId == 2, @"templateId set correctly");
  
  // storyId should be 3
  STAssertTrue(gameSingleton.storyId == 3, @"storyId set correctly");
  
  // opponentId should be 4 
  STAssertTrue(gameSingleton.opponentId == 4, @"opponentId set correctly");
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
  STAssertTrue(gameSingleton.playerNumber == 0, @"playerNumber set to 0");
  
  // templateId should be 0 
  STAssertTrue(gameSingleton.templateId == 0, @"templateId set to 0");
  
  // storyId should be 0 
  STAssertTrue(gameSingleton.storyId == 0, @"storyId set to 0");
  
  // opponentId should be 0 
  STAssertTrue(gameSingleton.opponentId == 0, @"opponentId set to 0");
}

@end
