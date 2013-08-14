//
//  Show360ViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-14.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "Show360ViewController.h"
#import "RNExpandingButtonBar.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.navImgView.frame;
    frame.size.width = 480;
    self.navImgView.frame = frame;
    
    CGRect tframe = self.homeBtn.frame;
    tframe.origin.x = 450;
    self.homeBtn.frame = tframe;
    
    
    self.bgImgView.frame = CGRectMake(0, 0, 480, 285);
    self.bgImgView.image = [UIImage imageNamed:@"car_360.png"];
    [self.view addSubview:self.bgImgView];
    [self initMenuBtns];
    
}

- (void)initMenuBtns
{
    CGRect frame = CGRectMake(0, 0, 35.0f, 35.0f);
    
    NSMutableArray * btns = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:frame];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_1_%d.png",i + 1]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:btn];
    }
    
    _expandingBar = [[RNExpandingButtonBar alloc] initWithImage:[UIImage imageNamed:@"iamge_open_btn.png"] selectedImage:nil toggledImage:[UIImage imageNamed:@"image_close_btn.png"] toggledSelectedImage:nil buttons:btns center:CGPointMake(20.0f, 260.0f)];
    [_expandingBar setDelegate:self];
    [_expandingBar setSpin:YES];
    [_expandingBar setHorizontal:YES];
    [_expandingBar setExplode:YES];
    [self.view addSubview:_expandingBar];
    
}

- (void)btnPressed:(UIButton *)sender
{
    int index = sender.tag;
    NSLog(@"index:%d",index);
    [_expandingBar hideButtonsAnimated:YES];
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
