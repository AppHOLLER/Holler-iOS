//
//  HLEDM.m
//  Holler
//
//  Created by Phong Nguyen on 7/4/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "HLEDM.h"
#import <HLMiscellaneous.h>
#import <HLConstants.h>
#import <HLServiceManager.h>

@implementation HLEDM

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)EDMToSubscribers:(NSArray<HLSubscriber *> *)subscribers description:(NSString *)description subject:(NSString *)subject content:(NSString *)content onCompletion:(void (^)(BOOL, HLError *))completion{
    NSDictionary *payload = [HLMiscellaneous serialiseEDMPayloadToSubscribers:subscribers description:description subject:subject content:content];
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_COM_EDM method:HL_HTTP_POST params:payload onCompletion:^(BOOL succeed, NSError *error, HLError *errorObj, id responseObject){
        if(errorObj){
            completion(NO, errorObj);
        }else{
            completion(YES, nil);
        }
    }];
}

@end
