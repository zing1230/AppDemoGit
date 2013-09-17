//
//  CustomCollectionBtn.h
//  AppDemo
//
//  Created by Sidney on 13-9-13.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCollectionBtnDelegate;


@interface CustomCollectionBtn : UIButton
{
    CGPoint beginPoint;
    
}

@property(nonatomic,assign)BOOL dragEnable;
@property(nonatomic,assign)id <CustomCollectionBtnDelegate> delegate;
@end

@protocol CustomCollectionBtnDelegate <NSObject>
@optional

- (void)collectionBtnMoving:(CGPoint)center collectionBtn:(CustomCollectionBtn *)btn;
- (void)collectionBtnMoveEnd:(CGPoint)center collectionBtn:(CustomCollectionBtn *)btn;


@end
