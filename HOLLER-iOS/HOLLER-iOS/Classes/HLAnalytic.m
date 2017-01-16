//
//  HLTracking.m
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/18/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "HLAnalytic.h"

#import <CoreLocation/CoreLocation.h>
#import "HLUtility.h"
#import "HLConstants.h"
#import "HLServiceManager.h"
#import "HLMiscellaneous.h"

@interface HLAnalytic()<CLLocationManagerDelegate>

@end

@implementation HLAnalytic

+(instancetype)defaultAnalytic{
    static HLAnalytic *analytic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        analytic = [[HLAnalytic alloc] init];
    });
    return analytic;
}

-(void)trackOpenedUsageFromNowOnCompletion:(void (^)(BOOL, HLError *))completion{
    NSDictionary *payload = [HLMiscellaneous serialiseTrackingTimeSpentPayloadOfCurrentSubscriberFromCurrentByStatus:@"open" coordinate:[self getCurrentLocation]];
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_ANALYTIC_TIME_SPENT method:HL_HTTP_POST params:payload onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            if (completion) {
                completion(NO, errorObject);
            }
            NSLog(@"Error occurs while execute tracking app usage - Open");
        }else{
            if (completion) {
                completion(YES, nil);
            }
            NSLog(@"App Opened Tracked");
        }
    }];
}

-(void)trackOpenedUsageFromNowSilently{
    [self trackOpenedUsageFromNowOnCompletion:nil];
}

-(void)trackClosedUsageFromNowOnCompletion:(void (^)(BOOL, HLError *))completion{
    NSDictionary *payload = [HLMiscellaneous serialiseTrackingTimeSpentPayloadOfCurrentSubscriberFromCurrentByStatus:@"close" coordinate:[self getCurrentLocation]];
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_ANALYTIC_TIME_SPENT method:HL_HTTP_POST params:payload onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            if (completion) {
                completion(NO, errorObject);
            }
            NSLog(@"Error occurs while execute tracking app usage - Close");
        }else{
            if (completion) {
                completion(YES, nil);
            }
            NSLog(@"App Closed Tracked");
        }
    }];
}

-(void)trackClosedUsageFromNowSilently{
    [self trackClosedUsageFromNowOnCompletion:nil];
}

-(void)trackOpenedUsageFromNowBySubscriberId:(NSNumber *)subscriberId onCompletion:(void (^)(BOOL, HLError *))completion{
    NSDictionary *payload = [HLMiscellaneous serialiseTrackingTimeSpentPayloadFromCurrentWithSubscriberId:subscriberId status:@"open" coordinate:[self getCurrentLocation]];
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_ANALYTIC_TIME_SPENT method:HL_HTTP_POST params:payload onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            completion(NO, errorObject);
        }else{
            completion(YES, nil);
        }
    }];
}

-(void)trackOpenedUsageFromNowSilentlyBySubscriberId:(NSNumber *)subscriberId{
    NSDictionary *payload = [HLMiscellaneous serialiseTrackingTimeSpentPayloadFromCurrentWithSubscriberId:subscriberId status:@"open" coordinate:[self getCurrentLocation]];
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_ANALYTIC_TIME_SPENT method:HL_HTTP_POST params:payload onCompletion:nil];
}

-(void)trackClosedUsageFromNowBySubscriberId:(NSNumber *)subscriberId onCompletion:(void (^)(BOOL, HLError *))completion{
    NSDictionary *payload = [HLMiscellaneous serialiseTrackingTimeSpentPayloadFromCurrentWithSubscriberId:subscriberId status:@"close" coordinate:[self getCurrentLocation]];
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_ANALYTIC_TIME_SPENT method:HL_HTTP_POST params:payload onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            completion(NO, errorObject);
        }else{
            completion(YES, nil);
        }
    }];
}

-(void)trackClosedUsageFromNowSilentlyBySubscriberId:(NSNumber *)subscriberId{
    NSDictionary *payload = [HLMiscellaneous serialiseTrackingTimeSpentPayloadFromCurrentWithSubscriberId:subscriberId status:@"open" coordinate:[self getCurrentLocation]];
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_ANALYTIC_TIME_SPENT method:HL_HTTP_POST params:payload onCompletion:nil];
}


#pragma mark - Uncaught Exception


#pragma mark - Location Tracker
-(CLLocationCoordinate2D)getCurrentLocation{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    return coordinate;
}

@end
