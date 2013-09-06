//
//  CustomFunctionView.m
//  AppDemo
//
//  Created by Sidney on 13-8-30.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "CustomFunctionView.h"

@implementation CustomFunctionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        UIImage * img = [UIImage imageNamed:@"cloud_menu_bg.png"];
        UIImageView * imgView = [[UIImageView alloc] initWithImage:img];
        imgView.frame = CGRectMake(0, 38, 320, 744/2);
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 340)];
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        
        float size = 152 / 2;
        int contentHeight = 0;
        NSArray * functionName = @[@"洗车指数",@"经销商",@"限行尾号",@"计算器",@"违章查询"];
        for (int i = 0; i < 20; i ++) {
            int row = i / 3;
            int col = i % 3;
            
            int j = 0;
            if (i > 5 && i % 5 == 1) j = 2;
            else j = i % 5;
            
            NSString * imgName = [NSString stringWithFormat:@"image_function_%d.png",j];
            UIImage * image = [UIImage imageNamed:imgName];
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(25 + col * (size + 20), 23 + row * (size + 30), size, size)];
            btn.tag = j;
            
            if (j == 1) {
                curBtn = btn;
                NSLog(@"%@",NSStringFromCGRect(btn.frame));
            }
            [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [scrollView addSubview:btn];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(25 + col * (size + 20), CGRectGetMaxY(btn.frame), 80, 25)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            
            
            label.text = [functionName objectAtIndex:j];
            [scrollView addSubview:label];
            contentHeight = CGRectGetMaxY(label.frame);
        }
        [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, contentHeight)];
        isDownload = NO;
        
//        UIButton * tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 103, 177, 76, 76)];
//        [tempBtn setBackgroundImage:[UIImage imageNamed:@"cloud_menu_1_gray.png"] forState:UIControlStateNormal];
//        [tempBtn setBackgroundImage:[UIImage imageNamed:@"cloud_menu_1_gray.png"] forState:UIControlStateHighlighted];
//
//        [tempBtn addTarget:self action:@selector(tempBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:tempBtn];
        
    }
    return self;
}

- (void)timerScheduled
{
    static float i = 0;
    i += 0.05f;
    [circularSlider setValue:i];

    if (i > 1) {
        [timer invalidate];
        i = 0;
        timer = nil;
        isDownload = YES;
        [curBtn setBackgroundImage:[UIImage imageNamed:@"image_function_2_1.png"] forState:UIControlStateNormal];
        [circularSlider removeFromSuperview];
        return;
    }
    
}

- (IBAction)updateProgress:(UISlider *)sender
{
    
}

- (void)btnPressed:(UIButton *)sender
{
    int index = sender.tag;
    if (index == 1 && !isDownload) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@"是否下载该应用"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"下载", nil];
        alertView.tag = 1;
        [alertView show];
    }else{
        if ([_delegate respondsToSelector:@selector(functionSelectedAtIndex:functionView:)]) {
            [_delegate functionSelectedAtIndex:index functionView:self];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int tag = alertView.tag;
    NSLog(@"buttonIndex:%d",buttonIndex);
    
    if (buttonIndex == 1 && tag == 1)
    {
        circularSlider = [[UICircularSlider alloc] initWithFrame:CGRectMake(-4, -3, 84,83)];
        circularSlider.backgroundColor = [UIColor clearColor];
        [circularSlider setMinimumValue:0];
        [circularSlider setMaximumValue:1.0f];
        
        [circularSlider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventValueChanged];
        [curBtn addSubview:circularSlider];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerScheduled) userInfo:nil repeats:YES];
    }
}

- (void)tempBtnPressed:(UIButton *)sender
{
    if (!sender.selected) {
        [UIView animateWithDuration:0.2f animations:^{
            sender.alpha = 0.8f;
        } completion:^(BOOL finished) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cloud_menu_1_red.png"] forState:UIControlStateNormal];
            [sender setBackgroundImage:[UIImage imageNamed:@"cloud_menu_1_red.png"] forState:UIControlStateHighlighted];
            
            [UIView animateWithDuration:0.3f animations:^{
                sender.alpha = 1;
            }];
        }];
    }else{
        [UIView animateWithDuration:0.4f animations:^{
            sender.alpha = 0.6f;
        } completion:^(BOOL finished) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cloud_menu_1_gray.png"] forState:UIControlStateNormal];
            [sender setBackgroundImage:[UIImage imageNamed:@"cloud_menu_1_gray.png"] forState:UIControlStateHighlighted];

            
            [UIView animateWithDuration:0.3f animations:^{
                sender.alpha = 1;
            }];
        }];
        
    }
    
    sender.selected = !sender.selected;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
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
