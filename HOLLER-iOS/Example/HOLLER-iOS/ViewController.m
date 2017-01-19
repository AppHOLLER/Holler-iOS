//
//  ViewController.m
//  HOLLER-iOS
//
//  Created by KhuongPham on 12/16/2016.
//  Copyright (c) 2016 KhuongPham. All rights reserved.
//

#import "ViewController.h"
#import "../../HOLLER-iOS/Classes/HLSubscriber.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
   
}
- (IBAction)updateSubscriberId:(id)sender {

}

- (IBAction)triggerSubscriberEvent:(id)sender {
    [HLSubscriber triggerSubscriberEvent:@6517 event:@"register" onCompletion:^(BOOL success, HLError * error, HLSubscriber * subscriber) {
        if (error) {
            //handle error object with description and error status
            NSLog(@"Error");
        } else {
            //succeed. subscriberId'll returned back
            NSLog(@"Success");
        }
    }];
}

- (IBAction)totalSubscribers:(id)sender {
    [HLSubscriber fetchTotalSubscriberOnCompletion:^(BOOL success, HLError *error, NSUInteger total) {
        if (error) {
            //handle error object with description and error status
            NSLog(@"Error");
        } else {
            //succeed. subscriberId'll returned back
            NSLog(@"Success! Total: %lu", (unsigned long)total);
        }
    }];
}

- (IBAction)fetchSubscriberId:(id)sender {
    [HLSubscriber fetchSubscriberId:@6517 onCompletion:^(BOOL success, HLError *error, HLSubscriber *subscriber) {
        if (error) {
            //handle error object with description and error status
            NSLog(@"Error");
        } else {
            //succeed. subscriberId'll returned back
            NSLog(@"Success");
            [subscriber updateBySubscriberId:@6517 onCompletion:^(BOOL success, HLError * error) {
                if (error) {
                    //handle error object with description and error status
                    NSLog(@"Error");
                } else {
                    //succeed. subscriberId'll returned back
                    NSLog(@"Success");
                }
            }];
        }
    }];
}

- (IBAction)fetchListSubscriber:(id)sender {
    
    [HLSubscriber fetchListSubscriberOnCompletion:^(BOOL success, HLError * error, NSArray * subscribers) {
        
        if (error) {
            //handle error object with description and error status
            NSLog(@"Error");
        } else {
            //succeed. subscriberId'll returned back
            NSInteger count = [subscribers count];
            NSLog(@"Success");
        }
        
    }];
    
}

- (IBAction)regristerPushNotification:(UIButton *)sender {
    HLSubscriber *subscriber = [[HLSubscriber alloc] init];
    [subscriber setSubscriberFirstName:@"rain"];
    [subscriber setSubscriberLastName:@"maker"];
    [subscriber setSubscriberEmail:@"nguyenhuynh2688@gmail.com"];
    [subscriber setSubscriberUsername:@"rainMaker"];
    [subscriber setSubscriberCellphoneNumber:@"841233744033"];
    
    [subscriber setSubscriberInformations:@{@"gps_latitude": @0,
                                            @"gps_longitude": @0,
                                            @"gender": @"male",
                                            @"date_of_birth": @"2016/6/12",
                                            @"country": @"SG",
                                            @"industry": @"",
                                            @"designation": @"",
                                            @"interest_id": @""}];
    [subscriber registerSubscriberOnCompletion:^(BOOL succeed, HLError *error, NSNumber *subscriberId) {
        if (error) {
            //handle error object with description and error status
            NSLog(@"Error");
        } else {
            //succeed. subscriberId'll returned back
            NSLog(@"Success");
        }
    }];
}

@end
