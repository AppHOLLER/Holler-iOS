//
//  HLError.m
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "HLMiscellaneous.h"
#import <Holler/HLSubscriber.h>
#import <Holler/HLConstants.h>

@interface HLMiscellaneous()

@end

@implementation HLMiscellaneous

+(NSString *)perceiveAPI:(NSString *)request{
    //return [NSString stringWithFormat:@"%@%@", HOLLER_LIVED, request];
    return [NSString stringWithFormat:@"http://dev-holler.rmlbs.co/api/v2%@", request];
}

+(void)perceiveCredentials: (nonnull NSString *)appId accessId: (nonnull NSString *)accessId{
    [HollerUserDefaults setObject:appId forKey:HOLLERAppId];
    [HollerUserDefaults setObject:accessId forKey:HOLLERAccessId];
}

+(NSDictionary *)perceiveHeaderCredential{
    return @{@"HOLLER-APP-ID" : [HollerUserDefaults objectForKey:HOLLERAppId],
             @"Holler-Access-Key" : [HollerUserDefaults objectForKey:HOLLERAccessId]
             };
}

+(NSDictionary *)perceiveParams:(NSArray *)keys paramValues:(NSArray *)values{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for(NSString *key in keys){
        [params setObject:[values objectAtIndex:[keys indexOfObject:key]] forKey:key];
    }
    
    return [NSDictionary dictionaryWithDictionary:params];
}

+(BOOL)perceiveDeviceToken:(NSData *)deviceToken{
    if(deviceToken){
        [HollerUserDefaults setObject:[HLMiscellaneous deviceTokenForData:deviceToken] forKey:HLDeviceToken];
        return YES;
    }else{
        return NO;
    }
}


#pragma mark - Subscriber Manipulation
+(NSDictionary *)deserialiseSubscriber: (HLSubscriber*)subscriber{
    NSString *deviceToken = [HollerUserDefaults objectForKey:HLDeviceToken];
    if (deviceToken != nil) {
        return @{SUBSCRIBER_USERNAME: subscriber.subscriberUsername,
                 SUBSCRIBER_DEVICE_TOKEN: !subscriber.subscriberDeviceToken?deviceToken:subscriber.subscriberDeviceToken,
                 SUBSCRIBER_DEVICE_TYPE: @"ios",
                 SUBSCRIBER_EMAIL_ADDRESS: subscriber.subscriberEmail,
                 SUBSCRIBER_FIRSTNAME: subscriber.subscriberFirstName,
                 SUBSCRIBER_LASTNAME: subscriber.subscriberLastName,
                 SUBSCRIBER_CELLPHONE_NUMBER: subscriber.subscriberCellphoneNumber,
                 SUBSCRIBER_INFORMATION: subscriber.subscriberInformations};
    } else {
        return @{@"" : @""};
    }
}

+(NSData *)deserialiseSubscriberToData:(HLSubscriber *)subscriber error:(NSError *__autoreleasing *)error{
    NSDictionary *subscriberJson = [HLMiscellaneous deserialiseSubscriber:subscriber];
    return [NSJSONSerialization dataWithJSONObject:subscriberJson options:NSJSONWritingPrettyPrinted error:error];
}


