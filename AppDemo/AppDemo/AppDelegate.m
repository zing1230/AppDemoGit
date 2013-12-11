//
//  AppDelegate.m
//  AppDemo
//
//  Created by sidney on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "MMDrawerController.h"
#import "RightSideViewController.h"
#import "LeftSideViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];

    _rootViewCtrller = [[RootViewController alloc] init];
    _rightSideViewCtrller = [[RightSideViewController alloc] init];
    _leftSideViewCtrller = [[LeftSideViewController alloc] init];
        
    self.navController = [[UINavigationController alloc] initWithRootViewController:_rootViewCtrller];
    self.navController.navigationBarHidden = YES;
    
    
//    MMDrawerController * drawerController = [[MMDrawerController alloc]
//                                             initWithCenterViewController:self.navController
//                                             leftDrawerViewController:nil
//                                             rightDrawerViewController:_rightSideViewCtrller];
//    
//    [drawerController setMaximumRightDrawerWidth:116];
//    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningCenterView];
//    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModePanningCenterView | MMCloseDrawerGestureModeTapCenterView];
    

    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:self.navController];
    
    _revealSideViewController.delegate = self;
    [_revealSideViewController resetOption:PPRevealSideOptionsBounceAnimations];
    
    _revealSideViewController.panInteractionsWhenOpened = PPRevealSideInteractionContentView;
    _revealSideViewController.panInteractionsWhenClosed = PPRevealSideInteractionContentView;

    [self.window setRootViewController:_revealSideViewController];
    
    self.window.backgroundColor =  RGBACOLOR(65,65,65,1);
    [self.window makeKeyAndVisible];
//    [_rootViewCtrller setCanMoveToOpenRightViewStatus:NO];
    
    return YES;
}

#pragma mark - PPRevealSideViewController delegate

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller willPushController:(UIViewController *)pushedController {
    _rootViewCtrller.speakerView.userInteractionEnabled = NO;
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didPushController:(UIViewController *)pushedController {
    
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller willPopToController:(UIViewController *)centerController {
    
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didPopToController:(UIViewController *)centerController {
    _rootViewCtrller.speakerView.userInteractionEnabled = YES;
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didChangeCenterController:(UIViewController *)newCenterController {
    
}

- (BOOL) pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateDirectionGesture:(UIGestureRecognizer*)gesture forView:(UIView*)view {
    return NO;
}

- (PPRevealSideDirection)pprevealSideViewController:(PPRevealSideViewController*)controller directionsAllowedForPanningOnView:(UIView*)view
{
    return PPRevealSideDirectionRight;
}

- (void)showAlertView:(NSString *)title message:(NSString *)msg
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title
                                                         message:msg
                                                        delegate:nil
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:nil];
    [alertView show];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [self showAlertView:@"handleOpenURL" message:[url description]];
    if ([[url scheme] isEqualToString:@"com.isoftstone.appdemo://safari"]) {
        
    }
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
