//
//  HLTracking.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/18/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Holler/HLError.h>

extern NSString *deviceOS;
extern NSString *trackedRemark;


typedef NS_ENUM(NSUInteger, HLLogLevel){
    HLLogLevelNone,
    HLLogLevelError,
    HLLogLevelWarning,
    HLLogLevelInfo,
    HLLogLevelVerbose,
};


@protocol HLLogger <NSObject>

@property(nonatomic, assign) HLLogLevel logLevel;

@required

-(void)logAtErrorLevel: (NSString *)message;
-(void)logAtWarningLevel: (NSString *)message;
-(void)logAtInfoLevel: (NSString *)message;
-(void)logAtVerboseLevel: (NSString *)message;

@end

@protocol HLExceptionTracker <NSObject>

@property(nonatomic, readonly) NSString *HLExceptionTrackerName;

@required
-(void)setTrackerName: (NSString *)name value: (NSString *)value;
-(void)getTrackerName: (NSString *)name;

@end


@interface HLAnalytic : NSObject

/*!
 *  @brief variable of HLAnalytic determines should HOLLER Analytic automatic log uncaught exception that thrown out while application is executing
 *
 *  @since 0.0.1
 */
@property(nonatomic, assign) BOOL analyticUncaughtException;

/*!
 *  @brief variable of HLAnalytic determines should HOLLER Analytic run in dry run mode
 *
 *  @since 0.0.1
 */
@property(nonatomic, assign) BOOL analyticDryRunMode;

/*!
 *  @brief variable of HLAnalytic determine should HOLLER Analytic prompt out all exception that thrown out while application is executing
 *
 *  @since 0.0.1
 */
@property(nonatomic, assign) BOOL promptOut;

/*!
 *  @brief interface inherited for logger manager
 *
 *  @since 0.0.1
 */
@property(nonatomic, retain) id<HLLogger> analyticLogger;

/*!
 *  @brief interface inherited for analytic tracker manager;
 *
 *  @since 0.0.1
 */
@property(nonatomic, retain) id<HLExceptionTracker> analyticTracker;

/*!
 *  @brief initialise a singleton instance of HLAnalytic
 *
 *  @return a singleton instance (by pattern)
 *
 *  @since 0.0.1
 */
+(instancetype)defaultAnalytic;

/*!
 *  @brief track event app is active. This event should be called inside AppDelegate only
 *
 *  @param subscriberId unique id of subscriber who already registered and managed by HOLLER
 *  @param completion   asynchronous block
 *
 *  @since 0.0.1
 */
-(void)trackOpenedUsageFromNowBySubscriberId: (NSNumber *)subscriberId
                                onCompletion: (void (^)(BOOL succeed, HLError *error))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief track event app is inactive/terminated. This event should be called inside AppDelegate only
 *
 *  @param subscriberId unique id of subscriber who already register and managed by HOLLER
 *  @param completion   asynchronous block
 *
 *  @since 0.0.1
 */
-(void)trackClosedUsageFromNowBySubscriberId: (NSNumber *)subscriberId
                                onCompletion: (void (^)(BOOL succeed, HLError *error))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief track event app is active silently. Doesn't provide callback block, this will be executed silently
 *
 *  @param subscriberId unique id of subscribes who already register and managed by HOLLER
 *
 *  @since 0.0.1
 */
-(void)trackOpenedUsageFromNowSilentlyBySubscriberId: (NSNumber *)subscriberId NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief track event app is inactive/terminated silently. Doesn't provide callback block, this will be executed silently
 *
 *  @param subscriberId unique id of subscriber who already register and managed by HOLLER
 *
 *  @since 0.0.1
 */
-(void)trackClosedUsageFromNowSilentlyBySubscriberId: (NSNumber *)subscriberId NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief track event app is active. To call this method, you must guarantee current device of subscriber was registered already before and subscriber must register for event Subscriber register. Unless exception will throw back
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
-(void)trackOpenedUsageFromNowOnCompletion: (void (^)(BOOL succeed, HLError *error))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief track event app is inactive/terminated. Too call this method you must guarantee current device of subscriber was registered already before and subscriber must register for event Subscriber register. Unless exception will throw back
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
-(void)trackClosedUsageFromNowOnCompletion: (void (^)(BOOL succeed, HLError *error))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief track event app is active. Too call this method you must guarantee current device of subscriber was registered already before and subscriber must register for event Subscriber register. Unless exception will throw back
 *
 *  @since 0.0.1
 */
-(void)trackOpenedUsageFromNowSilently;

/*!
 *  @brief track event app is inactive/terminated. Too call this method you must guarantee current device of subscriber was registered already before and subscriber must register for event Subscriber register. Unless exception will throw back
 *
 *  @since 0.0.1
 */
-(void)trackClosedUsageFromNowSilently;

@end
