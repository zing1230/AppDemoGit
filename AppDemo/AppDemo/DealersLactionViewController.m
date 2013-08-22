//
//  DealersLactionViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-10.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "DealersLactionViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CustomPageControl.h"
@interface DealersLactionViewController ()
<MKMapViewDelegate>
{
    CustomPageControl *m_pageControl;
    
}

@property(nonatomic,strong)UIView * dealersSubView;
@end
static MKMapView * mapView;

@implementation DealersLactionViewController

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
    [self setTitle:@"经销商"];
    
    mapView = [[MKMapView alloc] initWithFrame:self.childFrame];
//    mapView.delegate = self;
    [mapView setShowsUserLocation:YES];
    mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:mapView];
    
    [self initDealersView];
}


//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    NSLog(@"%s %d", __FUNCTION__, __LINE__);
//    CLLocationCoordinate2D coordinate = mapView.userLocation.coordinate;
//    [mapView setCenterCoordinate:coordinate];
//    [mapView setRegion:MKCoordinateRegionMake(coordinate,MKCoordinateSpanMake(0.1f,0.1f)) animated:YES];
//}


- (void)initDealersView
{
    _dealersSubView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, SCREEN_WIDTH, CGRectGetHeight(self.childFrame))];
    [self.view addSubview:_dealersSubView];
    [self.view bringSubviewToFront:self.navImgView];
    _dealersSubView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView * bgimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 851/2)];
    bgimgview.image = [UIImage imageNamed:@"dealers_bg.png"];
    [_dealersSubView addSubview:bgimgview];
    

    UIButton * openBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50) /2, CGRectGetHeight(self.childFrame) - 70, 50, 50)];
    [openBtn setBackgroundImage:[UIImage imageNamed:@"image_open_btn.png"] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    openBtn.transform = CGAffineTransformMakeRotation(M_PI);

    [_dealersSubView addSubview:openBtn];
    
    
    UIImageView * bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 566/2)];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.image = [UIImage imageNamed:@"dealers_2.png"];
    [_dealersSubView addSubview:bgImgView];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(260, 80, 50, 50)];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:btn];
    
    
    m_pageControl =[[CustomPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300) / 2, CGRectGetHeight(_dealersSubView.frame) - 130, 300, 60)];
    m_pageControl.backgroundColor = [UIColor clearColor];
    m_pageControl.currentPage = 0;
//    [m_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    m_pageControl.hidesForSinglePage = YES;
    m_pageControl.numberOfPages = 2;
    
    [m_pageControl setImagePageStateNormal:[UIImage imageNamed:@"image_point_normal.png"]];
    [m_pageControl setImagePageStateHighlighted:[UIImage imageNamed:@"image_point_selected.png"]];
    [_dealersSubView addSubview:m_pageControl];

    
    
}
- (void)btnPressed:(UIButton *)sender
{
    UIImageView * imgView = (UIImageView *)sender.superview;
    
    CGRect frame = imgView.frame;
    if (!sender.selected) {
        imgView.image = [UIImage imageNamed:@"dealers_1.png"];
        frame.origin.y -= .5f;
        frame.size.height = 627/2;
        
    }else{
        imgView.image = [UIImage imageNamed:@"dealers_2.png"];
        frame.origin.y += .5f;
        frame.size.height = 566/2;
    }
    imgView.frame = frame;
    
    sender.selected = !sender.selected;
    
}

- (void)openBtnPressed:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.6f animations:^{
        CGRect frame = _dealersSubView.frame;
        
        if (!sender.selected) {
            frame.origin.y = NAV_BAR_HEIGHT;
            _dealersSubView.frame = frame;
            sender.transform = CGAffineTransformMakeRotation(0);
            
        }else{
            frame.origin.y = -300;
            _dealersSubView.frame = frame;
            sender.transform = CGAffineTransformMakeRotation(M_PI);
            
        }
        
    } completion:^(BOOL finished) {
    }];
    
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
