//
//  ZDAppDelegate.m
//  ZDPageNavigationController
//
//  Created by CocoaPods on 05/28/2015.
//  Copyright (c) 2014 0dayZh. All rights reserved.
//

#import "ZDAppDelegate.h"
#import "ZDViewController.h"
#import "ZDPageNavigationController.h"

@implementation ZDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    ZDViewController *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"vc"];
    vc1.title = @"MASTER PASSWORD";
    vc1.text = @"1";
    vc1.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Item" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    ZDViewController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"vc"];
    vc2.title = @"ME";
    vc2.text = @"2";
    vc2.navigationItem.leftBarButtonItems = @[
                                              [[UIBarButtonItem alloc] initWithTitle:@"Item1" style:UIBarButtonItemStyleDone target:nil action:nil],
                                              [[UIBarButtonItem alloc] initWithTitle:@"Item2" style:UIBarButtonItemStyleDone target:nil action:nil]
                                              ];
    
    ZDViewController *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"vc"];
    vc3.title = @"THE";
    vc3.text = @"3";
    vc3.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Item" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    ZDViewController *vc4 = [storyboard instantiateViewControllerWithIdentifier:@"vc"];
    vc4.title = @"MONEY";
    vc4.text = @"4";
    vc4.navigationItem.rightBarButtonItems = @[
                                              [[UIBarButtonItem alloc] initWithTitle:@"Item1" style:UIBarButtonItemStyleDone target:nil action:nil],
                                              [[UIBarButtonItem alloc] initWithTitle:@"Item2" style:UIBarButtonItemStyleDone target:nil action:nil]
                                              ];
    
    ZDPageNavigationController *pageNavController = (ZDPageNavigationController *)self.window.rootViewController;
    pageNavController.usingTitleView = YES;
    pageNavController.maskColor = [UIColor redColor];
    pageNavController.pageViewControllers = @[vc1, vc2, vc3, vc4];
    
    pageNavController.view.backgroundColor = [UIColor yellowColor];
    
    return YES;
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
