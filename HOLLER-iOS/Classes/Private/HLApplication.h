//
//  HLApplication.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HLError.h>

/*!
 *  @brief HOLLER provide application with two modes for Push Notification Service includes Sanbox (Development) and Production in term Apple APNs
 *
 *  @since 0.0.1
 */
typedef NS_ENUM(NSInteger, HLAPNSEnvironmentMode) {
    /*!
     *  Sanbox Mode
     *
     *  @since 0.0.1
     */
    HLAPNSENVSANDBOX,
    /*!
     *  Production Mode
     *
     *  @since 0.0.1
     */
    HLAPNSENVPRODUCTION
};

@interface HLApplication : NSObject

/*!
 *  @brief application Id of current application in Holler database service
 *
 *  @since 0.0.1
 */
@property(nonnull, atomic, readonly) NSNumber *applicationId;

/*!
 *  @brief application name of current application
 *
 *  @since 0.0.1
 */
@property(nonnull, nonatomic, readonly) NSString *applicationName;

/*!
 *  @brief application accessId, this one is use for authentication and authorisation
 *
 *  @since 0.0.1
 */
@property(nonnull, readonly) NSString *applicationAccessId;

/*!
 *  @brief application description
 *
 *  @since 0.0.1
 */
@property(nullable, nonatomic, readonly) NSString *applicationDescription;

/*!
 *  @brief name of Apple APNs certification file with extension .pem (file extension of Apple, which is converted from .p12)
 *
 *  @since 0.0.1
 */
@property(nullable, nonatomic, readonly) NSString *applicationAPNsFile;

/*!
 *  @brief application GCM (Google Cloud Messaging) credential
 *
 *  @since 0.0.1
 */
@property(nullable, nonatomic, readonly) NSString *applicationGCMCredential;

/*!
 *  @brief application timezone, specified by app that is configured at the beginning
 *
 *  @since 0.0.1
 */
@property(nonnull, nonatomic, readonly) NSTimeZone *applicationTimeZone;

/*!
 *  @brief application logo image
 *
 *  @since 0.0.1
 */
@property(nonnull, nonatomic, readonly) NSObject *applicationLogoImage;

/*!
 *  @brief environment/mode of Apple APNs, APNs is specified by two modes consist of: Sandbox (Development) and Production
 *
 *  @since 0.0.1
 */
@property(nonatomic, readonly) HLAPNSEnvironmentMode applicationAPNSEnv;

/*!
 *  @brief application date which is created on HOLLER service
 *
 *  @since 0.0.1
 */
@property(nonnull, nonatomic, readonly) NSDate *applicationCreatedDate;

/*!
 *  @brief application date which is update by latest on HOLLER service
 *
 *  @since 0.0.1
 */
@property(nonatomic, nonnull, readonly) NSDate *applicationUpdatedDate;

/*!
 *  @brief demo-able member of application, application is included: Demo-able and Developer. In Demo-able mode, app is connected to HOLLER demo app, this is for testing purpose only. So please specified your applicationId carefully
 *
 *  @since 0.0.1
 */
@property(nonatomic, nonnull, readonly) NSNumber *applicationIsDemoable;


/*!
 *  @brief Fetch/Get/Retrive an application that specified by application Id (Asynchronous)
 *
 *  @param applicationId applicationId get from HOLLER's dashboard
 *  @param completion    accessId get from HOLLER's dashboard
 *
 *  @since 0.0.1
 */
+(void)fetchApplicationById: (nonnull NSString *)applicationId
               onCompletion: (nonnull void (^)(BOOL, HLError * _Nullable, HLApplication *_Nullable))completion NS_AVAILABLE_IOS(8_0);

@end
