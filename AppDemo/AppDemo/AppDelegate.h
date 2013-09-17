//
//  AppDelegate.h
//  AppDemo
//
//  Created by sun pan on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPRevealSideViewController.h"

@class MLNavigationController;
@class RootViewController;
@class RightSideViewController;
@class LeftSideViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate,
PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) RootViewController *rootViewCtrller;
@property (strong, nonatomic) RightSideViewController *rightSideViewCtrller;
@property (strong, nonatomic) LeftSideViewController *leftSideViewCtrller;

@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;


@end
