//
//  GlobalConfig.h
//  Forum
//
//  Created by Lei Zhu on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "AppDelegate.h"
#ifndef GLOBAL_CONFIG
#define GLOBAL_CONFIG

#if DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif
 

#define IS_RETINA_4_INCH_SCREEN  ([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height - ((IS_IOS_7) ? 0 : 20))
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height - 20)

#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? YES : NO


//#define NAV_BAR_HEIGHT ((IS_IOS_7) ? 55 : 35)
#define NAV_BAR_HEIGHT  35




#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define FILENAME(filename)  [[NSBundle mainBundle] pathForAuxiliaryExecutable:filename]

#endif