//
//  CustomKeywordView.h
//  iLearning
//
//  Created by Sidney on 13-8-12.
//  Copyright (c) 2013年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol CustomKeywordViewDelegate;
@interface CustomKeywordView : UIView


@property (nonatomic,assign) id<CustomKeywordViewDelegate> delegate;

@property (nonatomic,strong) UIImageView * keywordImgView;

- (void)setImageName:(NSString *)imgName;
- (void)startAnimation;
- (void)stopAnimation;

- (void)startReplaceCurView;
- (void)stopReplaceCurView;

@end

@protocol CustomKeywordViewDelegate <NSObject>
@optional

- (void)startReplaceOtherKeyworkd:(CustomKeywordView *)view curIndex:(int)index;

@end