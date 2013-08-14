//
//  CustomKeywordView.h
//  iLearning
//
//  Created by Sidney on 13-8-12.
//  Copyright (c) 2013年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomKeywordView : UIView


@property (nonatomic,strong) UIImageView * keywordImgView;

- (void)setImageName:(NSString *)imgName;
- (void)startAnimation;
- (void)stopAnimation;

//- (void)setImageName:(NSString *)imgName;
//- (void)startAnimation;
//- (void)stopAnimation;

//- (void)setImageName:(NSString *)imgName;


@end
