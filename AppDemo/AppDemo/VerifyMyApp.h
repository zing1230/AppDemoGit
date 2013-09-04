//
//  VerifyMyApp.h
//  AppDemo
//
//  Created by Sidney on 13-8-23.
//  Copyright (c) 2013年 BH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"

#define VERIFY_URL @"http://sidney.sinaapp.com/remotecontrol.json"
#define V_STATUS @"V_STATUS"

typedef enum VERIFY_CODE
{
    VERIFY_CODE_FAILED = 11, //验证失败,不允许使用,包括网络失败.
    VERIFY_CODE_OK = 22 //验证成功
}VERIFY_CODE;

@protocol VerifyMyAppDelegate;

@interface VerifyMyApp : NSObject


@property(nonatomic,assign) id <VerifyMyAppDelegate>delegate;
+ (id)shareInstance;
- (id)init;

- (void)startVerifyWithUrlString:(NSString *)url;
- (VERIFY_CODE)getLastVerifyCode;//如果网络请求失败,则手动获取上次状态,default is OK

@end

@protocol VerifyMyAppDelegate <NSObject>
@optional

- (void)requestFailed;
- (void)verifyWithCode:(VERIFY_CODE)code resultJsonString:(NSString *)jsonTxt;

@end
