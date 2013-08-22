//
//  CustomPageControl.h
//  RuidengWallPaper
//
//  Created by binfo on 12-7-9.
 //

#import <UIKit/UIKit.h>
#define  HORIZ_SWIPE_DRAG_MIN  16
#define  VERT_SWIPE_DRAG_MAX 16
@interface CustomPageControl : UIPageControl
{
    UIImage *imagePageStateNormal;
    UIImage *imagePageStateHighlighted;
    CGPoint startTouchPosition;
}

- (id)initWithFrame:(CGRect)frame;
- (void)updateDots;
@property (nonatomic, retain) UIImage*imagePageStateNormal;
@property (nonatomic, retain) UIImage*imagePageStateHighlighted;
@end
