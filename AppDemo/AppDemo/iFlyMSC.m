//
//  iFlyMSC.m
//  AppDemo
//
//  Created by issuser on 13-7-18.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "iFlyMSC.h"

#define APPID @"51d24ce7"
// timeout      连接超时的时间，以ms为单位
#define TIMEOUT  @"10000"


@interface iFlyMSC()
<IFlySpeechRecognizerDelegate,IFlySpeechSynthesizerDelegate>
{
    IFlySpeechRecognizer * _iFlySpeechRecognizer;
    IFlySpeechSynthesizer *_iFlySpeechSynthesizer;
    BOOL isRecongnizer;
    BOOL isSynthesizer;
}

- (void)initiFlyMSCObject;

@end


@implementation iFlyMSC
@synthesize delegate;
static iFlyMSC * _instance;

+ (id)shareInstance
{
    if (!_instance) {
        _instance = [[iFlyMSC alloc] init];
        [_instance initiFlyMSCObject];
    }
    return _instance;
}

- (void)initiFlyMSCObject
{
    isRecongnizer = NO;
    isSynthesizer = NO;
    // 创建识别对象
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",APPID,TIMEOUT];
    _iFlySpeechRecognizer = [IFlySpeechRecognizer createRecognizer: initString delegate:self];
    _iFlySpeechRecognizer.delegate = self;
    [_iFlySpeechRecognizer setParameter:@"domain" value:@"sms"];
    [_iFlySpeechRecognizer setParameter:@"sample_rate" value:@"16000"];
    [_iFlySpeechRecognizer setParameter:@"plain_result" value:@"0"];
    [_iFlySpeechRecognizer setParameter:@"vad_bos" value:@"2000"];

    initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID];
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer createWithParams:initString delegate:self];
    _iFlySpeechSynthesizer.delegate = self;
    
    // 设置语音合成的参数
    [_iFlySpeechSynthesizer setParameter:@"speed" value:@"50"];//合成的语速,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"volume" value:@"50"];//合成的音量;取值范围 0~100
    //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [_iFlySpeechSynthesizer setParameter:@"voice_name" value:@"xiaoyan"];
    [_iFlySpeechSynthesizer setParameter:@"sample_rate" value:@"8000"];//音频采样率,目前支持的采样率有 16000 和 8000;
}

#pragma mark 开始语音识别
- (BOOL)startRecongnizer
{
    if (isRecongnizer) {
        return NO;
    }
    [_iFlySpeechRecognizer startListening];
    isRecongnizer = YES;
    return YES;
}

#pragma mark 结束语音识别
- (void)stopRecongnizer
{
    [_iFlySpeechRecognizer stopListening];
    isRecongnizer = NO;
}

#pragma mark 取消语音识别
- (void)cancelRecongnizer
{
    [_iFlySpeechRecognizer cancel];
    isRecongnizer = NO;
}

#pragma mark - IFlySpeechRecognizerDelegate
- (void)onVolumeChanged:(int)volume
{
    NSString * vol = [NSString stringWithFormat:@"音量：%d",volume];
    NSLog(@"vol:%@",vol);
    if (delegate && [delegate respondsToSelector:@selector(volumeChanged:)])
        [delegate volumeChanged:volume];
}

- (void)onBeginOfSpeech
{
    NSLog(@"正在录音");
    if (delegate && [delegate respondsToSelector:@selector(beginOfSpeech)])
        [delegate beginOfSpeech];
}

- (void)onEndOfSpeech
{
    NSLog(@"停止录音");
    if (delegate && [delegate respondsToSelector:@selector(endOfSpeech)])
        [delegate endOfSpeech];
    isRecongnizer = NO;
}

- (void)onError:(IFlySpeechError *) error
{
    NSString *text = nil;
    
    if (error.errorCode !=0 ) {
        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
    }
   
    NSLog(@"onError___:%@",text);

    isRecongnizer = NO;
//    if (text && ![text isEqualToString:@""] && ![text isKindOfClass:[NSNull class]]) {
        if (delegate && [delegate respondsToSelector:@selector(errorOfSpeech:)])
            [delegate errorOfSpeech:error];
//    }
}

- (BOOL)validateLastString:(NSString *)txt
{
    NSString *regex = @"[，。！；：、？]";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regexTest evaluateWithObject:txt];
}


- (void)onResults:(NSArray *)results
{    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    NSLog(@"转写结果：%@",result);
    isRecongnizer = NO;
    
    if ([self validateLastString:result]) {
        NSLog(@"最后单独输出的字符。");
        return;
    }
    
    int length = [result length];
    if (length > 1) {
        NSString * txt = [result substringFromIndex:(length - 1)];
        NSLog(@"TXT:%@",txt);
        if ([self validateLastString:txt]) {
            result = [result substringToIndex:(length - 1)];
        }
        NSLog(@"TXT:%@",result);
    }else{
//        return;
    }
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSTimeInterval time_last = [userDefault doubleForKey:@"timestamp"];
    NSTimeInterval time_now =[[NSDate date] timeIntervalSince1970];
    [userDefault setObject:[NSNumber numberWithDouble:time_now] forKey:@"timestamp"];
    NSLog(@"time_last:%.0f",time_last);
    NSLog(@"time_now:%.0f",time_now);
    
    if (time_now - time_last < 3) {
        return;
    }
    
    if (delegate && [delegate respondsToSelector:@selector(recognizeResults:)])
        [delegate recognizeResults:result];
}


#pragma mark 开始语音合成
- (BOOL)startSynthesizer:(NSString *)txt
{
    if (isSynthesizer) {
        return NO;
    }
    [_iFlySpeechSynthesizer startSpeaking:txt];
    isSynthesizer = YES;
    return YES;
}

#pragma mark 取消语音合成
- (void)cancelSynthesizer
{
    [_iFlySpeechSynthesizer stopSpeaking];
}

#pragma mark 暂停语音合成
- (void)pauseSynthesizer
{
    [_iFlySpeechSynthesizer pauseSpeaking];
}

#pragma mark 继续语音合成
- (void)resumeSynthesizer
{
    [_iFlySpeechSynthesizer resumeSpeaking];
}

#pragma mark - IFlySpeechSynthesizerDelegate
- (void)onSpeakBegin
{
    NSLog(@"开始播放");
    if (delegate && [delegate respondsToSelector:@selector(speakBegin)])
        [delegate speakBegin];
}

- (void)onBufferProgress:(int)progress message:(NSString *)msg
{
    NSLog(@"bufferProgress:%d,message:%@",progress,msg);
    if (delegate && [delegate respondsToSelector:@selector(bufferProgress:)])
        [delegate bufferProgress:progress];
}

- (void)onSpeakProgress:(int)progress
{
    NSLog(@"play progress:%d",progress);
    if (delegate && [delegate respondsToSelector:@selector(speakProgress:)])
        [delegate speakProgress:progress];
}

- (void)onSpeakPaused
{
    NSLog(@"播放暂停");
}

- (void)onSpeakResumed
{
    NSLog(@"播放继续");
}


- (void)onCompleted:(IFlySpeechError *) error
{
    NSString *text = nil;
    if (error.errorCode ==0 ) {
        text = @"合成完成";
    }
    else
    {
        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
    }
    NSLog(@"onCompleted:%@",text);
    isSynthesizer = NO;
    if (delegate && [delegate respondsToSelector:@selector(speakCompleted:)])
        [delegate speakCompleted:text];
}

- (void)onSpeakCancel
{
    NSLog(@"播放取消");
    isSynthesizer = NO;
    if (delegate && [delegate respondsToSelector:@selector(speakCancel)])
        [delegate speakCancel];
}




@end
