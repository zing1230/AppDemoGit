//
//  SecondLevelViewController.m
//  AppDemo
//
//  Created by sun pan on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "SecondLevelViewController.h"

@interface SecondLevelViewController ()

@end

@implementation SecondLevelViewController
@synthesize titleLabel;
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
    self.isLandscape = NO;
    _childFrame = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT);

    _navImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT)];
    _navImgView.userInteractionEnabled = YES;
    _navImgView.backgroundColor = RGBACOLOR(224,47,62,1);
    [self.view addSubview:_navImgView];
    
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(7, 4, 54, 25)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"image_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_navImgView addSubview:backBtn];

    _homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 8, 16, 18)];
    [_homeBtn setBackgroundImage:[UIImage imageNamed:@"image_home_btn.png"] forState:UIControlStateNormal];
    [_homeBtn addTarget:self action:@selector(homeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_navImgView addSubview:_homeBtn];

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 2, 170, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = RGBACOLOR(230, 230, 230,.9f);
//    titleLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:18];
        titleLabel.font = [UIFont fontWithName:@"AricLMT" size:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_navImgView addSubview:titleLabel];
    
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bgImgView.backgroundColor = [UIColor clearColor];
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:_childFrame];
    _bgScrollView.backgroundColor = [UIColor clearColor];
}

- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}


- (void)showAlertView:(NSString *)title message:(NSString *)msg
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title
                                                         message:msg
                                                        delegate:nil
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:nil];
    [alertView show];
}

- (void)backBtnPressed:(UIButton *)sender
{
    if (self.isLandscape) {
        [[ConfigData shareInstance] setNeedRotation:YES];
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                           withObject:(id)UIInterfaceOrientationLandscapeLeft];
        }
        [UIViewController attemptRotationToDeviceOrientation];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)homeBtnPressed:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
