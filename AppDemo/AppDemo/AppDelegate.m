//
//  AppDelegate.m
//  AppDemo
//
//  Created by sidney on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "MLNavigationController.h"
#import "MMDrawerController.h"
#import "RightSideViewController.h"
#import "LeftSideViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //这是在其他帐号上同步的代码...
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    _rootViewCtrller = [[RootViewController alloc] init];
    _rightSideViewCtrller = [[RightSideViewController alloc] init];
    _leftSideViewCtrller = [[LeftSideViewController alloc] init];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:_rootViewCtrller];
    self.navController.navigationBarHidden = YES;
    
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:self.navController
                                             leftDrawerViewController:nil
                                             rightDrawerViewController:_rightSideViewCtrller];
    
    [drawerController setMaximumRightDrawerWidth:116];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.window setRootViewController:drawerController];
    
    self.window.backgroundColor =  RGBACOLOR(65,65,65,1);
    [self.window makeKeyAndVisible];
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
