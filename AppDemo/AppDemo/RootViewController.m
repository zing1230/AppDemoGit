//
//  RootViewController.m
//  AppDemo
//
//  Created by sun pan on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "RootViewController.h"
#import "FTUtils.h"
#import "CustomKeywordCellView.h"

#import "VerifyMyApp.h"
@interface RootViewController ()
<VerifyMyAppDelegate>
{
    CustomFunctionView * cloudFunctionView;
    RightSideViewController * rightSideViewCtrller;
}
@property (nonatomic,strong) UIImageView * titleImgView;
@property (nonatomic,strong) CustomSpeakerView * speakerView;
@property (nonatomic,strong) CustomInputTextView * inputTextView;

@property (nonatomic,strong) CustomKeywordView * keywordView;

@property (nonatomic,strong) CustomKeywordCellView * curSelectedView;
@property (nonatomic,strong) UIImageView * curShowKeywordImgView;


@property (nonatomic,strong) UIView * speakerBackView;
@property (nonatomic,strong) UIImageView * volumeImageView;
@property (nonatomic,strong) UILabel * speakerTipLabel;
@property (nonatomic,strong) QuadCurveMenu *menu;

@property (nonatomic,strong) UIImageView * buyCarImgView;
@property (nonatomic,strong) UIView * noResultView;
@property (nonatomic,strong) UIImageView * buyCarTipView;

@property (nonatomic,strong) UIButton * backBtn;
@end

@implementation RootViewController
@synthesize _iflyMSC;
static NSArray * speakerKeywords;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(65,65,65,1);
    
    speakerKeywords  = @[@"计算器",@"优惠",@"买车",@"车型",@"配件",@"保养",@"保险",@"预约",@"经销商",@"维修"];
    
    [self initTitleView];
    
    UIImageView * roundbgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 182, 279)];
    roundbgImg.image = [UIImage imageNamed:@"image_bg_round.png"];
    [self.view addSubview:roundbgImg];

    
    _iflyMSC = [iFlyMSC shareInstance];
    _iflyMSC.delegate = self;
    
    _speakerView = [[CustomSpeakerView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 154, SCREEN_HEIGHT - 125, 154, 125)];
    _speakerView.delegate = self;
    [self.view addSubview:_speakerView];
    
    
    _keywordView = [[CustomKeywordView alloc] initWithFrame:CGRectMake(0, 105, 180, 240)];
    _keywordView.delegate = self;
    _keywordView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_keywordView];
    
    VerifyMyApp * app = [[VerifyMyApp alloc] init];
    app.delegate = self;
    [app startVerifyWithUrlString:nil];
    
    rightSideViewCtrller = [[RightSideViewController alloc] init];
    [self.revealSideViewController pushViewController:rightSideViewCtrller onDirection:PPRevealSideDirectionRight withOffset:320 - 116 animated:NO];
    [rightSideViewCtrller.revealSideViewController popViewControllerAnimated:NO];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.view bringSubviewToFront:_menu];
    [self.view bringSubviewToFront:_backBtn];
}

- (void)setCanMoveToOpenRightViewStatus:(BOOL)status
{
    if (status) {
        [self.revealSideViewController changeOffset:320-116 forDirection:PPRevealSideDirectionRight];

    }else{
        [self.revealSideViewController changeOffset:320 forDirection:PPRevealSideDirectionRight];

    }
}

#pragma mark CustomKeywordViewDelegate
- (void)keywordTaped:(CustomKeywordCellView *)keywordCell  keywordView:(CustomKeywordView *)view
{
    int index = keywordCell.tag;
    if (index == 1) {
        if (_curSelectedView) {
            _curSelectedView = nil;
        }
        
        _curSelectedView = keywordCell;
        keywordCell.hidden = YES;
        NSString * imgName = [NSString stringWithFormat:@"keyword_%d.png",index + 1];
        UIImage * image = [UIImage imageNamed:imgName];
        
        CGRect frame = CGRectMake(CGRectGetMinX(keywordCell.keywordImgView.frame), CGRectGetMinY(keywordCell.frame) + CGRectGetMinY(_keywordView.frame), CGRectGetWidth(keywordCell.keywordImgView.frame), CGRectGetHeight(keywordCell.keywordImgView.frame));
        
        _curShowKeywordImgView = [[UIImageView alloc] initWithFrame:frame];
        _curShowKeywordImgView.image = image;
        [self.view addSubview:_curShowKeywordImgView];
        
        [UIView animateWithDuration:0.6f animations:^{
            int imgWidth = image.size.width;
            int imgHeight = image.size.height;
            float scale = 1;
            if (imgWidth == 200) {
                scale = 0.7f;
            }else{
                scale = 0.5f;
            }
            _curShowKeywordImgView.frame = CGRectMake(10, 150,imgWidth * scale , imgHeight * scale);
        } completion:^(BOOL finished) {
            
        }];
        
        [view setKeywordViewHiddenStatus:YES];
        [self initMenuView];
        [self.view bringSubviewToFront:_speakerView];
        
    }
}

