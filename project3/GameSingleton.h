//
//  GameSingleton.h
//  project3
//
//  Created by James Chou on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSingleton : NSObject

@property (assign, nonatomic) NSInteger playerNumber;
@property (assign, nonatomic) NSInteger storyId;
@property (assign, nonatomic) NSInteger templateId;
@property (assign, nonatomic) NSInteger opponentId;

+(GameSingleton*)getInstance;
-(void) reset;

@end
