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

- (void)setNeedRotation:(BOOL)status;
{
    _needRotation = status;
}

- (BOOL)getNeedRotation
{
    return _needRotation;
}

@end