#pragma mark VerifyMyAppDelegate
- (void)requestFailed
{
    VERIFY_CODE code = [[VerifyMyApp shareInstance] getLastVerifyCode];
    if (code == VERIFY_CODE_FAILED) exit(0);
}

- (void)verifyWithCode:(VERIFY_CODE)code resultJsonString:(NSString *)jsonTxt
{
    if (code == VERIFY_CODE_FAILED) exit(0);
}

- (void)initTitleView
{
    _titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    _titleImgView.backgroundColor = RGBACOLOR(224,47,62,1);
    _titleImgView.userInteractionEnabled = YES;
    [self.view addSubview:_titleImgView];
    
    UIImageView * weatherImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 130, 45)];
    weatherImg.image = [UIImage imageNamed:@"image_weather.png"];
    [_titleImgView addSubview:weatherImg];
    
    float width = 27,height = 21;
    UIButton * msgBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 15, width, height)];
    [msgBtn setBackgroundImage:[UIImage imageNamed:@"image_msg_box.png"] forState:UIControlStateNormal];
    [msgBtn addTarget:self action:@selector(msgBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_titleImgView addSubview:msgBtn];
    
    UIButton * settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(msgBtn.frame)+ 5, 15, width, height)];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"image_setting_icon.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_titleImgView addSubview:settingBtn];
    
    UIButton * functionBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(settingBtn.frame) + 5, 15, width, height)];
    [functionBtn setBackgroundImage:[UIImage imageNamed:@"image_more_icon.png"] forState:UIControlStateNormal];
    [functionBtn addTarget:self action:@selector(functionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_titleImgView addSubview:functionBtn];
    
    UIButton * openLeftViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(290, 210, 18, 22)];
    [openLeftViewBtn setBackgroundImage:[UIImage imageNamed:@"image_pull_back.png"] forState:UIControlStateNormal];
    [openLeftViewBtn addTarget:self action:@selector(openLeftViewBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openLeftViewBtn];
}

- (void)msgBtnPressed:(UIButton *)sender
{
    [self enterIntoMsgAlertViewCtrller];
}

- (void)settingBtnPressed:(UIButton *)sender
{
    
}

- (void)functionBtnPressed:(UIButton *)sender
{
    if (cloudFunctionView) {
        [cloudFunctionView removeFromSuperview];
        cloudFunctionView = nil;
    }
    
//    if (_noResultView) {
//        [_noResultView removeFromSuperview];
//        _noResultView = nil;
//        [_keywordView setKeywordViewHiddenStatus:NO];
//    }
    if (_inputTextView) {
        [_inputTextView backBtnPressed:nil];
        _inputTextView = nil;
    }
    
    cloudFunctionView = [[CustomFunctionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    cloudFunctionView.delegate= self;
    [self.view addSubview:cloudFunctionView];
    
    [UIView animateWithDuration:0.618f animations:^{
        cloudFunctionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

#pragma mark CustomFunctionViewDelegate
- (void)functionSelectedAtIndex:(int)index functionView:(CustomFunctionView *)view
{
    switch (index) {
        case 1:
        {
            [self enterIntoDealersViewCtrller];
        }
            break;
        case 4:
        {

        }
            break;
        default:
            break;
    }
    
    
}


- (void)openLeftViewBtnPressed:(UIButton *)sender
{
//    [self.mm_drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
//        
//    }];
    
    RightSideViewController * right = [[RightSideViewController alloc] init];
    [self.revealSideViewController pushViewController:right onDirection:PPRevealSideDirectionRight withOffset:320 - 116 animated:YES];
    
}


- (void)initMenuView
{
    if (_menu) {
        [_menu removeFromSuperview];
        _menu = nil;
    }
    
    QuadCurveMenuItem * item1 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_1.png"]
                                                        highlightedImage:nil
                                                            ContentImage:nil
                                                 highlightedContentImage:nil];
    
    QuadCurveMenuItem * item2 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_2.png"]
                                                        highlightedImage:nil
                                                            ContentImage:nil
                                                 highlightedContentImage:nil];
    
    QuadCurveMenuItem * item3 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_3.png"]
                                                        highlightedImage:nil
                                                            ContentImage:nil
                                                 highlightedContentImage:nil];
    
    QuadCurveMenuItem * item4 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_4.png"]
                                                        highlightedImage:nil
                                                            ContentImage:nil
                                                 highlightedContentImage:nil];
    QuadCurveMenuItem * item5 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_5.png"]
                                                        highlightedImage:nil
                                                            ContentImage:nil
                                                 highlightedContentImage:nil];
    QuadCurveMenuItem * item6 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_6.png"]
                                                        highlightedImage:nil
                                                            ContentImage:nil
                                                 highlightedContentImage:nil];
    
    
    NSArray *menus = [NSArray arrayWithObjects:item1, item2, item3, item4,item5,item6,nil];
   
    
    _menu = [[QuadCurveMenu alloc] initWithFrame:self.view.bounds menus:menus];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    _menu.transform = CGAffineTransformMakeRotation(M_PI_4);
    [_menu openMenu];
    _menu.backgroundColor = [UIColor clearColor];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(10, 240, 54, 25);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"image_back.png"] forState:UIControlStateNormal];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"image_back.png"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    _backBtn.alpha = 0;
    [self.view bringSubviewToFront:_titleImgView];
    [UIView animateWithDuration:0.6f animations:^{
        _backBtn.alpha = 1;
    }];
}

