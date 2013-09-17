//
//  CustomCollectionBtn.m
//  AppDemo
//
//  Created by Sidney on 13-9-13.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "CustomCollectionBtn.h"

@implementation CustomCollectionBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_dragEnable) {
        return;
    }
    
    
    UITouch *touch = [touches anyObject];
    beginPoint = [touch locationInView:self];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    if (!_dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    CGPoint nowPoint = [touch locationInView:self];
    
    float offsetX = 0;
//    float offsetX = nowPoint.x - beginPoint.x;
    float offsetY = nowPoint.y - beginPoint.y;
    NSLog(@"%.1f",offsetY);
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
    [[self superview] bringSubviewToFront:self];
    NSLog(@"self.center:%@",NSStringFromCGPoint(self.center));
    if ([_delegate respondsToSelector:@selector(collectionBtnMoving:collectionBtn:)]) {
        [_delegate collectionBtnMoving:CGPointMake(0, CGRectGetMidY(self.frame)) collectionBtn:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(collectionBtnMoveEnd:collectionBtn:)]) {
        [_delegate collectionBtnMoveEnd:self.center collectionBtn:self];
    }

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
