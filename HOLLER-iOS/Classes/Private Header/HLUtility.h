//
//  HLUtility.h
//  Holler_iOS_SDK
//
//  Created by Phong Nguyen on 4/15/16.
//  Copyright © 2016 Rainmaker Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HLUtility : NSObject

+(NSDate *)conformDateToFormat: (NSString *)date format: (NSString *)format;
+(NSDate *)conformDateToHOLLERFormat: (NSString *)date;

@end
