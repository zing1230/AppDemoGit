//
//  BookingCarViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-10.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "BookingCarViewController.h"

@interface BookingCarViewController ()

@end

@implementation BookingCarViewController

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
    [self setTitle:@"在线订车"];
    
    
    self.bgImgView.frame = CGRectMake(0, SCREEN_HEIGHT - 425, 320, 425);
    self.bgImgView.image = [UIImage imageNamed:@"booking_car_bg.png"];
    [self.view addSubview:self.bgImgView];

    
    UIButton * commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(135, 395, 49, 49)];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"image_commit_btn.png"] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    
    
}

- (void)commitBtnPressed:(id)sender
{
    UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"确定提交?"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alerView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
