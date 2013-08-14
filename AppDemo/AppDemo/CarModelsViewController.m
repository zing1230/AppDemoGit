//
//  CarModelsViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-10.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "CarModelsViewController.h"
#import "CarDetailViewController.h"
#import "ModelDetailViewController.h"

@interface CarModelsViewController ()

@end

@implementation CarModelsViewController

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
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(134, 55, 40, 13)];
    [btn setBackgroundImage:[UIImage imageNamed:@"image_show_type.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    int count = 20;

    self.bgScrollView.frame = CGRectMake(0, 85, SCREEN_WIDTH, SCREEN_HEIGHT - 85);
    [self.view addSubview:self.bgScrollView];
    
    int contenHeight = 0;
    for (int i = 0; i < count; i ++) {
        int col = i % 2;
        int row = i / 2;
        
        UIButton * car = [[UIButton alloc] initWithFrame:CGRectMake(15 + col * 150, row * 140, 140, 125)];
        [car setBackgroundImage:[UIImage imageNamed:@"image_car.png"] forState:UIControlStateNormal];
        [car addTarget:self action:@selector(carPressed:) forControlEvents:UIControlEventTouchUpInside];

        [self.bgScrollView addSubview:car];
        contenHeight = CGRectGetMaxY(car.frame);
    }
    [self.bgScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, contenHeight + 10)];
}

- (void)carPressed:(UIButton *)btn
{
//    CarDetailViewController * detail = [[CarDetailViewController alloc] init];
    
    
    ModelDetailViewController * detail = [[ModelDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)btnPressed:(UIButton *)btn
{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
