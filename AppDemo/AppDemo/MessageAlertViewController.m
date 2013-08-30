//
//  MessageAlertViewController.m
//  AppDemo
//
//  Created by issuser on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "MessageAlertViewController.h"

@interface MessageAlertViewController ()

@end

@implementation MessageAlertViewController

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
    [self setTitle:@"消息提醒"];
    
    
    self.bgScrollView.frame = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT);
    
    self.bgImgView.frame = CGRectMake(0, 0, 320, 512);
    self.bgImgView.image = [UIImage imageNamed:@"msg_alert_bg.png"];
    
    [self.bgScrollView addSubview:self.bgImgView];
    [self.bgScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 512)];
    [self.view addSubview:self.bgScrollView];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
