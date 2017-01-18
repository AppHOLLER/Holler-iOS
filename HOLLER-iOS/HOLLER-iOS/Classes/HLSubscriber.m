//
//  HLSubscriber.m
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "HLSubscriber.h"
#import "HLUtility.h"
#import "HLServiceManager.h"
#import "HLConstants.h"
#import "HLMiscellaneous.h"

@implementation HLSubscriber

#pragma mark - Class Methods
+(void)fetchListSubscriberOnCompletion:(void (^)(BOOL, HLError*, NSArray *))completion{
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_GET_ALL_SUBSCRIBER method:HL_HTTP_GET params:nil onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            if (completion) {
                completion(NO, errorObject, nil);
            }
        }else{
            if (completion) {
                completion(YES, nil, [[[HLSubscriber alloc] init] iterateWithJsonData:responseObject]);
            }
        }
    }];
}

+(void)fetchTotalSubscriberOnCompletion:(void (^)(BOOL, HLError*, NSUInteger))completion{
    
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_GET_TOTAL_SUBSCRIBER method:HL_HTTP_GET params:nil onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            if (completion) {
                completion(NO, errorObject, 0);
            }
        }else{
            if (completion) {
                completion(YES, errorObject, [[[HLSubscriber alloc] init] iterateOnTotalSubscriber:responseObject]);
            }
        }
    }];
}

+(void)fetchSubscriberId:(NSNumber *)subscriberId onCompletion:(void (^)(BOOL, HLError*, HLSubscriber*))completion{
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_UPDATE_SUBSCRIBER method:HL_HTTP_GET objectId:[subscriberId stringValue] onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if (!completion) {
            return ;
        }
        if(error){
            completion(NO, errorObject, nil);
        }else{
            completion(YES, nil, [[HLSubscriber alloc] initWithJsonData:responseObject]);
        }
    }];
}
    
+(void)triggerSubscriberEvent:(NSNumber *)subscriberId event:(NSDictionary *)event onCompletion:(void (^)(BOOL, HLError *, HLSubscriber *))completion{
    NSDictionary *param = [[NSDictionary alloc] init];
    param = @{ @"event" : event};
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_TRIGGER_EVENT method:HL_HTTP_POST objectId:[subscriberId stringValue] params:param onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject) {
        if (!completion) {
            return ;
        }
        if(error){
            completion(NO, errorObject, nil);
        }else{
            completion(YES, nil, [[HLSubscriber alloc] initWithJsonData:responseObject]);
        }
    }];
}

+(NSDictionary *)generateInformationDictionary{
    return @{@"gps_latitude": @0,
             @"gps_longitude": @0,
             @"gender": @"male",
             @"date_of_birth": @"yyyy/MM/dd",
             @"country": @"",
             @"industry": @"",
             @"designation": @"",
             @"interest_id": @""};
}

+(NSDictionary *)generateInformationDictionaryStartingLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude gender:(NSString *)gender dateOfBirth:(NSString *)dateOfBirth country:(NSString *)country industry:(NSString *)industry designation:(NSString *)designation interestId:(NSString *)interestId{
    return @{@"gps_latitude": latitude,
             @"gps_longitude": longitude,
             @"gender": gender,
             @"date_of_birth": dateOfBirth,
             @"country": country,
             @"industry": industry,
             @"designation": designation,
             @"interest_id": interestId};
}

-(void)updateBySubscriberIdSilently:(NSNumber *)subscriberId{
//    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_UPDATE_SUBSCRIBER method:HL_HTTP_PUT params:[HLMiscellaneous deserialiseSubscriber:self] onCompletion:nil];
    NSString *url = [NSString stringWithFormat:HOLLER_SERVICE_UPDATE_SUBSCRIBER,[subscriberId stringValue]];
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:url method:HL_HTTP_PUT params:[HLMiscellaneous deserialiseSubscriber:self] onCompletion:nil];
}

-(void)updateBySubscriberId:(NSNumber *)subscriberId onCompletion:(void (^)(BOOL, HLError*))completion{
    NSDictionary *param = [HLMiscellaneous deserialiseSubscriber:self];
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_UPDATE_SUBSCRIBER method:HL_HTTP_PUT objectId:[subscriberId stringValue] params:param onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            if (completion) {
                completion(NO, errorObject);
            }
        }else{
            if (completion) {
                completion(YES, nil);
            }
        }
    }];
}

-(void)registerSubscriberOnCompletion:(void (^)(BOOL, HLError*, NSNumber*))completion{
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_REGISTER_SUBSCRIBER method:HL_HTTP_POST objectId:nil params:[HLMiscellaneous deserialiseSubscriber:self] onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            if (completion) {
                completion(NO, errorObject, nil);
            }
        }else{
            if (completion) {
                completion(YES, nil, [self iterateSubscriberId:responseObject]);
            }
        }
    }];
}

-(void)registerSubscriberSilently{
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_REGISTER_SUBSCRIBER method:HL_HTTP_POST objectId:nil params:[HLMiscellaneous deserialiseSubscriber:self] onCompletion:nil];
}



