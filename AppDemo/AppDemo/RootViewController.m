//
//  RootViewController.m
//  AppDemo
//
//  Created by sun pan on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "RootViewController.h"
#import "FTUtils.h"
#import "CustomKeywordView.h"

@interface RootViewController ()
{
    BOOL animationStoped;
}
@property (nonatomic,strong) CustomSpeakerView * speakerView;
@property (nonatomic,strong) CustomInputTextView * inputTextView;

@property (nonatomic,strong) NSMutableArray * allCurShowKeywords;
@property (nonatomic,strong) NSMutableArray * allKeywords;

@property (nonatomic,strong) CustomKeywordView * curSelectedView;
@property (nonatomic,strong) UIImageView * curShowKeywordImgView;

@property (nonatomic,strong) UIView * speakerBackView;
@property (nonatomic,strong) UIImageView * volumeImageView;
@property (nonatomic,strong) UILabel * speakerTipLabel;
@property (nonatomic,strong) QuadCurveMenu *menu;

@property (nonatomic,strong) UIImageView * buyCarImgView;
@property (nonatomic,strong) UIView * noResultView;


@property (nonatomic,assign) CGRect lastFrame;
@property (nonatomic,strong) UIButton * lastSelectBtn;
@property (nonatomic,strong) UIButton * backBtn;
//@property (nonatomic,strong)
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
    //    roundbgImg.transform = CGAffineTransformMakeTranslation(10, 10);
    
    _iflyMSC = [iFlyMSC shareInstance];
    _iflyMSC.delegate = self;
    
    _speakerView = [[CustomSpeakerView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 154, SCREEN_HEIGHT - 125, 154, 125)];
    _speakerView.delegate = self;
    [self.view addSubview:_speakerView];
    
    _allCurShowKeywords = [[NSMutableArray alloc] init];
    _allKeywords = [[NSMutableArray alloc] init];
    
    animationStoped = YES;
    [self initKeywordView];
}

- (void)keywordViewTaped:(UITapGestureRecognizer *)tap
{
    CustomKeywordView * keywordView = (CustomKeywordView *)[tap view];
    if (_curSelectedView) {
        _curSelectedView = nil;
    }
    _curSelectedView = keywordView;
    
    int index = keywordView.tag;
    keywordView.hidden = YES;
    for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
        CustomKeywordView * keywordView = [_allCurShowKeywords objectAtIndex:i];
        [keywordView slideOutTo:kFTAnimationLeft inView:self.view duration:0.6f delegate:nil startSelector:nil stopSelector:nil];
        [keywordView stopReplaceCurView];
    }
    
    NSString * imgName = [NSString stringWithFormat:@"keyword_%d.png",index + 1];
    UIImage * image = [UIImage imageNamed:imgName];
    
    CGRect frame = CGRectMake(CGRectGetWidth(keywordView.frame) / 2 - 20, CGRectGetMinY(keywordView.frame), CGRectGetWidth(keywordView.keywordImgView.frame), CGRectGetHeight(keywordView.keywordImgView.frame));
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
    [self initMenuView];
}



- (void)initKeywordView
{
    float originY = 102;
    int offsetW = 0;
    for (int i = 0; i < 10; i ++) {
        CustomKeywordView * keywordView = [[CustomKeywordView alloc] initWithFrame:CGRectMake(10, originY , 100, 50)];
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
        }else{
            offsetW -= 30;
        }
        
        CustomKeywordView * keywordView = [_allKeywords objectAtIndex:i];
        keywordView.frame = CGRectMake(10, originY + 51 * i, 70 + offsetW, 50);
        [keywordView setImageName:[NSString stringWithFormat:@"keyword_%d.png",i + 1]];
        
        [keywordView startAnimation];
        [keywordView startReplaceCurView];
        
        [self.view addSubview:keywordView];
        [_allCurShowKeywords addObject:keywordView];
    }
}

