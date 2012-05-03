//
//  GameSingleton.m
//  project3
//
//  Created by James Chou on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameSingleton.h"

@implementation GameSingleton

@synthesize playerNumber = _playerNumber;
@synthesize templateId = _templateId;
@synthesize storyId = _storyId;
@synthesize opponentId = _opponentId;

static GameSingleton *instance =nil;    
+(GameSingleton *)getInstance {    
  @synchronized(self)    
  {    
    if(instance==nil)    
    {    
      
      instance= [GameSingleton new];    
    }    
  }    
  return instance;    
}    

- (void) reset {
  self.playerNumber = 0;
  self.templateId = 0;
  self.storyId = 0;
  self.opponentId = 0;
  
}

@end
