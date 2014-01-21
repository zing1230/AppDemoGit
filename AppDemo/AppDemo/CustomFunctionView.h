//
//  CustomFunctionView.h
//  AppDemo
//
//  Created by Sidney on 13-8-30.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICircularSlider.h"


@protocol CustomFunctionViewDelegate;

@interface CustomFunctionView : UIView
<UIAlertViewDelegate>
{
    UICircularSlider * circularSlider;
    NSTimer * timer;
    UIButton * curBtn;
    BOOL isDownload;
}

@property(nonatomic,assign) id<CustomFunctionViewDelegate> delegate;

@end

@protocol CustomFunctionViewDelegate <NSObject>
@optional

- (void)functionSelectedAtIndex:(int)index functionView:(CustomFunctionView *)view;


@end