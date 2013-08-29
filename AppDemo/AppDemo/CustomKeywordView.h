//
//  CustomKeywordView.h
//  AppDemo
//
//  Created by Sidney on 13-8-29.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeywordCellView.h"
#import "FTUtils.h"
#import "FTAnimation.h"

@protocol CustomKeywordViewDelegate;


@interface CustomKeywordView : UIView

@property(nonatomic,assign) id <CustomKeywordViewDelegate> delegate;

- (void)setKeywordViewHiddenStatus:(BOOL)status;



@end


@protocol CustomKeywordViewDelegate <NSObject>
@optional

- (void)keywordTaped:(CustomKeywordCellView *)keywordCell  keywordView:(CustomKeywordView *)view;


@end