- (void)resetViewStatus
{
    if (_menu) {
        [_menu removeFromSuperview];
        _menu = nil;
    }
    
    if (_buyCarImgView) {
        [UIView animateWithDuration:0.3f animations:^{
            _buyCarImgView.alpha = 0;
        } completion:^(BOOL finished) {
            [_buyCarImgView removeFromSuperview];
            _buyCarImgView = nil;
        }];
    }
    _curSelectedView.hidden = NO;
    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = CGRectMake(CGRectGetMinX(_curSelectedView.frame), CGRectGetMinY(_curSelectedView.frame) + CGRectGetMinY(_keywordView.frame), CGRectGetWidth(_curSelectedView.keywordImgView.frame), CGRectGetHeight(_curSelectedView.keywordImgView.frame));
        
        
        _curShowKeywordImgView.alpha = 0;
        _curShowKeywordImgView.frame = frame;
    } completion:^(BOOL finished) {
        [_curShowKeywordImgView removeFromSuperview];
        _curShowKeywordImgView = nil;
    }];
    
    //    [self setKeywordViewHiddenStatus:NO];
    [_keywordView setKeywordViewHiddenStatus:NO];
}


- (void)backBtnPressed:(UIButton *)sender
{
    [_menu openMenu];
    
    [UIView animateWithDuration:0.6f animations:^{
        sender.alpha = 0;
    } completion:^(BOOL finished) {
        [sender removeFromSuperview];
        [self resetViewStatus];
    }];
}

#pragma mark QuadCurveMenuDelegate
- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    //    [self backBtnPressed:_backBtn];
    //    [UIView animateWithDuration:0.6f animations:^{
    //        _backBtn.alpha = 0;
    //    } completion:^(BOOL finished) {
    //        [_backBtn removeFromSuperview];
    //        [self resetViewStatus];
    //    }];
    //    return;
    switch (idx) {
        case 0:
        {
            [self enterIntoBookingCarViewCtrller];
        }
            break;
        case 1:
        {
            [self enterIntoTestDrivingViewCtrller];
        }
            break;
        case 2:
        {
            [self enterIntoDealersViewCtrller];
        }
            break;
        case 3:
        {
            [self enterIntoSpecialOffersViewCtrller];
        }
            break;
        case 4:
        {
            [self enterIntoCalculatorViewCtrller];
        }
            break;
        case 5:
        {
            [self enterIntoCarModelsViewCtrller];
        }
            break;
        default:
            break;
    }
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [self.viewToAnimate fallIn:.4 delegate:nil];
    //    [self.viewToAnimate fallOut:0.4f delegate:nil];
    
    //    [self.viewToAnimate flyOut:0.4f delegate:nil];
    //    [self.viewToAnimate fadeIn:0.4f delegate:nil];
    
    //    [self.viewToAnimate popIn:.4 delegate:nil];
    //        [self.viewToAnimate popOut:.4 delegate:nil];
    
    //    [self.viewToAnimate fadeIn:.4 delegate:nil];
    //    [self.viewToAnimate fadeOut:.4 delegate:nil];
    
    
    //    [self.viewToAnimate slideInFrom:kFTAnimationLeft inView:self.viewToAnimate.superview duration:0.4 delegate:nil startSelector:nil stopSelector:nil];
    //        [self.viewToAnimate slideOutTo:kFTAnimationLeft inView:self.viewToAnimate.superview duration:0.4 delegate:nil startSelector:nil stopSelector:nil];
    
    //    [self.viewToAnimate backInFrom:kFTAnimationLeft inView:self.viewToAnimate.superview withFade:NO duration:0.4 delegate:nil startSelector:nil stopSelector:nil];
    //    [self.viewToAnimate backOutTo:kFTAnimationLeft inView:self.viewToAnimate.superview withFade:NO duration:0.4 delegate:nil startSelector:nil stopSelector:nil];
    
    
}

