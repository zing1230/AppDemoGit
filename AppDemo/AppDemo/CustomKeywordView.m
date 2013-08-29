//
//  CustomKeywordView.m
//  AppDemo
//
//  Created by Sidney on 13-8-29.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "CustomKeywordView.h"
#import "CustomKeywordCellView.h"

@interface CustomKeywordView()
<CustomKeywordCellViewDelegate>
{
    BOOL animationStoped;
    
    
}
@property (nonatomic,strong) NSMutableArray * allCurShowKeywords;
@property (nonatomic,strong) NSMutableArray * allKeywords;

@end
@implementation CustomKeywordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _allCurShowKeywords = [[NSMutableArray alloc] init];
        _allKeywords = [[NSMutableArray alloc] init];
        
        animationStoped = YES;
        
        [self initKeywordView];
    }
    return self;
}

- (void)initKeywordView
{
    float originY = 0;
    int offsetW = 0;
    for (int i = 0; i < 10; i ++) {
        CustomKeywordCellView * keywordView = [[CustomKeywordCellView alloc] initWithFrame:CGRectMake(15, originY , 100, 50)];
        keywordView.delegate = self;
        keywordView.tag = i;
        keywordView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keywordViewTaped:)];
        [keywordView addGestureRecognizer:tap];
        [_allKeywords addObject:keywordView];
    }
    
    for (int i = 0; i < 5; i ++) {
        
        if (i < 3) {
            offsetW += 30;
        }else {
            offsetW -= 30;
        }
        
        CustomKeywordCellView * keywordView = [_allKeywords objectAtIndex:i];
        keywordView.frame = CGRectMake(15, originY + 46 * i ,  55 + offsetW, 45 + 25);
        [keywordView setImageName:[NSString stringWithFormat:@"keyword_%d.png",i + 1]];
        
        [keywordView startAnimation];
        [keywordView startReplaceCurView];
        
        [self addSubview:keywordView];
        [_allCurShowKeywords addObject:keywordView];
        
        if (i == 1) {
            [self bringSubviewToFront:keywordView];
        }
        NSLog(@"NSStringFromCGRect:%@",NSStringFromCGRect(keywordView.frame));
    }
    [self bringSubviewToFront:[_allCurShowKeywords objectAtIndex:1]];
}

- (void)keywordViewTaped:(UITapGestureRecognizer *)tap
{
    CustomKeywordCellView * keywordCell = (CustomKeywordCellView *)[tap view];
    
    if ([_delegate respondsToSelector:@selector(keywordTaped:keywordView:)])
    {
        [_delegate keywordTaped:keywordCell keywordView:self];
    }
}

#pragma mark CustomKeywordCellViewDelegate
- (void)startReplaceOtherKeyworkd:(CustomKeywordCellView *)view curIndex:(int)index
{
    //    NSLog(@"__FUNCTION__:%s __LINE__:%d index:%d",__FUNCTION__,__LINE__,index);
    if (index != 1) {
        if (!animationStoped) {
            NSLog(@"123123123__________________________");
            [view startReplaceCurView];
            return;
        }
        
        NSMutableArray * data = [[NSMutableArray alloc] init];
        for (CustomKeywordCellView * keyview in _allCurShowKeywords) {
            [data addObject:[NSNumber numberWithInt:keyview.tag]];
        }
        
        int generateIndex = [self genertateRandomNumberStartNum:0 endNum:9 cannotContainsKey:data];
        
        CGRect frame = view.frame;
        int curIndex = [self getCurIndexInArray:view];
        if (curIndex > [_allCurShowKeywords count]) {
            NSLog(@"!curIndex__________________________:%d",curIndex);
            [view startReplaceCurView];
            return;
        }
        
        CustomKeywordCellView * keywordView = [_allKeywords objectAtIndex:generateIndex];
        keywordView.frame = frame;
        
        [keywordView setImageName:[NSString stringWithFormat:@"keyword_%d.png",keywordView.tag + 1]];
        
        keywordView.keywordImgView.alpha = 0;
        
        [self addSubview:keywordView];
        
        [UIView animateWithDuration:1.0f animations:^{
            view.keywordImgView.alpha = 0;
            animationStoped = NO;
        } completion:^(BOOL finished) {
            [view stopAnimation];
            [view removeFromSuperview];
            view.keywordImgView.alpha = 1;
        }];
        
        [self bringSubviewToFront:[_allCurShowKeywords objectAtIndex:1]];
        
        
        [self performSelector:@selector(startAnimation:) withObject:keywordView afterDelay:0.5f];
        
        NSLog(@"__FUNCTION__:%s __LINE__:%d curIndex:%d",__FUNCTION__,__LINE__,curIndex);
        [_allCurShowKeywords replaceObjectAtIndex:curIndex withObject:keywordView];
        NSLog(@"__FUNCTION__:%s __LINE__:%d ",__FUNCTION__,__LINE__);
    }
}

- (void)startAnimation:(CustomKeywordCellView *)keywordView
{
    [UIView animateWithDuration:1.0f animations:^{
        keywordView.keywordImgView.alpha = 1.0f;
        //        [keywordView startAnimation];
    } completion:^(BOOL finished) {
        [keywordView startAnimation];
        [keywordView startReplaceCurView];
        animationStoped = YES;
    }];
}

- (int)getCurIndexInArray:(CustomKeywordCellView *)view
{
    int i = 0;
    for (CustomKeywordCellView * keywordView in _allCurShowKeywords) {
        if (keywordView == view) {
            return i;
        }
        i++;
    }
}

- (int)genertateRandomNumberStartNum:(int)startNum endNum:(int)endNum cannotContainsKey:(NSArray *)contaisKey
{
    if (startNum > endNum) {
        return endNum;
    }
    for (int i = startNum; i < endNum; i ++) {
        int x = (int)(startNum + (arc4random() % (endNum - startNum + 1)));
        NSLog(@"x:%d",x);
        NSNumber * number = [NSNumber numberWithInt:x];
        if (![contaisKey containsObject:number]) {
            return x;
        }else{
            i = i - 1; //发现有重复则-1
        }
    }
    return startNum;
}

- (void)setKeywordViewHiddenStatus:(BOOL)status
{
    if (status) {
        [self slideOutTo:kFTAnimationLeft inView:self.superview duration:0.6f delegate:nil startSelector:nil stopSelector:nil];
        for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
            CustomKeywordCellView * keywordView = [_allCurShowKeywords objectAtIndex:i];
            [keywordView stopReplaceCurView];
            //            [keywordView stopAnimation];
        }
    }else{
        [self slideInFrom:kFTAnimationLeft inView:self.superview duration:1.2f delegate:nil startSelector:nil stopSelector:nil];
        for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
            CustomKeywordCellView * keywordView = [_allCurShowKeywords objectAtIndex:i];
            [keywordView startReplaceCurView];
            //            [keywordView startAnimation];
        }
    }
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