#pragma mark - Class Lifecycle
-(instancetype)init{
    self = [super init];
    if(self){
        //initialisation phrase
        NSString* deviceToken = [HollerUserDefaults objectForKey:HLDeviceToken];
        deviceToken ? [self setSubscriberDeviceToken:deviceToken] : nil;
    }
    return self;
}

-(instancetype)initWithJsonData: (NSDictionary *)jsonData{
    self = [super init];
    if(self){
        //initialisation phrase
        NSNumber *subscriberId = [NSNumber numberWithInt:[[jsonData objectForKey:COMMON_KEY_ID] floatValue]];
        self->_subscriberId = [subscriberId copy];
        
        NSDate *createdDate = [HLUtility conformDateToHOLLERFormat:[jsonData objectForKey:SUBSCRIBER_CREATED_DATE]];
        self->_subscriberCreatedDate = createdDate;
        
        NSDate *updatedDate = [HLUtility conformDateToHOLLERFormat:[jsonData objectForKey:SUBSCRIBER_UPDATED_DATE]];
        self->_subscriberUpdatedDate = updatedDate;
        
        NSNumber *isActive = [NSNumber numberWithBool:[[jsonData objectForKey:SUBSCRIBER_IS_ACTIVE] boolValue]];
        self->_subscriberIsActive = isActive;
        
        [self setSubscriberUsername:[jsonData objectForKey:SUBSCRIBER_USERNAME]];
        [self setSubscriberEmail:[jsonData objectForKey:SUBSCRIBER_EMAIL_ADDRESS]];
        [self setSubscriberFirstName:[jsonData objectForKey:SUBSCRIBER_FIRSTNAME]];
        [self setSubscriberLastName:[jsonData objectForKey:SUBSCRIBER_LASTNAME]];
        [self setSubscriberActiveStatus:[NSNumber numberWithBool:[[jsonData objectForKey:SUBSCRIBER_IS_ACTIVE] floatValue]]];
        [self setSubscriberInformations:[jsonData objectForKey:SUBSCRIBER_INFORMATION]];
        [self setSubscriberCellphoneNumber:[jsonData objectForKey:SUBSCRIBER_CELLPHONE_NUMBER]];
    }
    return self;
}

-(NSArray *)iterateWithJsonData: (NSDictionary *)jsonData{
    NSMutableArray *subscribers = [[NSMutableArray alloc] init];
    for(NSDictionary *dictSubscriber in jsonData){
        [subscribers addObject:[self iterateOnSingleSubscriberData:dictSubscriber]];
    }
    
    return subscribers;
}


#pragma mark - Iteration
-(NSUInteger)iterateOnTotalSubscriber: (NSDictionary *)unmanedJson{
    return [unmanedJson[SUBSCRIBER_TOTAL] integerValue];
}

-(NSNumber *)iterateSubscriberId: (NSDictionary *)unmanedJson{
    return [NSNumber numberWithInt:[unmanedJson[COMMON_KEY_ID] floatValue]];
}

-(HLSubscriber *)iterateOnSingleSubscriberData: (NSDictionary *)unmanedJson{
    HLSubscriber *subscriber = [[HLSubscriber alloc] init];
    
    //readonly member
    NSNumber *subscriberId = [NSNumber numberWithInt:[[unmanedJson objectForKey:COMMON_KEY_ID] floatValue]];
    subscriber->_subscriberId = [subscriberId copy];
    
    NSDate *createdDate = [HLUtility conformDateToHOLLERFormat:[unmanedJson objectForKey:SUBSCRIBER_CREATED_DATE]];
    subscriber->_subscriberCreatedDate = createdDate;
    
    NSDate *updatedDate = [HLUtility conformDateToHOLLERFormat:[unmanedJson objectForKey:SUBSCRIBER_UPDATED_DATE]];
    subscriber->_subscriberUpdatedDate = updatedDate;
    
    NSNumber *isActive = [NSNumber numberWithBool:[[unmanedJson objectForKey:SUBSCRIBER_IS_ACTIVE] boolValue]];
    subscriber->_subscriberIsActive = isActive;
    
    
    [subscriber setSubscriberUsername:[unmanedJson objectForKey:SUBSCRIBER_USERNAME]];
    [subscriber setSubscriberEmail:[unmanedJson objectForKey:SUBSCRIBER_EMAIL_ADDRESS]];
    [subscriber setSubscriberFirstName:[unmanedJson objectForKey:SUBSCRIBER_FIRSTNAME]];
    [subscriber setSubscriberLastName:[unmanedJson objectForKey:SUBSCRIBER_LASTNAME]];
    [subscriber setSubscriberActiveStatus:[NSNumber numberWithBool:[[unmanedJson objectForKey:SUBSCRIBER_IS_ACTIVE] floatValue]]];
    [subscriber setSubscriberInformations:[unmanedJson objectForKey:SUBSCRIBER_INFORMATION]];
    [self setSubscriberCellphoneNumber:[unmanedJson objectForKey:SUBSCRIBER_CELLPHONE_NUMBER]];
    
    return subscriber;
}

@end
