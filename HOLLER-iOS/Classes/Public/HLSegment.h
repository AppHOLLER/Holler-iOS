//
//  HLTarget.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "HLError.h"

typedef NS_ENUM(NSInteger, HLSegmentType){
    HLSegmentIsNationality,
    HLSegmentIsLocation,
    HLSegmentIsGender,
    HLSegmentIsDevice,
    HLSegmentIsUndefined
};

@interface HLSegment : NSObject

/*!
 *  @brief unique id of target
 *
 *  @since 0.0.1
 */
@property(atomic, nonnull, readonly) NSNumber *segmentId;

/*!
 *  @brief name of segment
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *segmentName;

/*!
 *  @brief key of segment. K-V Pair
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *segmentKey;

/*!
 *  @brief location name of segment in case segment is location
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *segmentLocationName;

/*!
 *  @brief coordinate of segment. Mixed of longitude and latitude, use CLLocationCoordinate2D of CoreLocation framework
 *
 *  @since 0.0.1
 */
@property(nonatomic, assign) CLLocationCoordinate2D segmentLocationCoordinate;

/*!
 *  @brief radius of location that is distance from center of circular that make from coordinate to create a proximity that cover all subscriber in field
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSNumber *segmentLocationRadius;
    
/*!
 *  @brief type of segment
 *
 *  @since 0.0.1
 */
@property(nonatomic, assign) HLSegmentType segmentType;

/*!
 *  @brief initialise a blank segment
 *
 *  @return instance of HLSegment
 *
 *  @since 1.2
 */
-(nonnull)init;

/*!
 *  @brief initialise a segment from a jsondata retrieve from HOLLER. This's going to serialise json data to match HLSegment's member
 *
 *  @param jsonData K-V pair retrieve from HOLLER
 *
 *  @return instance of HLSegment
 *
 *  @since 0.0.1
 */
-(nonnull id)initWithJson: (nonnull NSDictionary *)json NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of devices segment to subscriber's deviceOS
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListDeviceSegmentOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of gender (essentially there're two: Male and Female)
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListGenderSegmentOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of country segment to subscriber living geographically
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListNationalitySegmentOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

@end
