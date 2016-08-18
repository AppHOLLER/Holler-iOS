# HOLLER-iOS

[![CI Status](http://img.shields.io/travis/Phong Nguyen/HOLLER-iOS.svg?style=flat)](https://travis-ci.org/Phong Nguyen/HOLLER-iOS)
[![Version](https://img.shields.io/cocoapods/v/HOLLER-iOS.svg?style=flat)](http://cocoapods.org/pods/HOLLER-iOS)
[![License](https://img.shields.io/cocoapods/l/HOLLER-iOS.svg?style=flat)](http://cocoapods.org/pods/HOLLER-iOS)
[![Platform](https://img.shields.io/cocoapods/p/HOLLER-iOS.svg?style=flat)](http://cocoapods.org/pods/HOLLER-iOS)

__HOLLER__ is a delightful Mobile Marketing Automation (MMA) SDK, offcially provide by Rainmaker Labs Pte. Build upon strong MMA platform of Rainmaker Labs to make Mobile Marketing with ease and effortless. HOLLER empower every mobile app with strong built-in Push Notification, SMS and Email use segmentation target your audiences everywhere. We help your mobile app with ability Deliver right content at eligible moment to correct user.
We love to hear from your project use our SDK. 

## Installation

### Installation with CocoaPods
CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like HOLLER in your projects. See the "Getting Started" guide for more information. You can install it with the following command:

```ruby
$ gem install cocoapods
```

#### Podfile

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'HOLLER-iOS', '~> 0.0.2'
end
```

Then, run the follow command:
```ruby
$ pod install
```

## Requirements

iOS 8.0 or above

## Architecture
### Communication
> * HLCommunication
> * HLPush
> * HLSMS
> * HLEMD

### Segmentation
> * HLSubscriber
> * HLTarget

### Analytics & Insight
> * HLAnalytic

## Usage
### Subscriber
Subscriber is mobile user subscribes to your service, managed well by HOLLER platform. These user's able to receive notification through mobile marketing campaign which is handled by HOLLER.
Each subscriber live in difference places in the world, works in industries, and assigned to several positions (designations) with responsibilities. Some of them prefer mobile apps as hobbies rather than other entertainment.

#### Create a new Subscriber
You can create new subscriber in silent mode by adding the following code:

```ObjC
HLSubscriber *subscriber = [[HLSubscriber alloc] init];
[subscriber setSubscriberFirstName:@"Rain"];
[subscriber setSubscriberLastName:@"maker"];
[subscriber setSubscriberEmail:@"rain.maker@rainmaker-labs.com"];
[subscriber setSubscriberUsername:@"rainMaker"];
[subscriber setSubscriberCellphoneNumber:@"65 90755230"];
[subscriber setSubscriberDeviceToken:@"FE66489F304DC75B8D6E8200DFF8A456E8DAEACEC428B427E9518741C92C6660"];

[subscriber setSubscriberInformations:@{@"gps_latitude": @0,
@"gps_longitude": @0,
@"gender": @"male",
@"date_of_birth": @"2016/6/12",
@"country": @"SG",
@"industry": @"",
@"designation": @"",
@"interest_id": @""}];
[subscriber registerSubscriberSilently];
```

Or you can create new subscriber with callback block and handle successful event by adding the following code:

```ObjC
HLSubscriber *subscriber = [[HLSubscriber alloc] init];
[subscriber setSubscriberFirstName:@"rain"];
[subscriber setSubscriberLastName:@"maker"];
[subscriber setSubscriberEmail:@"rain.maker@rainmaker-labs.com"];
[subscriber setSubscriberUsername:@"rainMaker"];
[subscriber setSubscriberCellphoneNumber:@"65 90755230"];
[subscriber setSubscriberDeviceToken:@"FE66489F304DC75B8D6E8200DFF8A456E8DAEACEC428B427E9518741C92C6660"];

[subscriber setSubscriberInformations:@{@"gps_latitude": @0,
@"gps_longitude": @0,
@"gender": @"male",
@"date_of_birth": @"2016/6/12",
@"country": @"SG",
@"industry": @"",
@"designation": @"",
@"interest_id": @""}];
[subscriber registerSubscriberOnCompletion:^(BOOL succeed, NSError *error, HLError *errorObject, NSNumber *subscriberId){
if(errorObject){
//handle error object with description and error status
}else{
//succeed. subscriberId'll returned back
}
}];
```

## Author

Phong Nguyen, phong.nguyen@rainmaker-labs.com

## License

HOLLER-iOS is available under the MIT license. See the LICENSE file for more info.
