//
//  CustomKeywordView.m
//  iLearning
//
//  Created by Sidney on 13-8-12.
//  Copyright (c) 2013年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import "CustomKeywordView.h"

@interface CustomKeywordView()


@property(nonatomic,assign)CGRect imgViewFrame;
@property(nonatomic,assign)BOOL isContinue;
@end

@implementation CustomKeywordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isContinue = YES;
        _keywordImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)setImageName:(NSString *)imgName
{
    if (_keywordImgView.image) {
        _keywordImgView.image = nil;
    }
    
    UIImage * image = [UIImage imageNamed:imgName];
    float width = image.size.width * 0.3f;
    float height = image.size.height * 0.3f;
    
    _imgViewFrame = CGRectMake((CGRectGetWidth(self.frame) - width) / 2, (CGRectGetHeight(self.frame) - height) / 2, width, height);
    _keywordImgView.frame = _imgViewFrame;
    _keywordImgView.image = image;
    _keywordImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_keywordImgView];
    
}

- (int)genertateRandomNumberStartNum:(int)startNum endNum:(int)endNum
{
    int x = (int)(startNum + (arc4random() % (endNum - startNum + 1)));
//    NSLog(@"x:%d",x);
    return x;
}

- (void)startAnimation
{
    _isContinue = YES;
    int x =  [self genertateRandomNumberStartNum:1 endNum:100];
    if (x % 2 == 0) {
        [self moveToLeft];
    }else{
        [self moveToRight];
    }
}


- (void)startReplaceCurView
{
    int x =  [self genertateRandomNumberStartNum:8 endNum:30];
    [self performSelector:@selector(doDelegate) withObject:nil afterDelay:x];
}

- (void)doDelegate
{
    if ([_delegate respondsToSelector:@selector(startReplaceOtherKeyworkd:curIndex:)]) {
        [_delegate startReplaceOtherKeyworkd:self curIndex:self.tag];
    }
}

- (void)stopReplaceCurView
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(doDelegate) object:nil];
}

- (void)stopAnimation
{
    _isContinue = NO;
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(startReplace) object:nil];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveToRight) object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveToLeft) object:nil];
}

- (void)moveToLeft
{
    NSLog(@"__FUNCTION__:%s  __LINE__:%d ",__FUNCTION__,__LINE__);
    int x =  [self genertateRandomNumberStartNum:7 endNum:11];
    
    int y = 1;
    if (self.tag == 2 || self.tag == 3) {
        y =  [self genertateRandomNumberStartNum:6 endNum:9];
    }else{
        y =  [self genertateRandomNumberStartNum:7 endNum:11];
    }
    
    
    [UIView animateWithDuration:x animations:^{
        if (_isContinue) {
            CGRect frame = _keywordImgView.frame;
            frame.origin.x = 0;
            _keywordImgView.frame = frame;
            _keywordImgView.transform = CGAffineTransformMakeScale(y * 1.0f/ 10.0f, y * 1.0f/ 10.0f);
        }
    }];
    [self performSelector:@selector(moveToRight) withObject:nil afterDelay:x];
    
}

- (void)moveToRight
{
    NSLog(@"__FUNCTION__:%s  __LINE__:%d ",__FUNCTION__,__LINE__);
    int x =  [self genertateRandomNumberStartNum:7 endNum:11];
    int y = 1;
    if (self.tag == 2 || self.tag == 3) {
        y =  [self genertateRandomNumberStartNum:6 endNum:9];
    }else{
        y =  [self genertateRandomNumberStartNum:7 endNum:11];
    }
    
    [UIView animateWithDuration:x animations:^{
        if (_isContinue) {
            CGRect frame = _keywordImgView.frame;
            frame.origin.x = CGRectGetWidth(self.frame) - CGRectGetWidth(_keywordImgView.frame);
            _keywordImgView.frame = frame;
            _keywordImgView.transform = CGAffineTransformMakeScale(y * 1.0f/ 10.0f, y * 1.0f/ 10.0f);
        }
    }];
    [self performSelector:@selector(moveToLeft) withObject:nil afterDelay:x];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
