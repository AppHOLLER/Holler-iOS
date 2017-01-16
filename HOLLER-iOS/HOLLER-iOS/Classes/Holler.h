//
//  Holler.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "HLError.h"

@interface Holler : NSObject

/*!
 *  @brief HOLLER need your ApplicationId and AccessId to activate service on iOS device
 *
 *  @param appId    ApplicationId get from HOLLER's dashboard
 *  @param accessId AccessId get from HOLLER's dashboard
 *
 *  @since 0.0.1
 */
+(void)startHolleringWithApplicationId: (NSString *)appId
                              accessId: (NSString *)accessId;

/*!
 *  @brief address didLauncAppWithOptions with ApplicationId and AccessId is wrapped in launch options (inside your projectName.infolist file)
 *
 *  @param options is launchOptions that read file from yourProjectName.infolist file
 *
 *  @return Either YES/NO to indicate HOLLER SDK can retrieve your application ID and access ID successfully
 *
 *  @since 0.0.1
 */
+(BOOL)didFinishLaunchingWithOptions: (NSDictionary *)options;

/*!
 *  @brief address applicationWillTerminate to begin analytic process, HOLLER retrieves this event as last step to lock down user behaviour tracking
 *
 *  @param application is returned from appDelegates
 *
 *  @since 0.0.1
 */
+(void)applicationWillTerminate: (UIApplication *)application;

/*!
 *  @brief address applicatiomDidBecomeActive to begin analytic process, HOLLER retrieves this event as first step for user behaviour tracking
 *
 *  @param application is return from appDelegates
 *
 *  @since 0.0.1
 */
+(void)applicationDidBecomeActive: (UIApplication *)application;

/*!
 *  @brief address didReceiveRemoteNotification to begin analytic process, HOLLER retrieve insight data and content to track your user
 *
 *  @param userInfo payload of notification, which is specified to HOLELR's Push Notification Service (APNs and Google Cloud Messaging)
 *
 *  @since 0.01
 */
+(void)didReceiveRemoteNotification: (NSDictionary *)userInfo;

/*!
 *  @brief address didRegisterForRemoteNotificationWithDeviceToken, HOLLER specified your user to activate push notification service
 *
 *  @param deviceToken deviceToken under binary data (NSData*), HOLLER automatically detach and access this one
 *
 *  @since 0.0.1
 */
+(void)didRegisterForRemoteNotificationWithDeviceToken: (NSData *)deviceToken;

@end
