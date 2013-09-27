//
//  ModelDetailViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-13.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "ModelDetailViewController.h"
#import "SpecialOffersViewController.h"
#import "Show360ViewController.h"
#import "CalculatorViewController.h"
#import "TestDrivingViewController.h"
#import "BookingCarViewController.h"
#import "SpecialOffersViewController.h"
#import "CarDetailViewController.h"


@interface ModelDetailViewController ()
{
    MPMoviePlayerController * moviePlayer;

}
@end

@implementation ModelDetailViewController

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
        [self setTitle:@"车型展厅"];
    
    int originX = 15;
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, 107)];
    imgView.image = [UIImage imageNamed:@"image_car_bg.png"];
    [self.view addSubview:imgView];
    
    
    UIButton * carNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX, 150, 49, 23)];
    [carNameBtn setBackgroundImage:[UIImage imageNamed:@"image_carName.png"] forState:UIControlStateNormal];
    [carNameBtn setBackgroundColor:[UIColor clearColor]];
//    [carNameBtn addTarget:self action:@selector(carNameBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carNameBtn];
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 190, 78, 16)];
    imgView.image = [UIImage imageNamed:@"tianlai_2-3.png"];
    [self.view addSubview:imgView];

    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(185, 150, 108, 20)];
    imgView.image = [UIImage imageNamed:@"tianlai_2-4.png"];
    [self.view addSubview:imgView];

    
    for (int i = 0; i < 3; i ++) {
        UIButton * menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(180 + 40 * i, 180, 28, 28)];
        NSString * imgName = [NSString stringWithFormat:@"tianlai_icon_%d.png",i];
        [menuBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuBtn];
    }
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(originX, 223, SCREEN_WIDTH - originX * 2, 2)];
    line.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(originX, 333, SCREEN_WIDTH - originX * 2, 1.5)];
    line.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(originX, 402, SCREEN_WIDTH - originX * 2, 2)];
    line.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:line];
    
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(originX, 228, SCREEN_WIDTH - originX * 2, 100)];
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    int contentWidth = 0;
    for (int i = 0; i < 3; i ++) {
        UIButton * functionBtn = [[UIButton alloc] initWithFrame:CGRectMake(2 + 100 * i, 4, 95, 95)];
        NSString * imgName = [NSString stringWithFormat:@"tianlai_%d.png",i];
        [functionBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        functionBtn.tag = i;
        [functionBtn addTarget:self action:@selector(functionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:functionBtn];
        contentWidth = CGRectGetMaxX(functionBtn.frame);
    }
    scrollView.contentSize = CGSizeMake(contentWidth + 4, 100);
    
    
    for (int i = 0; i < 3; i ++) {
        UIButton * menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX + 120 * i, 345, 46, 46)];
        NSString * imgName = [NSString stringWithFormat:@"tianlai_2_1_%d.png",i + 1];
        [menuBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menu_BtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuBtn];
    }
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, 415, 130, 30)];
    label.text = @"喜欢这辆车?";
    label.font = [UIFont systemFontOfSize:21];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    
    for (int i = 0; i < 2; i ++) {
        UIButton * menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(205 + 50 * i, 413, 37, 37)];
        NSString * imgName = [NSString stringWithFormat:@"tianlai_2_2_%d.png",i + 1];
        [menuBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnsPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuBtn];
    }
    
}

- (void)functionBtnPressed:(UIButton *)btn
{
    int index = btn.tag;
    switch (index) {
        case 0:
        {
            CarDetailViewController * carDetail = [[CarDetailViewController alloc] init];
            [self.navigationController pushViewController:carDetail animated:YES];
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            NSString * path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:@"mov_bbb.mp4"];
            NSURL * mediaURL = [[NSURL alloc]initFileURLWithPath:path];
            
            if (!moviePlayer) {
                moviePlayer = [[MPMoviePlayerController alloc] init];
                moviePlayer.view.frame = CGRectMake(0,-20, SCREEN_WIDTH, SCREEN_HEIGHT + 20);
                moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
                [moviePlayer setFullscreen:YES];
            }
            [moviePlayer setContentURL:mediaURL];
            [moviePlayer play];
            
            [self.view addSubview:moviePlayer.view];
            [self addEventListener];

        }
            break;
        default:
            break;
    }
    
}

- (void)addEventListener
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultSetUpdateComplete:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultSetUpdateComplete:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultSetUpdateComplete:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
}

- (void)resultSetUpdateComplete:(NSNotification *)notif
{
//    NSString *object = [notif object];
    NSString *eventName = [notif name];
    if (eventName == nil)
        return;
    if ([eventName isEqualToString:MPMoviePlayerPlaybackDidFinishNotification]) {
        [moviePlayer stop];
        [moviePlayer.view removeFromSuperview];
    }else if([eventName isEqualToString:MPMoviePlayerWillEnterFullscreenNotification]){
        
        
    }else if([eventName isEqualToString:MPMoviePlayerWillExitFullscreenNotification]){

    }
}


- (void)carNameBtnPressed:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)menuBtnsPressed:(UIButton *)sender
{
    int index = sender.tag;
    switch (index) {
        case 0:
        {
            TestDrivingViewController * testDriving = [[TestDrivingViewController alloc] init];
            [self.navigationController pushViewController:testDriving animated:YES];
        }
            break;
        case 1:
        {
            BookingCarViewController * bookingCar = [[BookingCarViewController alloc] init];
            [self.navigationController pushViewController:bookingCar animated:YES];
        }
            break;
    }
}


- (void)menu_BtnPressed:(UIButton *)sender
{
    int index = sender.tag;
    switch (index) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            SpecialOffersViewController * offers = [[SpecialOffersViewController alloc] init];
            [self.navigationController pushViewController:offers animated:YES];
        }
            break;
        case 2:
        {
           
            
        }
            break;
        default:
            break;
    }
    
}


- (void)menuBtnPressed:(UIButton *)sender
{
    int index = sender.tag;
    switch (index) {
        case 1:
        {
//            return;
            [[ConfigData shareInstance] setNeedRotation:YES];
            if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
                [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                               withObject:(id)UIInterfaceOrientationLandscapeLeft];
            }
            [UIViewController attemptRotationToDeviceOrientation];
            
            Show360ViewController * show360 = [[Show360ViewController alloc] init];
            [self.navigationController pushViewController:show360 animated:YES];
            
        }
            break;
        case 2:
        {
            CalculatorViewController * calculator = [[CalculatorViewController alloc] init];
            [self.navigationController pushViewController:calculator animated:YES];
            
        }
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
