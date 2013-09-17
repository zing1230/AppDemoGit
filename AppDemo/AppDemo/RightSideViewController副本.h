//
//  RightSideViewController.h
//  AppDemo
//
//  Created by Sidney on 13-8-7.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTUtils.h"
#import "UIViewController+MMDrawerController.h"
#import "CustomCollectionBtn.h"

@interface RightSideViewController : UIViewController
<UIAlertViewDelegate,CustomCollectionBtnDelegate>
{
    UIButton * willDeleteBtn;
}

@end
