//
//  CustomInputTextView.m
//  AppDemo
//
//  Created by Sidney on 13-8-10.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "CustomInputTextView.h"
@interface CustomInputTextView()


@property (nonatomic,strong) UIImageView * tipImgView;
@property (nonatomic,strong) NSTimer * timer;

@end


@implementation CustomInputTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.8f];

        UIImageView * bgimgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 39)];
        bgimgview.image = [UIImage imageNamed:@"input_bg.png"];
        [self addSubview:bgimgview];

        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(7, 6, 54, 25);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"image_back.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];

        UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commitBtn.frame = CGRectMake(265, 15, 44, 15);
        UIFont * font = [UIFont fontWithName:@"CourierNewPSMT" size:18];
        [commitBtn.titleLabel setFont:font];
        [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(commitBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:commitBtn];
        
        txtField = [[UITextField alloc] initWithFrame:CGRectMake(75, 8, 167, 24)];
        [txtField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        txtField.delegate = self;
        txtField.returnKeyType = UIReturnKeySearch;
        txtField.textColor = [UIColor whiteColor];
        txtField.font = [UIFont systemFontOfSize:14];
        [txtField becomeFirstResponder];
        
        [self addSubview:txtField];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(checkInputText) userInfo:nil repeats:YES];
    }
    return self;
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"string:%@",textField.text);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textField.text:%@",textField.text);

    [self commitBtnPressed:nil];
    
    return YES;
    
}

- (void)checkInputText
{
    if ([txtField.text isEqualToString:@"买车"]) {
        if (!_tipImgView) {
            _tipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 102)];
            _tipImgView.userInteractionEnabled = YES;
            _tipImgView.image = [UIImage imageNamed:@"image_input_tip.png"];
            _tipImgView.backgroundColor = [UIColor clearColor];
            
            for (int i = 0; i < 3; i ++) {
                UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5 + 30 * i, 100, 25)];
                btn.tag = i;
                [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
                btn.backgroundColor = [UIColor clearColor];
                [_tipImgView addSubview:btn];
 
            }
            
        }
        [self addSubview:_tipImgView];
        
    }else{
        [_tipImgView removeFromSuperview];
    }
}

- (void)btnPressed:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(tipBtnPressed:)]) {
        [_delegate tipBtnPressed:sender];
    }
}

- (void)commitBtnPressed:(id)sender
{
    [self slideOutTo:kFTAnimationRight duration:0.618f delegate:self startSelector:nil stopSelector:@selector(endAnimation)];
    
    NSString * txt =  [txtField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([_delegate respondsToSelector:@selector(inputTextViewCommit:)]) {
        [_delegate inputTextViewCommit:txt];
    }
            [_timer invalidate];
}


- (void)backBtnPressed:(id)sender
{
    [self slideOutTo:kFTAnimationBottom duration:0.618f delegate:self startSelector:nil stopSelector:@selector(endAnimation)];
    if ([_delegate respondsToSelector:@selector(inputTextViewRemoved)]) {
        [_delegate inputTextViewRemoved];
    }
    [_timer invalidate];
    
}

- (void)endAnimation
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
