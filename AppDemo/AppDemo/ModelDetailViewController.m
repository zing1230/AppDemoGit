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


@interface ModelDetailViewController ()

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
    int offsetY = 0;
    
    int originX = 15;
    
    UIButton * carNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX, 140, 85, 35)];
    //    [carNameBtn setBackgroundImage:<#(UIImage *)#> forState:<#(UIControlState)#>];
    [carNameBtn setBackgroundColor:[UIColor redColor]];
    [carNameBtn addTarget:self action:@selector(carNameBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carNameBtn];
    
    
    for (int i = 0; i < 3; i ++) {
        UIButton * menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(190 + 40 * i, 170, 34, 34)];
        NSString * imgName = [NSString stringWithFormat:@"icon_%d.png",i + 1];
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
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    int contentWidth = 0;
    for (int i = 0; i < 4; i ++) {
        UIButton * functionBtn = [[UIButton alloc] initWithFrame:CGRectMake(2 + 100 * i, 4, 95, 95)];
        //        NSString * imgName = [NSString stringWithFormat:@"icon_%d.png",i + 1];
        NSString * imgName = @"image_car.png";
        [functionBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        functionBtn.tag = i;
        [functionBtn addTarget:self action:@selector(functionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:functionBtn];
        contentWidth = CGRectGetMaxX(functionBtn.frame);
    }
    scrollView.contentSize = CGSizeMake(contentWidth + 4, 100);
    
    
    for (int i = 0; i < 3; i ++) {
        UIButton * menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX + 120 * i, 343, 50, 50)];
        NSString * imgName = [NSString stringWithFormat:@"icon_%d.png",i + 1];
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
        UIButton * menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(205 + 60 * i, 413, 40, 40)];
        NSString * imgName = [NSString stringWithFormat:@"icon_%d.png",i + 1];
        [menuBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnsPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuBtn];
    }
    
}

- (void)functionBtnPressed:(UIButton *)btn
{
    
}


- (void)carNameBtnPressed:(UIButton *)btn
{
    
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
            //         SpecialOffersViewController * specialOffersViewCtrller = [[SpecialOffersViewController alloc] init];
            //            [self.navigationController pushViewController:specialOffersViewCtrller animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
