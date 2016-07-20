//
//  HLSubscriber.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Holler/HLError.h>

/*!
 *  @brief HLSubscriber represents to Subscriber that managed by HOLLER. Each subscriber have an unique device that can receive Push Notification, SMS Email and Email
 *
 *  @since 0.0.1
 */
@interface HLSubscriber : NSObject

/*!
 *  @brief unique id of subscriber
 *
 *  @since 0.0.1
 */
@property(atomic, readonly) NSNumber *subscriberId;

/*!
 *  @brief date subscriber was created
 *
 *  @since 0.0.1
 */
@property(nonatomic, readonly) NSDate *subscriberCreatedDate;

/*!
 *  @brief latest date subscriber was updated/modified
 *
 *  @since 0.0.1
 */
@property(nonatomic, readonly) NSDate *subscriberUpdatedDate;

/*!
 *  @brief status determines subscriber is currently active/inactive
 *
 *  @since 0.0.1
 */
@property(nonatomic, readonly) NSNumber *subscriberIsActive;

/*!
 *  @brief device token of smartphone belongs to subscriber
 *
 *  @since 0.0.1
 */
@property(nonatomic, weak) NSString *subscriberDeviceToken;

/*!
 *  @brief username subscriber registered for HOLLER service
 *
 *  @since 0.0.1
 */
@property(nonatomic, weak) NSString *subscriberUsername;

/*!
 *  @brief email of subscriber registered for HOLLER service
 *
 *  @since 0.0.1
 */
@property(nonatomic, weak) NSString *subscriberEmail;

/*!
 *  @brief firstname of subscriber registered for HOLLER service
 *
 *  @since 0.0.1
 */
@property(nonatomic, weak) NSString *subscriberFirstName;

/*!
 *  @brief lastname of subscriber registered for HOLLER service
 *
 *  @since 0.0.1
 */
@property(nonatomic, weak) NSString *subscriberLastName;

/*!
 *  @brief status determines subscriber is currently active/inactive
 *
 *  @since 0.0.1
 */
@property(nonatomic, weak) NSNumber *subscriberActiveStatus;

/*!
 *  @brief cellphone number belongs to subscriber registered for HOLLER service
 *
 *  @since 0.0.1
 */
@property(nonatomic, weak) NSString *subscriberCellphoneNumber;

/*!
 *  @brief information K-V data contains demographic target of subscriber to send out campaign
 *
 *  @since 0.0.1
 */
@property(nonatomic, weak) NSDictionary *subscriberInformations;

/*!
 *  @brief initialise blank HLSubscriber instance
 *
 *  @return HLSubscriber (blank) instance will be returned
 *
 *  @since 0.0.1
 */
-(instancetype)init;

/*!
 *  @brief initialise HLSubscriber instance with a json data retrieve from HOLLER
 *
 *  @param jsonData K-V pair data contains information/data of subscriber need to be serialise to a HLSubscriber
 *
 *  @return HLSubscriber instance will be returned
 *
 *  @since 0.0.1
 */
-(instancetype)initWithJsonData: (NSDictionary *)jsonData NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief update subscriber by id. Calling this method as asynchronous callback block
 *
 *  @param subscriberId unique id of subscriber, that is registered
 *  @param completion   asynchronous block
 *
 *  @since 0.0.1
 */
-(void)updateBySubscriberId: (NSNumber *)subscriberId
               onCompletion: (void (^)(BOOL, HLError*))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief update subscriber by id. Calling this method as "Call-Forget" mechanism
 *
 *  @param subscriberId unique id of subscriber, that is registered
 *
 *  @since 0.0.1
 */
-(void)updateBySubscriberIdSilently: (NSNumber *)subscriberId NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief register subscriber. Calling this method as asynchronous callback block
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
-(void)registerSubscriberOnCompletion: (void (^)(BOOL,HLError*, NSNumber*))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief register subscriber in silent mode. Calling this method as "Call-Forget" mechanism
 *
 *  @since 0.0.1
 */
-(void)registerSubscriberSilently NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief fetch/get all subscribers. Calling this method as asynchronous callback method
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchListSubscriberOnCompletion: (void (^)(BOOL,HLError*, NSArray*))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief fetch/get total of subscribers who are registered for HOLLER
 *
 *  @param completion asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchTotalSubscriberOnCompletion: (void (^)(BOOL, HLError*, NSUInteger))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief fetch/get subscriber data by subscriberId. Calling this method as asynchronos callback method
 *
 *  @param subscriberId unique id of subscriber
 *  @param completion   asynchronous block
 *
 *  @since 0.0.1
 */
+(void)fetchSubscriberId: (NSNumber *)subscriberId
            onCompletion: (void (^)(BOOL, HLError*, HLSubscriber*))completion NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief generate K-V pair casted NSDictionary of information contain demographic targets of subscriber. Note: Subscriber has properties named "gps_longitude" and "gps_latitude". This requires you to enable CoreLocation service to get accurated coordinate of subscriber's device.
 *
 *  @return K-V pair data casted NSDictionary
 *
 *  @since 0.0.1
 */
+(NSDictionary *)generateInformationDictionary NS_AVAILABLE_IOS(8_0);

/*!
 *  @brief brief generate K-V pair casted NSDictionary of information contain demographic targets of subscriber. Note: Subscriber has properties named "gps_longitude" and "gps_latitude". This requires you to enable CoreLocation service to get accurated coordinate of subscriber's device.
 *
 *  @param latitude    latitude coordinate by float value casted NSNumber pointer
 *  @param longitude   longitude coordinate by float value casted NSNumber pointer
 *  @param gender      gender/sex of subscriber by string value
 *  @param dateOfBirth date of birth represents in string value
 *  @param country     country name of subscriber by string value
 *  @param industry    industry in which subscriber works in by string value
 *  @param designation designature of subscriber by string value
 *  @param interestId  interest_id that represent interest/favourite of subscriber by string value
 *
 *  @return K-V pair data casted NSDictionary
 *
 *  @since 0.0.1
 */
+(NSDictionary *)generateInformationDictionaryStartingLatitude: (NSNumber *)latitude
                                                     longitude: (NSNumber *)longitude
                                                        gender: (NSString *)gender
                                                   dateOfBirth: (NSString *)dateOfBirth
                                                       country: (NSString *)country
                                                      industry: (NSString *)industry
                                                   designation: (NSString *)designation
                                                    interestId: (NSString *)interestId;
@end
