//
//  CustomInputTextView.h
//  AppDemo
//
//  Created by Sidney on 13-8-10.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FTAnimation.h"

@protocol InputTextViewDelegate;
@protocol InputTextViewDelegate <NSObject>
@optional

- (void)inputTextViewRemoved;
- (void)inputTextViewCommit:(NSString *)inputTxt;


@end


@interface CustomInputTextView : UIView
<UITextFieldDelegate>
{
    UITextField * txtField;
}

@property(nonatomic,assign) id<InputTextViewDelegate> delegate;

@end
