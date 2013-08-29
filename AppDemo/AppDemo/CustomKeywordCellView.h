//
//  CustomKeywordCellView.h
//  iLearning
//
//  Created by Sidney on 13-8-12.
//  Copyright (c) 2013年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Keyword : UIImageView


@property(nonatomic,assign)float offsetX;
@property(nonatomic,assign)float offsetY;

@end


typedef void(^CreatTimeDurationWithAlpha)(NSTimeInterval duration, int y,float alpha);

@protocol CustomKeywordCellViewDelegate;
@interface CustomKeywordCellView : UIView


@property (nonatomic,assign) id<CustomKeywordCellViewDelegate> delegate;

@property (nonatomic,strong) Keyword * keywordImgView;

- (void)setImageName:(NSString *)imgName;
- (void)startAnimation;
- (void)stopAnimation;

- (void)startReplaceCurView;
- (void)stopReplaceCurView;

@end

@protocol CustomKeywordCellViewDelegate <NSObject>
@optional

- (void)startReplaceOtherKeyworkd:(CustomKeywordCellView *)view curIndex:(int)index;
- (void)keywordViewTaped:(UITapGestureRecognizer *)tap;
@end