//
//  CustomKeywordCellView.m
//  iLearning
//
//  Created by Sidney on 13-8-12.
//  Copyright (c) 2013年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import "CustomKeywordCellView.h"

@implementation Keyword



@end


@interface CustomKeywordCellView()

@property(nonatomic,assign)CGRect imgViewFrame;
@property(nonatomic,strong)NSTimer *timer;

@end

static float interval = 0.1f;

@implementation CustomKeywordCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _keywordImgView = [[Keyword alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)taped:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(keywordViewTaped:)]) {
        [_delegate keywordViewTaped:tap];
    }
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
    
    if (self.tag % 2 == 0) {
        _keywordImgView.offsetX = 0.5f;
        _keywordImgView.offsetY = 0.5f;
    }else{
        _keywordImgView.offsetX = -0.5f;
        _keywordImgView.offsetY = -0.5f;
        
    }
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
//    int x =  [self genertateRandomNumberStartNum:1 endNum:10];
//    if (x % 2 == 0) {
//        [self moveToLeft];
//    }else{
//        [self moveToRight];
//    }
    
    if (_timer) [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(startMove) userInfo:nil repeats:YES];
    [_timer fire];
    if (self.tag != 1) {
        [self startScaleAndChangeAlpha];
    }else{
        _keywordImgView.transform = CGAffineTransformMakeScale(1.3f,1.3f);
    }
}

- (void)stopAnimation
{
    if (_timer) [_timer invalidate];
    
//    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(startReplace) object:nil];
//    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveToRight) object:nil];
//    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveToLeft) object:nil];
}


- (void)startReplaceCurView
{
    int x =  [self genertateRandomNumberStartNum:15 endNum:30];
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

- (void)createWithBlock:(CreatTimeDurationWithAlpha)block
{
    //    NSLog(@"__FUNCTION__:%s  __LINE__:%d ",__FUNCTION__,__LINE__);
    int duration =  [self genertateRandomNumberStartNum:8 endNum:15];
    
    int y = 1;
    float alpha = 0;
    int min,max;
    if (self.tag == 2 || self.tag == 3) {
        min = 6;
        max = 8;
        if (CGRectGetWidth(self.frame) == 85) {
            max = 7;
        }
        y = [self genertateRandomNumberStartNum:min endNum:max];
        
    }else{
        min = 7;
        max = 11;
        if (CGRectGetWidth(self.frame) == 85) {
            max = 10;
        }
        y = [self genertateRandomNumberStartNum:min endNum:max];
    }
    
    if (y > (max + min) * 1.0f / 2.0f) alpha = 1.0f;
    else alpha = 0.5f;
    
    block(duration,y,alpha);
    return;
}



//- (void)createWithBlock:(CreatTimeDurationWithAlpha)block
//{
//    int duration =  [self genertateRandomNumberStartNum:8 endNum:20];
//    
//    int y = 1;
//    float alpha = 0;
//    
//    if ((CGRectGetWidth(self.frame) == 85 && self.tag == 2) || (CGRectGetWidth(self.frame) == 85 &&self.tag == 3))
//    {
//        y = 5;
//    }else if(CGRectGetWidth(self.frame) == 85){
//        y = 7;
//    }else{
//        y = [self genertateRandomNumberStartNum:6 endNum:8];
//    }
//    
//    int temp = [self genertateRandomNumberStartNum:7 endNum:12];
//    
//    if (temp > 10) alpha = 1.0f;
//    else alpha = temp * 1.0 / 10.0f;
//    
//    block(duration,y,alpha);
//    return;
//}

- (void)moveToLeft
{
    [self createWithBlock:^(NSTimeInterval duration, int y, float alpha) {
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = _keywordImgView.frame;
            frame.origin.x = 0;
            _keywordImgView.frame = frame;
            _keywordImgView.alpha = alpha;
            _keywordImgView.transform = CGAffineTransformMakeScale(y * 1.0f/ 10.0f, y * 1.0f/ 10.0f);
        }];
        [self performSelector:@selector(moveToRight) withObject:nil afterDelay:duration];
    }];
}

- (void)moveToRight
{
    [self createWithBlock:^(NSTimeInterval duration, int y, float alpha) {
        
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = _keywordImgView.frame;
            frame.origin.x = CGRectGetWidth(self.frame) - CGRectGetWidth(_keywordImgView.frame);
            _keywordImgView.frame = frame;
            _keywordImgView.alpha = alpha;
            _keywordImgView.transform = CGAffineTransformMakeScale(y * 1.0f/ 10.0f, y * 1.0f/ 10.0f);
        }];
        [self performSelector:@selector(moveToLeft) withObject:nil afterDelay:duration];
    }];
}


- (void)startScaleAndChangeAlpha
{
    [self createWithBlock:^(NSTimeInterval duration, int y, float alpha) {
        NSLog(@"duration:%f   alpha:%.2f . y:%d",duration,alpha,y);
        [UIView animateWithDuration:duration animations:^{
            _keywordImgView.alpha = alpha;
            _keywordImgView.transform = CGAffineTransformMakeScale((y * 1.0f)/ 10.0f, (y * 1.0f)/ 10.0f);
        }];
    }];
    
}

- (void)startMove
{
    [UIView animateWithDuration:interval animations:^{
        CGRect frame = _keywordImgView.frame;
        float offsetx = _keywordImgView.offsetX;
        float offsety = _keywordImgView.offsetY;
        frame.origin.x += offsetx;
        frame.origin.y += offsety;
        
        if (frame.origin.x + CGRectGetWidth(_keywordImgView.frame) > CGRectGetWidth(self.frame) || frame.origin.x <= 0) {
            _keywordImgView.offsetX = -offsetx;
        }
        
        if (frame.origin.y + CGRectGetHeight(_keywordImgView.frame) > CGRectGetHeight(self.frame) || frame.origin.y <= 0) {
            _keywordImgView.offsetY = -offsety;
        }
        _keywordImgView.frame = frame;
    }];
}


@end
