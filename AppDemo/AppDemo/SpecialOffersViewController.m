//
//  SpecialOffersViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-10.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "SpecialOffersViewController.h"

@interface SpecialOffersViewController ()

@end

@implementation SpecialOffersViewController

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
    [self setTitle:@"优惠信息"];
    
    
    self.bgScrollView.frame = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT);
    
    self.bgImgView.frame = CGRectMake(0, 0, 320, 600);
    self.bgImgView.image = [UIImage imageNamed:@"specil_offers_bg.png"];

    [self.bgScrollView addSubview:self.bgImgView];
    [self.bgScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 600)];
    [self.view addSubview:self.bgScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
