//
//  HLSMS.m
//  Holler
//
//  Created by Phong Nguyen on 7/4/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "HLSMS.h"
#import <HLMiscellaneous.h>
#import <HLConstants.h>
#import <HLServiceManager.h>

@implementation HLSMS

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    
    return self;
}

-(void)sendSMSToSubscribers:(NSArray<HLSubscriber *> *)subscribers description:(NSString *)description content:(NSString *)content onCompletion:(void (^)(BOOL, HLError *))completion{
    NSDictionary *payload = [HLMiscellaneous serialiseSMSPayloadToSubscribers:subscribers description:description content:content];
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_COM_SMS method:HL_HTTP_POST params:payload onCompletion:^(BOOL succeed, NSError *error, HLError *errorObj, id responseObject){
        if(errorObj){
            completion(NO, errorObj);
        }else{
            completion(YES, nil);
        }
    }];
}

@end
