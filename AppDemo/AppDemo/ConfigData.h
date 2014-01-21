//
//  ConfigData.h
//  AppDemo
//
//  Created by Sidney on 13-8-13.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface ConfigData : NSObject

@property(nonatomic,assign)BOOL needRotation;
@property(nonatomic,assign)BOOL isLongPressed;

- (NetworkStatus)getNetworkStatus;


- (void)setNeedRotation:(BOOL)status;
- (BOOL)getNeedRotation;


+ (id)shareInstance;

@end
