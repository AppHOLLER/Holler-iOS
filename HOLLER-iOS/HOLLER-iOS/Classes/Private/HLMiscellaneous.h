//
//  HLError.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

extern NSString *HollerServiceURL;

@class HLSubscriber;

@interface HLMiscellaneous : NSObject

+(NSString *)perceiveAPI:(NSString *)request;
+(void)perceiveCredentials: (NSString *)appId accessId: (NSString *)accessId;
+(NSDictionary *)perceiveHeaderCredential;
+(BOOL)perceiveDeviceToken: (NSData *)deviceToken;

//Subscriber Manipulation
+(NSDictionary *)deserialiseSubscriber: (HLSubscriber*)subscriber;
+(NSData *)deserialiseSubscriberToData: (HLSubscriber*)subscriber
                                 error: (NSError**)error;

//Device token Manipulation
+(NSString *)deviceTokenForData: (NSData *)data;

//Push Notification Manipulation
+(NSString *)detachCommunicationIdFromPayload: (NSDictionary *)payload;
+(NSDictionary *)serialisePushNotificationReceivedFromPayload: (NSDictionary *)payload;

//Push Notification Customised
+(NSDictionary *)serialisePushNotificationPayloadToSubscribers: (NSArray<HLSubscriber*> *)subscribers
                                                   description: (NSString *)description
                                                       subject: (NSString *)subject
                                                       content: (NSString *)content
                                                      deeplink: (NSString *)deeplink;

+(NSDictionary *)serialiseEDMPayloadToSubscribers: (NSArray<HLSubscriber*> *)subscribers
                                      description: (NSString *)description
                                          subject: (NSString *)subject
                                          content: (NSString *)content;

+(NSDictionary *)serialiseSMSPayloadToSubscribers: (NSArray<HLSubscriber*> *)subscribers
                                      description: (NSString *)description
                                          content: (NSString *)content;


//Analytic
+(NSDictionary *)serialiseTrackingTimeSpentPayloadFromCurrentWithSubscriberId: (NSNumber *)subscriberId
                                                                       status: (NSString *)status
                                                                   coordinate: (CLLocationCoordinate2D)coordinate;
+(NSDictionary *)serialiseTrackingTimeSpentPayloadOfCurrentSubscriberFromCurrentByStatus: (NSString *)status
                                                                              coordinate: (CLLocationCoordinate2D)coordinate;

@end