- (void)enterIntoMsgAlertViewCtrller
{
    MessageAlertViewController * msgAlertViewCtrller = [[MessageAlertViewController alloc] init];
    [self.navigationController pushViewController:msgAlertViewCtrller animated:YES];
}

- (void)enterIntoTestDrivingViewCtrller
{
    TestDrivingViewController * testDrivingViewCtrller = [[TestDrivingViewController alloc] init];
    [self.navigationController pushViewController:testDrivingViewCtrller animated:YES];
}

- (void)enterIntoBookingCarViewCtrller
{
    BookingCarViewController * bookingCarViewCtrller = [[BookingCarViewController alloc] init];
    [self.navigationController pushViewController:bookingCarViewCtrller animated:YES];
}

- (void)enterIntoDealersViewCtrller
{
    DealersLactionViewController * dealersViewCtrller = [[DealersLactionViewController alloc] init];
    [self.navigationController pushViewController:dealersViewCtrller animated:YES];
}

- (void)enterIntoCalculatorViewCtrller
{
    CalculatorViewController * calculatorViewCtrller = [[CalculatorViewController alloc] init];
    [self.navigationController pushViewController:calculatorViewCtrller animated:YES];
}

- (void)enterIntoCarModelsViewCtrller
{
    CarModelsViewController * carModelsViewCtrller = [[CarModelsViewController alloc] init];
    [self.navigationController pushViewController:carModelsViewCtrller animated:YES];
}

- (void)enterIntoSpecialOffersViewCtrller
{
    SpecialOffersViewController * specialOffersViewCtrller = [[SpecialOffersViewController alloc] init];
    [self.navigationController pushViewController:specialOffersViewCtrller animated:YES];
}


#pragma mark CustomSpeakerViewDelegate
- (void)touchBegan:(CustomSpeakerView *)view
{
    [_backBtn removeFromSuperview];
    [self resetViewStatus];
    [self noResultViewTaped:nil];
    
    if (_buyCarTipView) {
        [_buyCarTipView removeFromSuperview];
        _buyCarTipView = nil;
    }
    
    
    [self performSelector:@selector(starRec) withObject:nil afterDelay:0.3f];
    //    [self initSpeakerView];
    //    [self.view bringSubviewToFront:_speakerBackView];
}

- (void)starRec
{
    if ([[ConfigData shareInstance] getNetworkStatus] != NotReachable) {
        [_iflyMSC startRecongnizer];
        [self initSpeakerView];
        [self.view bringSubviewToFront:_speakerBackView];
        [self setCanMoveToOpenRightViewStatus:NO];
    }
}

- (void)touchEnded:(CustomSpeakerView *)view
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(starRec) object:nil];
    
    [_iflyMSC stopRecongnizer];
    _speakerTipLabel.text = @"识别中";
}

- (void)touchMoved:(CustomSpeakerView *)view
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(starRec) object:nil];
    [self touchCanceled:view];
    [self initInputTextView];
}

- (void)touchCanceled:(CustomSpeakerView *)view
{
    if (_speakerBackView) {
        [_speakerBackView removeFromSuperview];
        _speakerBackView = nil;
    }
    
    [_iflyMSC stopRecongnizer];
    [_iflyMSC cancelRecongnizer];
}

