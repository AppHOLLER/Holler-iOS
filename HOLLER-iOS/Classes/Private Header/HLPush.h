//
//  HLPush.h
//  Holler
//
//  Created by Phong Nguyen on 5/5/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Holler/HLError.h>
#import <Holler/HLSubscriber.h>

#import <os/activity.h>

@interface HLPush : NSObject

-(instancetype)init;

/*!
 *  @brief push notification to subscribers in cohort
 *
 *  @param subscribers list of subscriber
 *  @param description description of push notification
 *  @param subject     subject of push notification
 *  @param content     content of push notification
 *  @param completion  asynchronous block
 *
 *  @since 0.0.1
 */
-(void)pushNotificationToSubscribers: (NSArray<HLSubscriber*> *)subscribers
                         description: (NSString *)description
                             subject: (NSString *)subject
                             content: (NSString *)content
                        onCompletion: (void (^)(BOOL succeed, HLError *error))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief push notification to subscriber in cohort
 *
 *  @param subscribers list of subscriber
 *  @param deepLink    given deeplink provides in push notification
 *  @param description description of push notification
 *  @param subject     subject of push notification
 *  @param content     content of push notification
 *  @param completion  asynchronous block
 *
 *  @since 0.0.1
 */
-(void)pushNotificationToSubscribers: (NSArray<HLSubscriber*> *)subscribers
                            deepLink: (NSURL*)deepLink
                         description: (NSString *)description
                             subject: (NSString *)subject
                             content: (NSString *)content
                        onCompletion: (void (^)(BOOL succeed, HLError *error))completion NS_AVAILABLE_IOS(8_0);

@end
