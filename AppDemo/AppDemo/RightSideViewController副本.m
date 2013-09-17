//
//  RightSideViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-7.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "RightSideViewController.h"
#define NUM_OF_ROW 5

@interface RightSideViewController ()
{
    UIScrollView * scrollView;
    NSMutableArray * allBtns;
    NSMutableArray * allBtnsFrame;
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
    allBtnsFrame = [[NSMutableArray alloc] init];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 116, SCREEN_HEIGHT)];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    float offsetY = 92;
    __block float contentHeight = 0;
    for (int i = 0; i < 9; i ++) {
        int j = i % NUM_OF_ROW;
        CustomCollectionBtn * btn = [[CustomCollectionBtn alloc] initWithFrame:CGRectMake(0, offsetY * i, 116, offsetY)];
        btn.delegate = self;
        btn.tag = i;
        [allBtnsFrame addObject:NSStringFromCGRect(btn.frame)];
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
    //    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), contentHeight);
    
    int page = [allBtns count] / NUM_OF_ROW;
    if ([allBtns count] % NUM_OF_ROW != 0) {
        page ++;
    }
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), page * SCREEN_HEIGHT);
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    for (int i = 0; i < [allBtns count]; i ++) {
        CustomCollectionBtn * colectionBtn = [allBtns objectAtIndex:i];
        colectionBtn.dragEnable = NO;
        UIButton * closebtn = (UIButton *)[colectionBtn viewWithTag:999];
        closebtn.hidden = YES;
        //        colectionBtn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)press
{
    for (int i = 0; i < [allBtns count]; i ++) {
        CustomCollectionBtn * colectionBtn = [allBtns objectAtIndex:i];
        colectionBtn.dragEnable = YES;
        UIButton * closebtn = (UIButton *)[colectionBtn viewWithTag:999];
        closebtn.hidden = NO;
        //        colectionBtn.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    }
}

- (void)btnPressed:(UIButton *)sender
{
    for (int i = 0; i < [allBtns count]; i ++) {
        CustomCollectionBtn * colectionBtn = [allBtns objectAtIndex:i];
        colectionBtn.dragEnable = NO;
        UIButton * closebtn = (UIButton *)[colectionBtn viewWithTag:999];
        closebtn.hidden = YES;
        //        colectionBtn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }
}

- (void)closeBtnPressed:(UIButton *)sender
{
    if (willDeleteBtn) willDeleteBtn = nil;
    willDeleteBtn = sender;
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil
                                                         message:@"是否删除?"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
    [alertView show];
    
    return;
    
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        CustomCollectionBtn * superViewBtn = (CustomCollectionBtn *)[willDeleteBtn superview];
        [superViewBtn removeFromSuperview];
        
        [allBtns removeObjectAtIndex:superViewBtn.tag];
        [allBtnsFrame removeAllObjects];
        
        float offsetY = 92;
        for (int i = 0; i < [allBtns count]; i ++) {
            CustomCollectionBtn * btn = [allBtns objectAtIndex:i];
            btn.tag = i;
            btn.frame = CGRectMake(0, offsetY * i, 116, offsetY);
            [allBtnsFrame addObject:NSStringFromCGRect(btn.frame)];
        }
        int page = [allBtns count] / NUM_OF_ROW;
        if ([allBtns count] % NUM_OF_ROW != 0) {
            page ++;
        }
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), page * SCREEN_HEIGHT);        
    }
}

#pragma mark CustomCollectionBtnDelegate
- (void)collectionBtnMoving:(CGPoint)center collectionBtn:(CustomCollectionBtn *)btn
{
    if ([allBtns count] > NUM_OF_ROW) {
        int curPage = scrollView.contentOffset.y / SCREEN_HEIGHT;
//        NSLog(@"curPage:%d",curPage);
        int midY = CGRectGetMidY(btn.frame);
        NSLog(@"midY:%d",midY);
        if (midY > SCREEN_HEIGHT) {
            [scrollView setContentOffset:CGPointMake(0, SCREEN_HEIGHT * (curPage + 1)) animated:YES];
        }
    }
    

    
    for (int i = 0; i < [allBtns count]; i ++) {
        CustomCollectionBtn * colectionBtn = [allBtns objectAtIndex:i];
        if (CGRectContainsPoint(colectionBtn.frame,center) && colectionBtn != btn) {
            NSLog(@"colectionBtn.tag:%d",colectionBtn.tag);
            [UIView animateWithDuration:0.01f animations:^{
                colectionBtn.frame = CGRectFromString([allBtnsFrame objectAtIndex:btn.tag]);
            }];
            
            [allBtnsFrame exchangeObjectAtIndex:colectionBtn.tag withObjectAtIndex:btn.tag];
            [allBtns exchangeObjectAtIndex:colectionBtn.tag withObjectAtIndex:btn.tag];

        }
    }
}

- (void)collectionBtnMoveEnd:(CGPoint)center collectionBtn:(CustomCollectionBtn *)btn
{
    [UIView animateWithDuration:0.2f animations:^{
        //        btn.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        //        btn.alpha = 1.0f;
        btn.frame = CGRectFromString([allBtnsFrame objectAtIndex:btn.tag]);
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
