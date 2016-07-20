//
//  HLSMS.h
//  Holler
//
//  Created by Phong Nguyen on 7/4/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HLSubscriber.h>
#import <HLError.h>

@interface HLSMS : NSObject

-(instancetype)init;

-(void)sendSMSToSubscribers: (NSArray<HLSubscriber*>*)subscribers description: (NSString *)description content: (NSString *)content onCompletion: (void (^)(BOOL succeed, HLError *error))completion;

@end
