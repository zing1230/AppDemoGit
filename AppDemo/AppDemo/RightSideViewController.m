//
//  RightSideViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-7.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "RightSideViewController.h"

@interface RightSideViewController ()
{
    UIScrollView * scrollView;
    NSMutableArray * allBtns;
}
@end

@implementation RightSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(65,65,65,1);
    self.mm_drawerController.shouldStretchDrawer = NO;
    
    allBtns = [[NSMutableArray alloc] init];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 116, SCREEN_HEIGHT)];
    [self.view addSubview:scrollView];
    
    float offsetY = 92;
    __block float contentHeight = 0;
    for (int i = 0; i < 10; i ++) {
        int j = i % 5;
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, offsetY * i, 116, offsetY)];
        btn.tag = i;
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"image_%d.png",j + 1]];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * closebtn = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, 20, 20)];
        closebtn.tag = 999;
        [closebtn addTarget:self action:@selector(closeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [closebtn setBackgroundImage:[UIImage imageNamed:@"image_close"] forState:UIControlStateNormal];
        [btn addSubview:closebtn];
        closebtn.hidden = YES;
        
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 1.0f;
        [btn addGestureRecognizer:longPress];
        
        [scrollView addSubview:btn];
        [allBtns addObject:btn];
        contentHeight = CGRectGetMaxY(btn.frame);
    }
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), contentHeight);
}

- (void)longPress:(UILongPressGestureRecognizer *)press
{
    for (int i = 0; i < [allBtns count]; i ++) {
        UIButton * closebtn = (UIButton *)[[allBtns objectAtIndex:i] viewWithTag:999];
        closebtn.hidden = NO;
    }
    
    
    //    for (int i = 0; i < [allBtns count]; i ++) {
    //         UIButton * btn = [allBtns objectAtIndex:i];
    //            [UIView animateWithDuration:0.1f
    //                              delay:0.1f * i
    //                            options:UIViewAnimationOptionTransitionFlipFromLeft
    //                         animations:^{
    //                             btn.transform = CGAffineTransformMakeScale(0.85f, 0.85f);
    //                         }completion:^(BOOL finished) {
    //
    //                         }];
    //
    //    }
    
}

- (void)btnPressed:(UIButton *)sender
{
    
    for (int i = 0; i < [allBtns count]; i ++) {
        UIButton * closebtn = (UIButton *)[[allBtns objectAtIndex:i] viewWithTag:999];
        closebtn.hidden = YES;
    }
    
//    for (int i = 0; i < [allBtns count]; i ++) {
//        UIButton * btn = [allBtns objectAtIndex:i];
//        [UIView animateWithDuration:0.1f
//                              delay:0.1f * i
//                            options:UIViewAnimationOptionTransitionFlipFromLeft
//                         animations:^{
//                             btn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
//                         }completion:^(BOOL finished) {
//                             
//                         }];
//        
//    }
}

- (void)closeBtnPressed:(UIButton *)sender
{
    UIButton * superViewBtn = (UIButton *)[sender superview];
    [superViewBtn removeFromSuperview];
    [allBtns removeObjectAtIndex:superViewBtn.tag];
    
    float offsetY = 92;
    __block float contentHeight = 0;
    for (int i = 0; i < [allBtns count]; i ++) {
        UIButton * btn = [allBtns objectAtIndex:i];
        [UIView animateWithDuration:0.3f
                              delay:0
                            options:UIViewAnimationOptionTransitionFlipFromLeft
                         animations:^{
                             btn.tag = i;
                             btn.frame = CGRectMake(0, offsetY * i, 116, offsetY);
                             contentHeight = CGRectGetMaxY(btn.frame);
                         }completion:^(BOOL finished) {
                             
                         }];
        
    }
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), contentHeight);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
