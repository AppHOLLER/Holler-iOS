//
//  HLError.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/19/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLConstants.h"

/*!
 *  @brief HOLLER SDK specifies ERROR Code that return from HOLLER server
 *
 *  @since 0.0.1
 */
typedef NS_ENUM(NSUInteger, HLHTTPErrorCode) {
    /*!
     *  Internal Server Error
     *
     *  @since 0.0.1
     */
    HL_SERVER_ERROR = 500,
    /*!
     *  Request To Server Successfully
     *
     *  @since 0.0.1
     */
    HL_REQUEST_SUCCEED = 200,
    /*!
     *  Request has semantically erroneous
     *
     *  @since 1.2
     */
    HL_SEMANTIC_ERROR = 422,
    /*!
     *  Request To Removed or Not Existed Resource
     *
     *  @since 0.0.1
     */
    HL_REQUEST_NOT_FOUND = 404,
    /*!
     *  Request Is Forbidden
     *
     *  @since 0.0.1
     */
    HL_REQUEST_FORBIDDEN = 403,
    /*!
     *  Request Is Denied
     *
     *  @since 0.0.1
     */
    HL_REQUEST_PAYMENT_REQUIRED = 402,
    /*!
     *  Request Is Unthorise
     *
     *  @since 0.0.1
     */
    HL_REQUEST_UNAUTHORISED = 401,
    /*!
     *  Bad Request
     *
     *  @since 0.0.1
     */
    HL_REQUEST_BAD = 400,
    /*!
     *  Error undefined
     *
     *  @since 0.0.1
     */
    HL_REQUEST_ERROR_UNDEFINED
};

@class HLError;
@interface HLError : NSObject

/*!
 *  @brief Error code specified by HOLLER
 *
 *  @since 0.0.1
 */
@property(nonatomic, readonly) HLHTTPErrorCode errorCode;

/*!
 *  @brief Error description that is serialised from Server info
 *
 *  @since 0.0.1
 */
@property(nonatomic, nullable, readonly) NSDictionary *errorDescription;

/*!
 *  @brief Error status with numeric data
 *
 *  @since 0.0.1
 */
@property(nonatomic, nonnull, readonly) NSNumber *errorStatus;

/*!
 *  @brief Initialise a "fresh" error object to wrap error inside
 *
 *  @return this return error model
 *
 *  @since 0.0.1
 */
-(nonnull instancetype)init;

/*!
 *  @brief Initialise a error object with payload error returned
 *
 *  @param jsonData payload error return from HOLLER server. Forbidden
 *
 *  @return this return error model
 *
 *  @since 0.0.1
 */
-(nonnull instancetype)initWithJsonData: (nonnull NSDictionary *)jsonData;

@end