- (void)initInputTextView
{
    if (_inputTextView) {
        [_inputTextView removeFromSuperview];
        _inputTextView = nil;
    }
    
    [_keywordView setKeywordViewHiddenStatus:YES];
    _inputTextView = [[CustomInputTextView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, SCREEN_HEIGHT - 55)];
    _inputTextView.delegate = self;
    [self.view addSubview:_inputTextView];
    [_inputTextView slideInFrom:kFTAnimationBottom duration:0.618f delegate:nil startSelector:nil stopSelector:nil];
    
}

#pragma mark InputTextViewDelegate
- (void)inputTextViewRemoved
{
    [_keywordView setKeywordViewHiddenStatus:NO];
    _inputTextView = nil;
}

- (void)inputTextViewCommit:(NSString *)inputTxt
{
    if ([inputTxt isEqualToString:@"买车"]) {
        [self initBuyCarView];
    }else{
        [self initResultNoneView:inputTxt];
    }
    [self.view bringSubviewToFront:_speakerView];
    _inputTextView = nil;
}


- (void)initTipMenuView
{
    if (_buyCarTipView) {
        [_buyCarTipView removeFromSuperview];
        _buyCarTipView = nil;
    }
    
    UIImage * image = [UIImage imageNamed:@"image_buy_car_tip.png"];
    _buyCarTipView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 125, 273/2 ,366/2)];
    _buyCarTipView.userInteractionEnabled = YES;
    _buyCarTipView.image = image;
    [self.view addSubview:_buyCarTipView];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 15, 120, 80)];
    [btn addTarget:self action:@selector(keywordBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [_buyCarTipView addSubview:btn];
    
    for (int i = 0; i < 3; i ++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100 + 30 * i, 100, 25)];
        btn.tag = i;
        [btn addTarget:self action:@selector(tipBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        [_buyCarTipView addSubview:btn];
    }
}

- (void)keywordBtnPressed:(UIButton *)btn
{
    [_buyCarTipView removeFromSuperview];
    [self initBuyCarView];
    [self.view bringSubviewToFront:_speakerView];
    
}

- (void)tipBtnPressed:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
        {
            [self enterIntoDealersViewCtrller];
        }
            break;
        case 1:
        {
            [self enterIntoSpecialOffersViewCtrller];
        }
            break;
        case 2:
        {
            [self enterIntoCalculatorViewCtrller];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)initBuyCarView
{
    if (_buyCarImgView) {
        [_buyCarImgView removeFromSuperview];
        _buyCarImgView = nil;
    }
    
    UIImage * image = [UIImage imageNamed:@"keyword_2.png"];
    int imgWidth = image.size.width;
    int imgHeight = image.size.height;
    _buyCarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 150, imgWidth * 0.7f, imgHeight * 0.7f)];
    _buyCarImgView.image = image;
    [self.view addSubview:_buyCarImgView];
    _buyCarImgView.alpha = 0;
    
    [UIView animateWithDuration:0.6f animations:^{
        _buyCarImgView.alpha = 1;
        
    }];
    
    [self initMenuView];
    
}


- (void)initSpeakerView
{
    if (_speakerBackView) {
        [_speakerBackView removeFromSuperview];
        _speakerBackView = nil;
    }
    _speakerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _speakerBackView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.8f];
    [self.view addSubview:_speakerBackView];
    
    _volumeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 71) / 2, (SCREEN_HEIGHT - 70) / 2, 71, 70)];
    _volumeImageView.image = [UIImage imageNamed:@"image_volume_1.png"];
    [_speakerBackView addSubview:_volumeImageView];
    
    _speakerTipLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150) / 2, CGRectGetMaxY(_volumeImageView.frame), 150, 40)];
    _speakerTipLabel.backgroundColor = [UIColor clearColor];
    _speakerTipLabel.textAlignment = NSTextAlignmentCenter;
    _speakerTipLabel.numberOfLines = 2;
    
    _speakerTipLabel.text = @"请说出您的需求\n向上滑动切换键盘";
    
    _speakerTipLabel.textColor = [UIColor whiteColor];
    _speakerTipLabel.font = [UIFont systemFontOfSize:16];
    [_speakerBackView addSubview:_speakerTipLabel];
}

