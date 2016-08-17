//
//  HLCommunication.m
//  Holler
//
//  Created by Phong Nguyen on 7/4/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "HLCommunication.h"
#import <HLPush.h>
#import <HLSMS.h>
#import <HLEDM.h>

@interface HLCommunication(){
    HLPush *pushManager;
    HLSMS *smsManager;
    HLEDM *edmManager;
}

@end

@implementation HLCommunication

+(id)defaultCommunication{
    static HLCommunication *manager;
    static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    manager = [[HLCommunication alloc] init];
});
    return manager;
}

-(void)pushNotificationToSubscribers:(NSArray<HLSubscriber *> *)subscribers description:(NSString *)description subject:(NSString *)subject content:(NSString *)content onCompletion:(void (^)(BOOL, HLError *))completion{
    pushManager = [[HLPush alloc] init];
    
    [pushManager pushNotificationToSubscribers:subscribers description:description subject:subject content:content onCompletion:^(BOOL succeed, HLError *error){
        if(error){
            completion(NO, error);
        }else{
            completion(YES, nil);
        }
    }];
}

-(void)pushNotificationToSubscribers:(NSArray<HLSubscriber *> *)subscribers deeplink:(NSURL *)deeplink description:(NSString *)description subject:(NSString *)subject content:(NSString *)content onCompletion:(void (^)(BOOL, HLError *))completion{
    pushManager = [[HLPush alloc] init];
    
    [pushManager pushNotificationToSubscribers:subscribers deepLink:deeplink description:description subject:subject content:content onCompletion:^(BOOL succeed, HLError *error){
        if(error){
            completion(NO, error);
        }else{
            completion(YES, nil);
        }
    }];
}

-(void)sendSMSToSubscribers:(NSArray<HLSubscriber *> *)subscribers description:(NSString *)description content:(NSString *)content onCompletion:(void (^)(BOOL, HLError *))completion{
    smsManager = [[HLSMS alloc] init];
    
    [smsManager sendSMSToSubscribers:subscribers description:description content:content onCompletion:^(BOOL succeed, HLError *error){
        if(error){
            completion(NO, error);
        }else{
            completion(YES, nil);
        }
    }];
}

-(void)EDMToSubscribers:(NSArray<HLSubscriber *> *)subscribers description:(NSString *)description subject:(NSString *)subject content:(NSString *)content onCompletion:(void (^)(BOOL, HLError *))completion{
    edmManager = [[HLEDM alloc] init];
    
    [edmManager EDMToSubscribers:subscribers description:description subject:subject content:content onCompletion:^(BOOL succeed, HLError *error){
        if(error){
            completion(NO, error);
        }else{
            completion(YES, nil);
        }
    }];
}

@end
