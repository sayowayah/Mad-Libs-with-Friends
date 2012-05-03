//
//  AppDelegate.h
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class ViewController;

@interface AppDelegate : NSObject 
<UIApplicationDelegate, FBSessionDelegate> {
  Facebook *facebook;
}
@property (strong, nonatomic) Facebook *facebook;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@end