#pragma mark CustomKeywordViewDelegate
- (void)startReplaceOtherKeyworkd:(CustomKeywordView *)view curIndex:(int)index
{
    NSLog(@"__FUNCTION__:%s __LINE__:%d index:%d",__FUNCTION__,__LINE__,index);

        if (index != 1) {
            if (!animationStoped) {
                NSLog(@"123123123__________________________");
                [view startReplaceCurView];
                return;
            }
            
            NSMutableArray * data = [[NSMutableArray alloc] init];
            for (CustomKeywordView * keyview in _allCurShowKeywords) {
                [data addObject:[NSNumber numberWithInt:keyview.tag]];
            }
            
            int generateIndex = [self genertateRandomNumberStartNum:0 endNum:9 cannotContainsKey:data];
            
            NSLog(@"index:%d",index);
            NSLog(@"generateIndex:%d",generateIndex);
//            NSLog(@"data:%@",data);
            
            CGRect frame = view.frame;
            int curIndex = [self getCurIndexInArray:view];
            
            CustomKeywordView * keywordView = [_allKeywords objectAtIndex:generateIndex];
            keywordView.frame = frame;
            [keywordView setImageName:[NSString stringWithFormat:@"keyword_%d.png",keywordView.tag + 1]];
            keywordView.alpha = 0;
            [self.view addSubview:keywordView];

            
            [UIView animateWithDuration:1.0f animations:^{
                view.alpha = 0;
                animationStoped = NO;
            } completion:^(BOOL finished) {
                [view stopAnimation];
                [view removeFromSuperview];
                view.alpha = 1;
                animationStoped = YES;
            }];
            
            [UIView animateWithDuration:0.6f animations:^{
                keywordView.alpha = 1;
            } completion:^(BOOL finished) {
                [keywordView startAnimation];
                [keywordView startReplaceCurView];
            }];
    
            NSLog(@"__FUNCTION__:%s __LINE__:%d curIndex:%d",__FUNCTION__,__LINE__,curIndex);
            [_allCurShowKeywords replaceObjectAtIndex:curIndex withObject:keywordView];
            NSLog(@"__FUNCTION__:%s __LINE__:%d ",__FUNCTION__,__LINE__);
        }
}

- (int)getCurIndexInArray:(CustomKeywordView *)view
{
    int i = 0;
    for (CustomKeywordView * keywordView in _allCurShowKeywords) {
        if (keywordView == view) {
            return i;
        }
            i++;
    }
//    for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
//        CustomKeywordView * keywordView = [_allCurShowKeywords objectAtIndex:i];
//        if (keywordView == view) {
//            return i;
//        }
//    }
//    return 0;
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

- (void)initTitleView
{
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    imgView.backgroundColor = RGBACOLOR(224,47,62,1);
    [self.view addSubview:imgView];
    
    UIImageView * weatherImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 130, 45)];
    weatherImg.image = [UIImage imageNamed:@"image_weather.png"];
    [self.view addSubview:weatherImg];
    
    float width = 27,height = 21;
    UIButton * msgBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 15, width, height)];
    [msgBtn setBackgroundImage:[UIImage imageNamed:@"image_msg_box.png"] forState:UIControlStateNormal];
    [msgBtn addTarget:self action:@selector(msgBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:msgBtn];
    
    UIButton * settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(msgBtn.frame)+ 5, 15, width, height)];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"image_setting_icon.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
    
    UIButton * functionBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(settingBtn.frame) + 5, 15, width, height)];
    [functionBtn setBackgroundImage:[UIImage imageNamed:@"image_more_icon.png"] forState:UIControlStateNormal];
    [functionBtn addTarget:self action:@selector(functionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:functionBtn];
    
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
    
}

- (void)openLeftViewBtnPressed:(UIButton *)sender
{
    [self.mm_drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
    }];
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
    
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(10, 240, 44, 25);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"image_back.png"] forState:UIControlStateNormal];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"image_back.png"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    _backBtn.alpha = 0;
    
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
        [UIView animateWithDuration:0.6f animations:^{
            _buyCarImgView.alpha = 0;
        } completion:^(BOOL finished) {
            [_buyCarImgView removeFromSuperview];
            _buyCarImgView = nil;
        }];
    }
    _curSelectedView.hidden = NO;
    
    
    [UIView animateWithDuration:0.6f animations:^{
        CGRect frame = CGRectMake(CGRectGetMinX(_curSelectedView.frame), CGRectGetMinY(_curSelectedView.frame), CGRectGetWidth(_curSelectedView.keywordImgView.frame), CGRectGetHeight(_curSelectedView.keywordImgView.frame));
        _curShowKeywordImgView.alpha = 0;
        _curShowKeywordImgView.frame = frame;
    } completion:^(BOOL finished) {
        [_curShowKeywordImgView removeFromSuperview];
        _curShowKeywordImgView = nil;
    }];
    
    for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
        CustomKeywordView * keywordView = [_allCurShowKeywords objectAtIndex:i];
        [keywordView startReplaceCurView];
        [keywordView slideInFrom:kFTAnimationLeft inView:self.viewToAnimate.superview duration:1.2f delegate:nil startSelector:nil stopSelector:nil];
    }
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
    [UIView animateWithDuration:0.6f animations:^{
        _backBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [_backBtn removeFromSuperview];
        [self resetViewStatus];
    }];
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
    [self performSelector:@selector(starRec) withObject:nil afterDelay:0.5f];
}

