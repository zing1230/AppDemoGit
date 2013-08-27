//
//  RootViewController.h
//  AppDemo
//
//  Created by sun pan on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "MessageAlertViewController.h"
#import "TestDrivingViewController.h"
#import "BookingCarViewController.h"
#import "DealersLactionViewController.h"
#import "CalculatorViewController.h"
#import "CarModelsViewController.h"
#import "SpecialOffersViewController.h"

#import "iFlyMSC.h"
#import "UIViewController+MMDrawerController.h"
#import "FTAnimation.h"
#import "QuadCurveMenu.h"
#import "CustomSpeakerView.h"
#import "CustomInputTextView.h"
#import "CustomKeywordView.h"



@interface RootViewController : UIViewController
<iFlyMSCDelegate,QuadCurveMenuDelegate,
CustomSpeakerViewDelegate,InputTextViewDelegate,
CustomKeywordViewDelegate>


@property(nonatomic,strong) iFlyMSC * _iflyMSC;
@property(nonatomic,strong) UIImageView * viewToAnimate;
@end