#pragma mark iFlyMSCDelegate
//输入语音的音量大小实时回调
- (void)volumeChanged:(int)volume
{
    _volumeImageView.image = nil;
    [UIView animateWithDuration:0.4f
                     animations:^{
                         if (volume >= 0 && volume <= 6) {
                             _volumeImageView.image = [UIImage imageNamed:@"image_volume_1.png"];
                         }else if(volume >6 && volume <= 12){
                             _volumeImageView.image = [UIImage imageNamed:@"image_volume_2.png"];
                         }else if(volume > 12 && volume <= 18){
                             _volumeImageView.image = [UIImage imageNamed:@"image_volume_3.png"];
                         }else if(volume > 18 && volume < 24){
                             _volumeImageView.image = [UIImage imageNamed:@"image_volume_4.png"];
                         }else if(volume >24 && volume <= 30){
                             _volumeImageView.image = [UIImage imageNamed:@"image_volume_5.png"];
                         }
                     }];
}

//开始识别
- (void)beginOfSpeech
{
    
}
//结束识别
- (void)endOfSpeech
{
    //    _speakerTipLabel.text = @"结束识别";
    NSLog(@"endOfSpeech");
}

//错误信息
- (void)errorOfSpeech:(IFlySpeechError *)error
{
    NSLog(@"errorString___:%@",[error description]);
    if (error.errorCode != 0) {
        [self showAlertView:@"失败" message:[error errorDesc]];
    }
    if (_speakerBackView) {
        [_speakerBackView removeFromSuperview];
        _speakerBackView = nil;
    }
    [self setCanMoveToOpenRightViewStatus:YES];

}

//识别信息
- (void)recognizeResults:(NSString *)result
{
    NSLog(@"result:%@",result);
    
    if (_speakerBackView) {
        [_speakerBackView removeFromSuperview];
        _speakerBackView = nil;
    }
    
    if (result.length < 1) {
        return;
    }
    
    if (result && ![result isEqualToString:@""] && ![result isKindOfClass:[NSNull class]]) {
//        [self showAlertView:result message:nil];
    }
    
    if ([speakerKeywords containsObject:result]) {
        [self initShowResultView:result];
        
    }else{
        [_keywordView setKeywordViewHiddenStatus:YES];
        [self initResultNoneView:result];
    }
    [self.view bringSubviewToFront:_speakerView];
    
    [self setCanMoveToOpenRightViewStatus:YES];

}

- (void)initResultNoneView:(NSString *)errTxt
{
    if (!_noResultView) {
        _noResultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noResultView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.3f];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noResultViewTaped:)];
        [_noResultView addGestureRecognizer:tap];

        UIImageView * noResultImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 125, 150, 187)];
        
        UILabel * errorTxt = [[UILabel alloc] initWithFrame:CGRectMake(13, 20 + 125, 120, 30)];
        errorTxt.tag = 999;
        errorTxt.backgroundColor = [UIColor clearColor];
        errorTxt.text = errTxt;
        errorTxt.font = [UIFont systemFontOfSize:17];
        errorTxt.textColor = [UIColor whiteColor];
        [_noResultView addSubview:errorTxt];
        
        noResultImgView.image = [UIImage imageNamed:@"image_error_tip_1.png"];
        [_noResultView addSubview:noResultImgView];
        
        UIButton * buycarBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 230, 60, 30)];
        [buycarBtn setBackgroundColor:[UIColor clearColor]];
        [buycarBtn addTarget:self action:@selector(buyCarBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_noResultView addSubview:buycarBtn];
        
    }
    
    [self.view addSubview:_noResultView];
    UILabel * errorTxt = (UILabel *)[_noResultView viewWithTag:999];
    errorTxt.text = [NSString stringWithFormat:@"\"%@\"",errTxt];
    
    [UIView animateWithDuration:0.6f animations:^{
        _noResultView.alpha = 1;
    }];
    [self.view bringSubviewToFront:_titleImgView];

}

- (void)buyCarBtnPressed:(UIButton *)btn
{
    [_noResultView removeFromSuperview];

    [self initBuyCarView];
    [self.view bringSubviewToFront:_speakerView];
}

- (void)noResultViewTaped:(UITapGestureRecognizer *)tap
{
    [_keywordView setKeywordViewHiddenStatus:NO];
    [UIView animateWithDuration:0.6f animations:^{
        _noResultView.alpha = 0;
    } completion:^(BOOL finished) {
        _noResultView.alpha = 1;
        [_noResultView removeFromSuperview];
    }];
}

- (void)initShowResultView:(NSString *)result
{
    [_keywordView setKeywordViewHiddenStatus:YES];
    if ([result isEqualToString:@"买车"]) {
        [self initTipMenuView];
    }else{
        
    }
    
}

- (void)showAlertView:(NSString *)title message:(NSString *)msg
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title
                                                         message:msg
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
    [alertView show];
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