#pragma mark - Device token Manipulation
+(NSString *)deviceTokenForData:(NSData *)data{
    return [[[[data description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
}


#pragma mark - Push Notification Manipulation
+(NSString *)detachCommunicationIdFromPayload:(NSDictionary *)payload{
    if(payload[HL_PUSH_APS][HL_PUSH_ALERT]){
        NSString *communicationId = payload[HL_PUSH_CUSTOM][HL_PUSH_DATA_A][HL_PUSH_COMMUNICATION_ID];
        if(communicationId){
            return communicationId;
        }else{
            return nil;
        }
    }
    return nil;
}

+(NSDictionary *)serialisePushNotificationReceivedFromPayload:(NSDictionary *)payload{
    return @{SUBSCRIBER_DEVICE_TOKEN: [HollerUserDefaults objectForKey:HLDeviceToken],
             SUBSCRIBER_DEVICE_TYPE: @"ios",
             HL_PUSH_COMMUNICATION_ID: [HLMiscellaneous detachCommunicationIdFromPayload:payload]};
}


#pragma mark - Push Notification Customised
+(NSDictionary *)serialisePushNotificationPayloadToSubscribers:(NSArray<HLSubscriber *> *)subscribers description:(NSString *)description subject:(NSString *)subject content:(NSString *)content deeplink: (NSString *)deeplink{
    NSMutableArray *subscriberIds = [[NSMutableArray alloc] init];
    
    for(HLSubscriber *subscriber in subscribers){
        [subscriberIds addObject:subscriber.subscriberId];
    }
    
    if(!deeplink){
        return @{PUSH_SUBSCRIBER_ID: subscriberIds,
                 PUSH_DESCRIPTION: description,
                 PUSH_SUBJECT: subject,
                 PUSH_CONTENT_WRAPPER: @{PUSH_SUBJECT: subject,
                                         PUSH_CONTENT: content
                                         }
                 };
    }else{
        return @{PUSH_SUBSCRIBER_ID: subscriberIds,
                 PUSH_DESCRIPTION: description,
                 PUSH_SUBJECT: subject,
                 PUSH_CONTENT_WRAPPER: @{PUSH_SUBJECT: subject,
                                         PUSH_CONTENT: content
                                         },
                 PUSH_DEEP_LINK: deeplink
                 };
    }
}

+(NSDictionary *)serialiseSMSPayloadToSubscribers:(NSArray<HLSubscriber *> *)subscribers description:(NSString *)description content:(NSString *)content{
    NSMutableArray *subscriberIds = [[NSMutableArray alloc] init];
    for(HLSubscriber *subscriber in subscribers){
        [subscriberIds addObject:subscriber.subscriberId];
    }
    
    return @{SMS_SUBSCRIBER_ID: subscriberIds,
             SMS_DESCRIPTION: description,
             SMS_CONTENT_WRAPPER: @{SMS_CONTENT:content}
             };
}

+(NSDictionary *)serialiseEDMPayloadToSubscribers:(NSArray<HLSubscriber *> *)subscribers description:(NSString *)description subject:(NSString *)subject content:(NSString *)content{
    NSMutableArray *subscriberIds = [[NSMutableArray alloc] init];
    for(HLSubscriber *subscriber in subscribers){
        [subscriberIds addObject:subscriber.subscriberId];
    }
    
    return @{EDM_SUBSCRIBER_ID: subscriberIds,
             EDM_DESCRIPTION: description,
             EDM_CONTENT: @{EDM_SUBJECT: subject,
                            EDM_CONTENT: content
                            }
             };
}


#pragma mark - Analytics
+(NSDictionary *)serialiseTrackingTimeSpentPayloadFromCurrentWithSubscriberId:(NSNumber *)subscriberId status:(NSString *)status coordinate:(CLLocationCoordinate2D)coordinate{
    return @{ANALYTIC_SUBSCRIBER_ID:[subscriberId stringValue],
             ANALYTIC_DEVICE_NAME: @"iOS",
             ANALYTIC_TIME_INTERVAL: [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]],
             ANALYTIC_LATITUDE: [NSNumber numberWithDouble:coordinate.latitude],
             ANALYTIC_LONGITUDE: [NSNumber numberWithDouble:coordinate.longitude],
             ANALYTIC_STATUS: status
             };
}

+(NSDictionary *)serialiseTrackingTimeSpentPayloadOfCurrentSubscriberFromCurrentByStatus:(NSString *)status coordinate:(CLLocationCoordinate2D)coordinate{
    NSDictionary *pay =  [HLMiscellaneous serialiseTrackingTimeSpentPayloadFromCurrentWithSubscriberId:[NSNumber numberWithInt:154] status:status coordinate:coordinate];
    return pay;
}

@end

