//
//  VerifyMyApp.m
//  AppDemo
//
//  Created by Sidney on 13-8-23.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import "VerifyMyApp.h"

@interface VerifyMyApp()
<NSURLConnectionDelegate>

@property(nonatomic,strong) NSMutableData * receivedData;
@property(nonatomic,strong) NSURLConnection * URLConnection;

@end

@implementation VerifyMyApp

static VerifyMyApp * _instance;

+ (id)shareInstance
{
    if (!_instance) {
        _instance = [[VerifyMyApp alloc] init];
    }
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)startVerifyWithUrlString:(NSString *)url
{
    url = VERIFY_URL;
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    if (_receivedData){
        [_receivedData setLength:0];
        _receivedData = nil;
    }
    if (_URLConnection) {
        [_URLConnection cancel];
        _URLConnection = nil;
    }
    
    _receivedData = [[NSMutableData alloc] init];
    _URLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_URLConnection start];
}

#pragma mark NSURLConnection Delegate
// Called when the HTTP socket gets a response.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_receivedData setLength:0];
}

// Called when the HTTP socket received data.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)value {
    [_receivedData appendData:value];
}

// Called when the HTTP request fails.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  
    if ([_delegate respondsToSelector:@selector(requestFailed)]) {
        [_delegate requestFailed];
    }
    
    [self cancel];
}

// Called when the connection has finished loading.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString * response = [[NSString alloc] initWithData:_receivedData encoding: NSUTF8StringEncoding];
    NSLog(@"%@", response);
	[self analyzeJsonString:response];
    [self cancel];
}

- (void)analyzeJsonString:(NSString *)result
{
    NSDictionary * jsonData = [result JSONValue];
    NSString * isnormaluser = [jsonData objectForKey:@"isnormaluser"];
//    NSString * companyname = [jsonData objectForKey:@"companyname"];
    if ([isnormaluser isEqualToString:@"true"]) {
        if ([_delegate respondsToSelector:@selector(verifyWithCode:resultJsonString:)]) {
            [_delegate verifyWithCode:VERIFY_CODE_OK resultJsonString:result];
        }
        [self setCurVerifyCode:VERIFY_CODE_OK];
    }else{
        
        if ([_delegate respondsToSelector:@selector(verifyWithCode:resultJsonString:)]) {
            
            [_delegate verifyWithCode:VERIFY_CODE_FAILED resultJsonString:result];
        }
        [self setCurVerifyCode:VERIFY_CODE_FAILED];
//        exit(0);
    }
}

- (void)setCurVerifyCode:(VERIFY_CODE)code
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:(int)code forKey:V_STATUS];
    [userDefaults synchronize];
}

- (VERIFY_CODE)getLastVerifyCode
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    int status = [userDefaults integerForKey:V_STATUS];
    return (VERIFY_CODE)status;
}

// Cancels the HTTP request.
- (BOOL)cancel {
	if(_URLConnection == nil) return NO;
	[_URLConnection cancel];
	_URLConnection = nil;
    _receivedData = nil;
	return YES;
}



@end
