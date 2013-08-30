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
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 116, SCREEN_HEIGHT)];
    [self.view addSubview:scrollView];
    
    float offsetY = 92;
    float contentHeight = 0;
    for (int i = 0; i < 10; i ++) {
        int j = i % 5;
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, offsetY * i, 116, offsetY)];
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"image_%d.png",j + 1]];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [scrollView addSubview:btn];
        contentHeight = CGRectGetMaxY(btn.frame);
    }
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), contentHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
