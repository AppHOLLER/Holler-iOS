//
//  Holler.m
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "Holler.h"
#import <Holler/HLConstants.h>
#import <Holler/HLServiceManager.h>
#import <Holler/HLMiscellaneous.h>
#import <Holler/HLAnalytic.h>

@implementation Holler

+(void)startHolleringWithApplicationId:(NSString *)appId accessId:(NSString *)accessId{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [HLMiscellaneous perceiveCredentials:appId accessId:accessId];
    });
}

//Application lifecycle
+(BOOL)didFinishLaunchingWithOptions:(NSDictionary *)options{
    static dispatch_once_t onceToken;
    static Holler *holler;
    __block BOOL detachCredential;
    dispatch_once(&onceToken, ^{
        holler = [[Holler alloc] init];
        detachCredential = [holler detachApplicationCrdentials:options];
    });
    
    return detachCredential;
}

+(void)applicationWillTerminate:(UIApplication *)application{
    [[HLAnalytic defaultAnalytic] trackClosedUsageFromNowOnCompletion:nil];
}

+(void)applicationDidBecomeActive:(UIApplication *)application{
    [[HLAnalytic defaultAnalytic] trackOpenedUsageFromNowOnCompletion:nil];
}


//Remote Notification Handler
+(void)didRegisterForRemoteNotificationWithDeviceToken:(NSData *)deviceToken{
    [HLMiscellaneous perceiveDeviceToken:deviceToken];
}

+(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_RECEIVE_PUSH_NOTIFICATION method:HL_HTTP_POST objectId:nil params:[HLMiscellaneous serialisePushNotificationReceivedFromPayload:userInfo] onCompletion:nil];
}


#pragma mark - Detach
-(BOOL)detachApplicationCrdentials: (NSDictionary *)credentialInLaunchOptions{
    NSString *applicationId = [credentialInLaunchOptions objectForKey:HLApplicationId];
    NSString *accessId = [credentialInLaunchOptions objectForKey:HLAccessId];
    
    if(!applicationId || !accessId){
        return NO;
    }else{
        [HLMiscellaneous perceiveCredentials:applicationId accessId:accessId];
        return YES;
    }
}

@end
