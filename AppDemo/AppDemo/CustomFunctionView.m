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
        [self addSubview:imgView];
        
        UIButton * tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 103, 177, 76, 76)];
        [tempBtn setBackgroundImage:[UIImage imageNamed:@"cloud_menu_1_gray.png"] forState:UIControlStateNormal];
        [tempBtn setBackgroundImage:[UIImage imageNamed:@"cloud_menu_1_gray.png"] forState:UIControlStateHighlighted];

        [tempBtn addTarget:self action:@selector(tempBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempBtn];
        
    }
    return self;
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
