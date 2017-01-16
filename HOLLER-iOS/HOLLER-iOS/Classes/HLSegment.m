//
//  HLTarget.m
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import "HLSegment.h"
#import "HLConstants.h"
#import "HLServiceManager.h"

@implementation HLSegment

#pragma mark - Class Methods
+(void)fetchListNationalitySegmentOnCompletion:(void (^)(BOOL, HLError* _Nullable, NSArray * _Nullable))completion{
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_GET_LIST_COUNTRY method:HL_HTTP_GET params:nil onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if(error){
            if (completion) {
                completion(NO, errorObject, nil);
            }
            
        }else{
            if (completion) {
                completion(YES, nil, [[HLSegment alloc] iterateOnSegmentKindNationality:responseObject]);
            }
        }
    }];
}

+(void)fetchListGenderSegmentOnCompletion:(void (^)(BOOL, HLError* _Nullable, NSArray * _Nullable))completion{
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_GET_LIST_GENDER method:HL_HTTP_GET params:nil onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if (!completion) {
            return;
        }
        
        if(error){
            completion(NO, errorObject, nil);
        }else{
            completion(YES, nil, [[HLSegment alloc] iterateOnSegmentKindGender:responseObject]);
        }
    }];
}

+(void)fetchListDeviceSegmentOnCompletion:(void (^)(BOOL, HLError* _Nullable, NSArray * _Nullable))completion{
    [[HLServiceManager standardManager] executeRESTRequestWithCredential:HOLLER_SERVICE_GET_LIST_DEVICE method:HL_HTTP_GET params:nil onCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, id responseObject){
        if (!completion) {
            return;
        }
        
        if(error){
            completion(NO, errorObject, nil);
        }else{
            completion(YES, nil, [[HLSegment alloc] iterateOnSegmentKindLocation:responseObject]);
        }
    }];
}


#pragma mark - Class Life Cycle
-(instancetype)init{
    self = [super init];
    if(self){
        //initialisation phrase
    }
    return self;
}

-(id)initWithJson:(NSDictionary *)json{
    self = [super init];
    if(self){
        //initialisation phrase
        
    }
    return self;
}

-(NSArray *)iterateWithJsonData: (NSDictionary *)jsonData{
    NSArray *segments;
    segments = [[NSArray alloc] init];
    
    //identify type of segment
    HLSegmentType segmentType = [self identifySegmentType:jsonData];
    
    switch (segmentType) {
        case HLSegmentIsDevice:
            segments = [self iterateOnSegmentKindDevice:jsonData];
            break;
            
        case HLSegmentIsNationality:
            segments = [self iterateOnSegmentKindNationality:jsonData];
            break;
        
        case HLSegmentIsGender:
            segments = [self iterateOnSegmentKindGender:jsonData];
            break;
        
        case HLSegmentIsLocation:
            segments = [self iterateOnSegmentKindLocation:jsonData];
            break;
            
        default:
            break;
    }
    
    return segments;
}


#pragma mark - Detection

-(HLSegmentType)identifySegmentType: (NSDictionary *)jsonData{
    NSString *segmentKind = [jsonData objectForKey:[jsonData.allKeys firstObject]];
    
    if(segmentKind){
        if([segmentKind isEqualToString:TARGET_IS_DEVICE]){
            return HLSegmentIsDevice;
        }else if([segmentKind isEqualToString:TARGET_IS_NATIONALITY]){
            return HLSegmentIsNationality;
        }else if([segmentKind isEqualToString:TARGET_IS_GENDER]){
            return HLSegmentIsGender;
        }else if([segmentKind isEqualToString:TARGET_IS_LOCATION]){
            return HLSegmentIsLocation;
        }
    }
    return HLSegmentIsUndefined;
}


#pragma mark - Iteration Plural

//iteration for Gender, Device and Nationality Plural

-(NSArray *)iterateOnSegmentKindLocation: (NSDictionary *)jsonData{
    NSDictionary *locations = [jsonData objectForKey:TARGET_IS_LOCATION];
    NSMutableArray *locationList = [[NSMutableArray alloc] init];
    
    for(NSDictionary *location in locations){
        [locationList addObject:[self iterateOnUnmanedLocationSegment:location]];
    }
    
    return [[NSArray alloc] initWithArray:locationList];
}

-(NSArray *)iterateOnSegmentKindGender: (NSDictionary *)jsonData{
    NSDictionary *genders = [jsonData objectForKey:TARGET_IS_GENDER];
    NSMutableArray *genderList = [[NSMutableArray alloc] init];
    
    for(NSDictionary *gender in genders){
        [genderList addObject:[self iterateOnUnmanedSegment:gender]];
    }
    
    return [[NSArray alloc] initWithArray:genderList];
}

-(NSArray *)iterateOnSegmentKindNationality: (NSDictionary *)jsonData{
    NSDictionary *countries = [jsonData objectForKey:TARGET_IS_NATIONALITY];
    NSMutableArray *countryList = [[NSMutableArray alloc] init];
    
    for(NSDictionary *country in countries){
        [countryList addObject:[self iterateOnUnmanedSegment:country]];
    }
    
    return [[NSArray alloc] initWithArray:countryList];
}

-(NSArray *)iterateOnSegmentKindDevice: (NSDictionary *)jsonData{
    NSDictionary *devices = [jsonData objectForKey:TARGET_IS_DEVICE];
    NSMutableArray *deviceList = [[NSMutableArray alloc] init];
    
    for(NSDictionary *device in devices){
        [deviceList addObject:[self iterateOnUnmanedSegment:device]];
    }
    
    return [[NSArray alloc] initWithArray:deviceList];
}


#pragma mark - Iteration Singular

//iteration for Gender, Device and Nationality Singular
-(HLSegment *)iterateOnUnmanedSegment: (NSDictionary *)unmanedJson{
    HLSegment *segment = [[HLSegment alloc] init];
    segment->_segmentId = [[unmanedJson objectForKey:COMMON_KEY_ID] copy];
    
    [segment setSegmentName:[unmanedJson objectForKey:TARGET_NAME]];
    [segment setSegmentKey:[unmanedJson objectForKey:TARGET_KEY]];
    
    return segment;
}

-(HLSegment *)iterateOnUnmanedLocationSegment: (NSDictionary *)unmanedJson{
    HLSegment *segment = [[HLSegment alloc] init];
    segment->_segmentId = [[NSNumber numberWithInt:[[unmanedJson objectForKey:COMMON_KEY_ID] floatValue]] copy];

    [segment setSegmentLocationCoordinate:CLLocationCoordinate2DMake([[unmanedJson objectForKey:TARGET_LOCATION_LATITUDE] floatValue],
                                                                   [[unmanedJson objectForKey:TARGET_LOCATION_LONGITUDE] floatValue])];
    
    [segment setSegmentLocationRadius:[NSNumber numberWithFloat:[[unmanedJson objectForKey:TARGET_LOCATION_RADIUS] floatValue]]];
    
    return segment;
}

@end
