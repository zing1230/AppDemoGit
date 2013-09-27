//
//  ConfigData.m
//  AppDemo
//
//  Created by Sidney on 13-8-13.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "ConfigData.h"

static ConfigData * _instance;
@implementation ConfigData


+ (id)shareInstance
{
    @synchronized(self){
        if (!_instance) {
            _instance = [[ConfigData alloc] init];
            [_instance setNeedRotation:NO];
            _instance.isLongPressed = NO;
        }
    }
    return _instance;
}

- (NetworkStatus)getNetworkStatus
{
    Reachability * reachbility = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachbility currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            NSLog(@"当前网络不可用");
            break;
        case ReachableViaWWAN:
            NSLog(@"使用3G网络");
            break;
        case ReachableViaWiFi:
            NSLog(@"使用WiFi网络");
            break;
    }
    return status;
}


- (void)setNeedRotation:(BOOL)status;
{
    _needRotation = status;
}

- (BOOL)getNeedRotation
{
    return _needRotation;
}

@end
