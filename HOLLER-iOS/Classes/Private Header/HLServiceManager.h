//
//  HLServiceManager.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/14/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class HLMiscellaneous;
@class HLError;

/*!
 *  @brief HOLLER HTTP method enum to specify service
 *
 *  @since 0.0.1
 */
typedef NS_ENUM(NSUInteger, HLHTTPMethod) {
    /*!
     *  POST Method
     *
     *  @since 0.0.1
     */
    HL_HTTP_POST,
    /*!
     *  GET Method
     *
     *  @since 0.0.1
     */
    HL_HTTP_GET,
    /*!
     *  PUT Method
     *
     *  @since 0.0.1
     */
    HL_HTTP_PUT,
    /*!
     *  PATCH Method
     *
     *  @since 0.0.1
     */
    HL_HTTP_PATCH,
    /*!
     *  DELETE Method
     *
     *  @since 0.0.1
     */
    HL_HTTP_DELETE
};

@interface HLServiceManager : NSObject

/*!
 *  @brief Singleton pattern applied to create class instance
 *
 *  @return singleton instance of class
 *
 *  @since 0.0.1
 */
+(id)standardManager;

/*!
 *  @brief execute a RESTful request with wrapped credentials (appId and accessId) inside to HOLLER server (Asynchronous)
 *
 *  @param HTTPRequest Path of API specified
 *  @param method      Method of API
 *  @param params      Json param to be executed
 *  @param completion  Asynchronous block to retrieve response and error object (if any) from HOLLER server
 *
 *  @since 0.0.1
 */
-(void)executeRESTRequestWithCredential: (NSString *)HTTPRequest
                                 method: (HLHTTPMethod)method
                                 params: (NSDictionary *)params
                           onCompletion: (void (^)(BOOL, NSError*, HLError*, id))completion;

/*!
 *  @brief execute a RESTful request with wrapped credentials (appId and accessId) inside to HOLLER server with specified object (Asynchronous). Mostly for update/delete/fetch object
 *
 *  @param HTTPRequest Path of API specified
 *  @param method      Method of API
 *  @param objectId    Object Id specified to Anonymous object managed by HOLLER
 *  @param completion  Asynchronous block to retrieve response and error object (if any) from HOLLER server
 *
 *  @since 0.0.1
 */
-(void)executeRESTRequestWithCredential: (NSString *)HTTPRequest
                                 method: (HLHTTPMethod)method
                               objectId: (NSString *)objectId
                           onCompletion: (void (^)(BOOL, NSError*, HLError*, id))completion;

/*!
 *  @brief execute a RESTful request with wrapped credentials (appId and accessId) inside to HOLLER server with specified object (Asynchronous). Mostly for update/delete/fetch with Json type
 *
 *  @param HTTPRequest Path of API specified
 *  @param method      Method of API
 *  @param objectId    Object Id specified to Anonymous object managed by HOLLER
 *  @param params      Json param to be executed
 *  @param completion  Asynchronous block to retrieve response and error object (if any) from HOLLER server
 *
 *  @since 0.0.1
 */
-(void)executeRESTRequestWithCredential: (NSString *)HTTPRequest
                                 method: (HLHTTPMethod)method
                               objectId: (NSString *)objectId
                                 params: (NSDictionary *)params
                           onCompletion: (void (^)(BOOL, NSError*, HLError*, id))completion;

/*!
 *  @brief execute a RESTful request withouth credential wraps inside
 *
 *  @param HTTPRequest Path of API specified
 *  @param method      Method of API
 *  @param params      Data under Json format to be executed and sent to HOLLER server
 *  @param headers     Credential K-V Pair
 *  @param completion  Asynchronous block to retrieve response and error object (if any) from HOLLER server
 *
 *  @since 0.0.1
 */
-(void)executeRESTRequest: (NSString *)HTTPRequest
                   method: (HLHTTPMethod)method
                   params: (NSDictionary *)params
                  headers: (NSDictionary *)headers
             onCompletion: (void (^)(BOOL, NSError*, HLError*, id))completion;

/*!
 *  @brief upload task by HTTP data binary withouth credential wraps inside
 *
 *  @param HTTPRequest Path of API specified
 *  @param method      Method of API
 *  @param data        Binary data to be executed and sent to HOLLER server
 *  @param params      Param to specified on HTTP URL
 *  @param headers     Credential K-V Pair
 *  @param completion  Asynchronous block to retrieve response and error object (if any) from HOLLER server
 *
 *  @since 0.0.1
 */
-(void)uploadRESTRequest: (NSString *)HTTPRequest
                  method: (NSString *)method
                    data: (NSData *)data
                  params: (NSDictionary *)params
                 headers: (NSDictionary *)headers
            onCompletion:(void (^)(BOOL, NSError*, HLError*, id))completion;

/*!
 *  @brief upload task by HTTP data binary with wrapped credentials
 *
 *  @param HTTPRequest Path of API specified
 *  @param method      Method of API
 *  @param data        Binary data to be executed and sent to HOLLER server
 *  @param params      Param to specified on HTTP URL
 *  @param completion  Asynchronous block to retrieve response and error object (if any) from HOLLER server
 *
 *  @since 0.0.1
 */
-(void)uploadRESTRequestWithCredential: (NSString *)HTTPRequest
                                method: (HLHTTPMethod)method
                                  data: (NSData *)data
                                params: (NSDictionary *)params
                          onCompletion: (void (^)(BOOL, NSError*, HLError*, id))completion;

/*!
 *  @brief upload task by HTTP data binary with wrapped credentials
 *
 *  @param HTTPRequest Path of API specified
 *  @param method      Method of API
 *  @param data        Binary data to be executed and sent to HOLLER server
 *  @param objectId    Object Id specified to Anonymous object managed by HOLLER
 *  @param completion  Asynchronous block to retrieve response and error object (if any) from HOLLER server
 *
 *  @since 0.0.1
 */
-(void)uploadRESTRequestWithCredential: (NSString *)HTTPRequest
                                method: (HLHTTPMethod)method
                                  data: (NSData *)data
                              objectId: (NSString *)objectId
                          onCompletion: (void (^)(BOOL, NSError*, HLError*, id))completion;

@end
