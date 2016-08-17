//
//  HLPush.m
//  Holler
//
//  Created by Phong Nguyen on 5/5/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "HLPush.h"
#import <HLServiceManager.h>
#import <HLConstants.h>
#import <HLMiscellaneous.h>

@implementation HLPush

-(instancetype)init{
    self = [super init];
    if(self){
        //initialisation phrase
    }
    
    return self;
}

-(void)pushNotificationToSubscribers:(NSArray<HLSubscriber*> *)subscribers description:(NSString *)description subject: (NSString *)subject content:(NSString *)content onCompletion:(void (^)(BOOL, HLError *))completion{
    NSDictionary *payload = [HLMiscellaneous serialisePushNotificationPayloadToSubscribers:subscribers description:description subject:subject content:content deeplink:nil];
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_COM_PUSH method:HL_HTTP_POST params:payload onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(errorObject){
            completion(NO, errorObject);
        }else{
            completion(YES, nil);
        }
    }];
    
    os_activity_initiate("performClick", OS_ACTIVITY_FLAG_DEFAULT, ^(void){
        
    });
}

-(void)pushNotificationToSubscribers:(NSArray<HLSubscriber *> *)subscribers deepLink:(NSURL *)deepLink description:(NSString *)description subject:(NSString *)subject content:(NSString *)content onCompletion:(void (^)(BOOL, HLError *))completion{
    NSDictionary *payload = [HLMiscellaneous serialisePushNotificationPayloadToSubscribers:subscribers description:description subject:subject content:content deeplink:[deepLink absoluteString]];
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_COM_PUSH method:HL_HTTP_POST params:payload onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(errorObject){
            completion(NO, errorObject);
        }else{
            completion(YES, nil);
        }
    }];
}

@end
