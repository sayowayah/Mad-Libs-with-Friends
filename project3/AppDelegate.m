//
//  AppDelegate.m
//  project3
//
//  Created by James Chou on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize facebook;
@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // initialize facebook
  facebook = [[Facebook alloc] initWithAppId:@"431081513568593" andDelegate:self];
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  if ([defaults objectForKey:@"FBAccessTokenKey"] 
      && [defaults objectForKey:@"FBExpirationDateKey"]) {
    facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
    facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
  }
  if (![facebook isSessionValid]) {
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"publish_actions", 
                            nil];
    [facebook authorize:permissions];
  }
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  
  self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
  
  // create navigation controller 
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
  // hide the navigation bar on first screen
  [navigationController setNavigationBarHidden:YES animated:NO];
  self.window.rootViewController = navigationController;
  [self.window makeKeyAndVisible];
  return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
  [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
  [defaults synchronize];
  
}


- (void)fbDidNotLogin:(BOOL)cancelled {
  
  /**
   * Called after the access token was extended. If your application has any
   * references to the previous access token (for example, if your application
   * stores the previous access token in persistent storage), your application
   * should overwrite the old access token with the new one in this method.
   * See extendAccessToken for more details.
   */
}

- (void)fbDidExtendToken:(NSString*)accessToken expiresAt:(NSDate*)expiresAt {
  
  /**
   * Called when the user logged out.
   */
}

- (void)fbDidLogout {
  
  /**
   * Called when the current session has expired. This might happen when:
   *  - the access token expired
   *  - the app has been disabled
   *  - the user revoked the app's permissions
   *  - the user changed his or her password
   */
}

- (void)fbSessionInvalidated {
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
