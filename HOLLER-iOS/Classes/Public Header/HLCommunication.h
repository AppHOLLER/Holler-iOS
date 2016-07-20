//
//  HLCommunication.h
//  Holler
//
//  Created by Phong Nguyen on 7/4/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HLError.h>
#import <HLSubscriber.h>

@interface HLCommunication : NSObject

+(id)defaultCommunication;

-(void)pushNotificationToSubscribers: (NSArray<HLSubscriber*>*)subscribers description: (NSString *)description subject: (NSString *)subject content: (NSString *)content onCompletion: (void (^)(BOOL succeed, HLError *error))completion;

-(void)pushNotificationToSubscribers: (NSArray<HLSubscriber*>*)subscribers deeplink: (NSURL *)deeplink description: (NSString *)description subject: (NSString *)subject content: (NSString *)content onCompletion: (void (^)(BOOL succeed, HLError *error))completion;

-(void)sendSMSToSubscribers: (NSArray<HLSubscriber *>*)subscribers description: (NSString *)description content: (NSString *)content onCompletion: (void (^)(BOOL succeed, HLError *error))completion;

-(void)EDMToSubscribers: (NSArray<HLSubscriber*>*)subscribers description: (NSString *)description subject: (NSString *)subject content: (NSString *)content onCompletion: (void (^)(BOOL succeed, HLError *error))completion;

@end
