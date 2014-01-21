//
//  RightSideViewController.m
//  AppDemo
//
//  Created by Sidney on 13-8-7.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "RightSideViewController.h"

@interface RightSideViewController ()
<GMGridViewDataSource, GMGridViewSortingDelegate,
GMGridViewTransformationDelegate, GMGridViewActionDelegate>
{
    GMGridView *_gmGridView;
    NSMutableArray *_data;
    NSInteger _lastDeleteItemIndexAsked;
}
@end

@implementation RightSideViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(65,65,65,1);
//    self.mm_drawerController.shouldStretchDrawer = NO;

    _data = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 20; i ++)
    {
        [_data addObject:[NSString stringWithFormat:@"A %d", i]];
    }
    
    _gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(320 - 123 , 0, 130, CGRectGetHeight(self.view.frame))];
    
    _gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _gmGridView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_gmGridView];
    
    _gmGridView.style = GMGridViewStylePush;
    _gmGridView.itemSpacing = 0;
    _gmGridView.minEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _gmGridView.centerGrid = YES;
    _gmGridView.actionDelegate = self;
    _gmGridView.sortingDelegate = self;
    _gmGridView.transformDelegate = self;
    _gmGridView.dataSource = self;
    
    _gmGridView.enableEditOnLongPress = YES;
    _gmGridView.disableEditOnEmptySpaceTap = YES;
    _gmGridView.mainSuperView = self.view;
    
    

}

- (void)viewDidDisappear:(BOOL)animated
{
    if (_gmGridView.editing) 
        _gmGridView.editing = NO;


}


//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [_data count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(116, 92);
}


- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
NSLog(@"Creating view indx %d", index);
    
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[GMGridViewCell alloc] init];
        cell.deleteButtonIcon = [UIImage imageNamed:@"image_close.png"];
        cell.deleteButtonOffset = CGPointMake(0, 0);
        
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.userInteractionEnabled = YES;
        view.backgroundColor = [UIColor redColor];
        int j = index % 5;
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"image_%d.png",j + 1]];
        view.image = image;
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return YES;
}

#pragma mark GMGridViewActionDelegate
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    NSLog(@"Did tap at index %d", position);
    
    if (_gmGridView.editing) {
        _gmGridView.editing = NO;
    }else{
        [self.revealSideViewController popViewControllerAnimated:YES];
    }
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    NSLog(@"Tap on empty space");
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
    _gmGridView.editing = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    _lastDeleteItemIndexAsked = index;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [_data removeObjectAtIndex:_lastDeleteItemIndexAsked];
        [_gmGridView removeObjectAtIndex:_lastDeleteItemIndexAsked withAnimation:GMGridViewItemAnimationFade];
    }
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////
- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    NSObject *object = [_data objectAtIndex:oldIndex];
    [_data removeObject:object];
    [_data insertObject:object atIndex:newIndex];
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    [_data exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}

#pragma mark private methods
- (void)addMoreItem
{
    // Example: adding object at the last position
    NSString *newItem = [NSString stringWithFormat:@"%d", (int)(arc4random() % 1000)];
    
    [_data addObject:newItem];
    [_gmGridView insertObjectAtIndex:[_data count] - 1 withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
}

- (void)removeItem
{
    // Example: removing last item
    if ([_data count] > 0)
    {
        NSInteger index = [_data count] - 1;
        
        [_gmGridView removeObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
        [_data removeObjectAtIndex:index];
    }
}

- (void)refreshItem
{
    // Example: reloading last item
    if ([_data count] > 0)
    {
        int index = [_data count] - 1;
        
        NSString *newMessage = [NSString stringWithFormat:@"%d", (arc4random() % 1000)];
        
        [_data replaceObjectAtIndex:index withObject:newMessage];
        [_gmGridView reloadObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