- (void)starRec
{
    [_iflyMSC startRecongnizer];
    [self initSpeakerView];
    [self.view bringSubviewToFront:_speakerBackView];
    
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
    
    for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
        CustomKeywordView * keywordView = [_allCurShowKeywords objectAtIndex:i];
        [keywordView stopReplaceCurView];
        [keywordView slideOutTo:kFTAnimationLeft inView:self.view duration:0.6f delegate:nil startSelector:nil stopSelector:nil];
    }
    
    _inputTextView = [[CustomInputTextView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, SCREEN_HEIGHT - 55)];
    _inputTextView.delegate = self;
    [self.view addSubview:_inputTextView];
    [_inputTextView slideInFrom:kFTAnimationRight duration:0.618f delegate:nil startSelector:nil stopSelector:nil];
    
}

#pragma mark InputTextViewDelegate
- (void)inputTextViewRemoved
{
    for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
        CustomKeywordView * keywordView = [_allCurShowKeywords objectAtIndex:i];
        [keywordView startReplaceCurView];
        [keywordView slideInFrom:kFTAnimationLeft inView:self.viewToAnimate.superview duration:1.2f delegate:nil startSelector:nil stopSelector:nil];
    }
    
}




- (void)inputTextViewCommit:(NSString *)inputTxt
{
    
    if ([inputTxt isEqualToString:@"买车"]) {
        [self initBuyCarView];
    }else{
        [self initResultNoneView];
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
    _speakerBackView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0];
    [self.view addSubview:_speakerBackView];
    
    _volumeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 71) / 2, (SCREEN_HEIGHT - 70) / 2, 71, 70)];
    _volumeImageView.image = [UIImage imageNamed:@"image_volume_1.png"];
    [_speakerBackView addSubview:_volumeImageView];
    
    _speakerTipLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150) / 2, CGRectGetMaxY(_volumeImageView.frame), 150, 30)];
    _speakerTipLabel.backgroundColor = [UIColor clearColor];
    _speakerTipLabel.textAlignment = NSTextAlignmentCenter;
    _speakerTipLabel.text = @"请说出您的需求";
    _speakerTipLabel.textColor = [UIColor lightGrayColor];
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
    if (error.errorCode == 10118) {
        
    }else{
        [self showAlertView:@"失败" message:[error errorDesc]];
    }
    
    if (_speakerBackView) {
        [_speakerBackView removeFromSuperview];
        _speakerBackView = nil;
    }
}

//识别信息
- (void)recognizeResults:(NSString *)result
{
    NSLog(@"result:%@",result);
    if (result && ![result isEqualToString:@""] && ![result isKindOfClass:[NSNull class]]) {
        [self showAlertView:result message:nil];
    }
    
    if (_speakerBackView) {
        [_speakerBackView removeFromSuperview];
        _speakerBackView = nil;
    }
    
    if ([speakerKeywords containsObject:result]) {
        [self initShowResultView:result];
    }else{
        for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
            CustomKeywordView * keywordView = [_allCurShowKeywords objectAtIndex:i];
            [keywordView stopReplaceCurView];
            [keywordView slideOutTo:kFTAnimationLeft inView:self.view duration:0.6f delegate:nil startSelector:nil stopSelector:nil];
        }
        [self initResultNoneView];
    }
    
}




- (void)initResultNoneView
{
    if (!_noResultView) {
        _noResultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noResultView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.3f];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noResultViewTaped:)];
        [_noResultView addGestureRecognizer:tap];
        
        UIImageView * noResultImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 125, 102, 202)];
        noResultImgView.image = [UIImage imageNamed:@"image_error_tip.png"];
        [_noResultView addSubview:noResultImgView];
    }
    
    [self.view addSubview:_noResultView];
    [UIView animateWithDuration:0.6f animations:^{
        _noResultView.alpha = 1;
    }];
}

- (void)noResultViewTaped:(UITapGestureRecognizer *)tap
{
    for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
        CustomKeywordView * keywordView = [_allCurShowKeywords objectAtIndex:i];
        [keywordView startReplaceCurView];
        [keywordView slideInFrom:kFTAnimationLeft inView:self.viewToAnimate.superview duration:1.2f delegate:nil startSelector:nil stopSelector:nil];
    }
    
    
    [UIView animateWithDuration:0.6f animations:^{
        _noResultView.alpha = 0;
    } completion:^(BOOL finished) {
        _noResultView.alpha = 1;
        [_noResultView removeFromSuperview];
    }];
}

- (void)initShowResultView:(NSString *)result
{
    for (int i = 0; i < [_allCurShowKeywords count]; i ++) {
        CustomKeywordView * keywordView = [_allCurShowKeywords objectAtIndex:i];
        [keywordView stopReplaceCurView];
        [keywordView slideOutTo:kFTAnimationLeft inView:self.view duration:0.6f delegate:nil startSelector:nil stopSelector:nil];
    }
    
    if ([result isEqualToString:@"买车"]) {
        [self initBuyCarView];
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
