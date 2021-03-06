//
//  CustomSpeakerView.m
//  AppDemo
//
//  Created by Sidney on 13-8-10.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "CustomSpeakerView.h"

@interface CustomSpeakerView()
{
    CGPoint startPoint;
}
@property (nonatomic,strong) UIImageView * spearkImgView;

@end

@implementation CustomSpeakerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _spearkImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _spearkImgView.image = [UIImage imageNamed:@"image_recongnizer.png"];
        _spearkImgView.userInteractionEnabled = YES;
        [self addSubview:_spearkImgView];
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, 130, 30)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textColor = [UIColor darkGrayColor];
        _tipLabel.text = @"点按并说出您的需求";
        _tipLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_tipLabel];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self popIn:.4 delegate:nil];
    UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:self];
    NSLog(@"startY-----------------------:%.0f",startPoint.y);

    if ([_delegate respondsToSelector:@selector(touchBegan:)]) {
        [_delegate touchBegan:self];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
       _tipLabel.text = @"点按并说出您的需求";
    if ([_delegate respondsToSelector:@selector(touchEnded:)]) {
        [_delegate touchEnded:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
        NSLog(@"touchesMoved");
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    float offsetX =  startPoint.x - point.x;
    float offsetY = startPoint.y - point.y;

//    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
//    NSLog(@"endY___________________:%.0f",self.center.x);

//    NSLog(@"offsetY:%.0f",offsetY);
    if (offsetY > 5) {
        NSLog(@"touchesMoved");
            _tipLabel.text = @"点按并说出您的需求";
        if ([_delegate respondsToSelector:@selector(touchMoved:)]) {
            [_delegate touchMoved:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
            NSLog(@"touchesCancelled");
    _tipLabel.text = @"点按并说出您的需求";
    if ([_delegate respondsToSelector:@selector(touchCanceled:)]) {
        [_delegate touchCanceled:self];
    }
    
}




@end
