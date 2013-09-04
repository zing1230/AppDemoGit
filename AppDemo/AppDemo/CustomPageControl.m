//
//  CustomPageControl.m
//  RuidengWallPaper
//
//  Created by binfo on 12-7-9.
//  Copyright (c) 2012年 B.H. Tech Co.Ltd. All rights reserved.
//

#import "CustomPageControl.h"
@interface CustomPageControl(private)

//- (void)updateDots;

@end

@implementation CustomPageControl
@synthesize imagePageStateNormal;
@synthesize imagePageStateHighlighted;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImagePageStateNormal:(UIImage*)image {  
    imagePageStateNormal = nil;
    imagePageStateNormal = image;
    [self updateDots];
}

-(void)setImagePageStateHighlighted:(UIImage *)image { 
    imagePageStateHighlighted = nil;
    imagePageStateHighlighted = image;
    [self updateDots];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    startTouchPosition = [touch locationInView:self];
	return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint currentTouchPosition = [touch locationInView:self];
    if (fabsf(startTouchPosition.x - currentTouchPosition.x) >=
        HORIZ_SWIPE_DRAG_MIN &&
        fabsf(startTouchPosition.y - currentTouchPosition.y) <=
        VERT_SWIPE_DRAG_MAX)
    {
		int change = currentTouchPosition.x - startTouchPosition.x ;
        if (change > 0) {
			if (change % 16 == 0) {
				self.currentPage += 1;
				self.currentPage = self.currentPage > (self.numberOfPages -1)  ?  (self.numberOfPages -1) : self.currentPage;
			}
			
        }else{
			if (change % 16 == 0) {
				self.currentPage -=1;
				self.currentPage = self.currentPage < 0 ? 0 : self.currentPage;
			}

		}
	}
	
	[self updateDots];
	return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent *)event { 
    [super endTrackingWithTouch:touch withEvent:event];
    [self updateDots];
}

- (void)updateDots
{ 
    if(imagePageStateNormal || imagePageStateHighlighted)
    {
        NSArray*subview = self.subviews;  
        for(NSInteger i = 0; i < [subview count]; i++)
        {
            UIImageView*dot = [subview objectAtIndex:i];  
			CGPoint imgPos = CGPointMake(dot.frame.origin.x, dot.frame.origin.y);
			CGRect normalFrame = CGRectMake(imgPos.x, imgPos.y, 8, 8);
			CGRect bigFrame = CGRectMake(imgPos.x, imgPos.y, 12, 12);
			dot.image = self.currentPage == i ? imagePageStateHighlighted  : imagePageStateNormal;
			dot.frame = self.currentPage == i ? bigFrame:normalFrame;
        }
    }
}

- (void)dealloc { 
    imagePageStateNormal = nil;
    imagePageStateHighlighted = nil;
}
@end
