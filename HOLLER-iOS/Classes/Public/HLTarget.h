//
//  HLTarget.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <HLError.h>

typedef NS_ENUM(NSInteger, HLTargetType){
    HLTargetIsIndustry,
    HLTargetIsInterest,
    HLTargetIsDesignation,
    HLTargetIsCountry,
    HLTargetIsLocation,
    HLTargetIsGender,
    HLTargetIsDevice,
    HLTargetIsUndefined
};

@interface HLTarget : NSObject

/*!
 *  @brief unique id of target
 *
 *  @since 0.0.1
 */
@property(atomic, nonnull, readonly) NSNumber *targetId;

/*!
 *  @brief industry name of target in case target is industry
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *targetIndustryName;

/*!
 *  @brief interest name of target in case target is interest
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *targetInterestName;

/*!
 *  @brief designation name of target in case target is designation
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *targetDesignatioName;

/*!
 *  @brief application id owe target. Each application had different targets which are created by user
 *
 *  @since 0.0.1
 */
@property(nullable, nonatomic, weak) NSString *targetApplicationId;

/*!
 *  @brief boolean status determines status "published" of target. A target is published is available to use to target to subscriber in segmentation
 *
 *  @since 0.0.1
 */
@property(nullable, nonatomic, weak) NSNumber *targetIsPublished;

/*!
 *  @brief name of target
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *targetName;

/*!
 *  @brief key of target. K-V Pair
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *targetKey;

/*!
 *  @brief location name of target in case target is location
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSString *targetLocatioName;

/*!
 *  @brief coordinate of target. Mixed of longitude and latitude, use CLLocationCoordinate2D of CoreLocation framework
 *
 *  @since 0.0.1
 */
@property(nonatomic, assign) CLLocationCoordinate2D targetLocationCoordinate;

/*!
 *  @brief radius of location that is distance from center of circular that make from coordinate to create a proximity that cover all subscriber in field
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, weak) NSNumber *targetLocationRadius;

/*!
 *  @brief initialise a blank target
 *
 *  @return instance of HLTarget
 *
 *  @since 0.0.1
 */
-(nonnull)init;

/*!
 *  @brief initialise a target from a jsondata retrieve from HOLLER. This's going to serialise json data to match HLTarget's member
 *
 *  @param jsonData K-V pair retrieve from HOLLER
 *
 *  @return instance of HLTarget
 *
 *  @since 0.0.1
 */
-(nonnull id)initWithJsonData: (nonnull NSDictionary *)jsonData NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief initialise an array of target by list of mixed targets
 *
 *  @param jsonData K-V pair retrieve from HOLLER
 *
 *  @return instance of HLTarget
 *
 *  @since 0.0.1
 */
-(nonnull NSArray *)iterateWithJsonData: (nonnull NSDictionary *)jsonData NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of devices target to subscriber's deviceOS
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListDeviceOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of gender (essentially there're two: Male and Female)
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListGenderOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of country target to subscriber living geographically
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListCountryOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of location target to subscriber's location currently
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListLocationOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of designation target to subscriber's job position/role currently. Like: Product Manager, Project Manager, VP Engineering, etc.
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListDesignationOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of interest target to subscriber's interest. Like: fashion, shopping, Video game, etc.
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListInterestOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief get/fetch list of industry target to subscriber's career industry/working area. Like: Petroleum, Automobile, Health & Medical, etc.
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListIndustryOnCompletion: (nonnull void (^)(BOOL, HLError* _Nullable, NSArray* _Nullable))completion NS_AVAILABLE_IOS(8_0);

@end
