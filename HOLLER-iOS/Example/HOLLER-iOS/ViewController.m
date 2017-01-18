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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
