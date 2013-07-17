//
//  AppDelegate.m
//  DonationTracker
//
//  Created by Mohammad Azam on 6/27/13.
//  Copyright (c) 2013 Mohammad Azam. All rights reserved.
//

#import "AppDelegate.h"
#import "DonationPaymentViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupTheme];
    
    self.databaseName = @"DonationTrackerDB";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];

    [self createAndCheckDatabase];
    
    return YES;
}

-(void) setupTheme
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"2-orange-menu-bar"] forBarMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage imageNamed:@"2-orange-bar-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"2-orange-back-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
     [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"2-orange-toolbar"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    // [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"green"]];
    
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    
}

-(void) createAndCheckDatabase
{
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:self.databasePath];
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    
    NSLog(@"%@",databasePathFromApp);
    
    if(success) return;
    
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];
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
