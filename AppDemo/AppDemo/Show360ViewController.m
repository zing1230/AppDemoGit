//
//  Show360ViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-14.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "Show360ViewController.h"
#import "RNExpandingButtonBar.h"
#import "TestDrivingViewController.h"
#import "BookingCarViewController.h"
#import "CalculatorViewController.h"
#import "DealersLactionViewController.h"
#import "UIViewController+MMDrawerController.h"


@interface Show360ViewController ()
<RNExpandingButtonBarDelegate>
@property(nonatomic,strong)RNExpandingButtonBar * expandingBar;


@end

@implementation Show360ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    CGRect frame = self.titleLabel.frame;
    frame.origin.x = 40;
    frame.size.width = 400;
    self.titleLabel.frame = frame;
    
    [self setTitle:@"360度鉴赏"];
    
    frame = self.navImgView.frame;
    frame.size.width = 480;
    self.navImgView.frame = frame;
    
    CGRect tframe = self.homeBtn.frame;
    tframe.origin.x = 450;
    self.homeBtn.frame = tframe;
    
    
    self.bgImgView.frame = CGRectMake(0, 0, 480, 285);
    self.bgImgView.image = [UIImage imageNamed:@"car_360.png"];
    [self.view addSubview:self.bgImgView];
    [self initMenuBtns];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(105, 75, 20.0f, 20.0f)];
    [btn setImage:[UIImage imageNamed:@"iamge_open_btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn];

    btn = [[UIButton alloc] initWithFrame:CGRectMake(260, 190, 20.0f, 20.0f)];
    [btn setImage:[UIImage imageNamed:@"iamge_open_btn.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(floatBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)floatBtnPressed:(UIButton *)btn
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 300)];
    backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(floatingViewtaped:)];
    [backView addGestureRecognizer:tap];
    
    UIImage * image = [UIImage imageNamed:@"image_floating_bg.png"];
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake((480 - 546/2) / 2, (300 - 538/2) / 2 + 22, 546/2 - 10, 538/2 - 10)];
    imgView.image = image;
    [backView addSubview:imgView];
    
    [self.view addSubview:backView];
}

- (void)floatingViewtaped:(UITapGestureRecognizer *)tap
{
    [[tap view] removeFromSuperview];
}

- (void)initMenuBtns
{
    
//    NSMutableArray * btns = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i ++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(40 + 50 * i, 250, 35.0f, 35.0f)];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_1_%d.png",i + 1]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [btns addObject:btn];
        [self.view addSubview:btn];
    }
    
//    _expandingBar = [[RNExpandingButtonBar alloc] initWithImage:[UIImage imageNamed:@"iamge_open_btn.png"] selectedImage:nil toggledImage:[UIImage imageNamed:@"image_close_btn.png"] toggledSelectedImage:nil buttons:btns center:CGPointMake(20.0f, 260.0f)];
//    [_expandingBar setDelegate:self];
//    [_expandingBar setSpin:YES];
//    [_expandingBar setHorizontal:YES];
//    [_expandingBar setExplode:YES];
//    [self.view addSubview:_expandingBar];
}


- (void)btnPressed:(UIButton *)sender
{
    int index = sender.tag;
    NSLog(@"index:%d",index);
//    [_expandingBar hideButtonsAnimated:YES];
    
    [[ConfigData shareInstance] setNeedRotation:NO];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                       withObject:(id)UIInterfaceOrientationPortrait];
    }
    [UIViewController attemptRotationToDeviceOrientation];

    
    switch (index) {
        case 0:
        {
            TestDrivingViewController * testDriving = [[TestDrivingViewController alloc] init];
            [self.navigationController pushViewController:testDriving animated:YES];
            testDriving.isLandscape = YES;
        }
            break;
        case 1:
        {
            
            BookingCarViewController * bookingCar = [[BookingCarViewController alloc] init];
            [self.navigationController pushViewController:bookingCar animated:YES];
            bookingCar.isLandscape = YES;
        }
            break;
        case 2:
        {
            CalculatorViewController * calcutor = [[CalculatorViewController alloc] init];
            [self.navigationController pushViewController:calcutor animated:YES];
            calcutor.isLandscape = YES;
        }
            break;
        case 3:
        {
            DealersLactionViewController * dealersLoction = [[DealersLactionViewController alloc] init];
            [self.navigationController pushViewController:dealersLoction animated:YES];
            dealersLoction.isLandscape = YES;
        }
            break;
        default:
            break;
    }
    
}

- (void)homeBtnPressed:(UIButton *)sender
{
    [[ConfigData shareInstance] setNeedRotation:NO];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                       withObject:(id)UIDeviceOrientationPortrait];
    }
    [UIViewController attemptRotationToDeviceOrientation];
    [super homeBtnPressed:sender];
}

- (void)backBtnPressed:(UIButton *)sender
{
    [[ConfigData shareInstance] setNeedRotation:NO];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                       withObject:(id)UIDeviceOrientationPortrait];
    }
    
    [UIViewController attemptRotationToDeviceOrientation];
    [super backBtnPressed:sender];
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
