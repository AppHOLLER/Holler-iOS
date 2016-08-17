
Pod::Spec.new do |s|
s.name             = "HOLLER-iOS"
s.version          = "0.0.2"
s.summary          = "SaaS Product aims to empower mobile app."

s.description      = "Adding capability to mobile app with Marketing Automation, User Engagement and strong solid Insights Data."

s.homepage         = "https://www.appholler.com"
# s.screenshots     = ""
s.license          = 'MIT'
s.author           = { "Phong Nguyen" => "phong.nguyen@rainmaker-labs.com" }
s.source           = { :git => "https://github.com/AppHOLLER/Holler-iOS.git", :tag => "0.0.1" }
s.social_media_url = 'https://www.facebook.com/RainmakerLabs'

s.ios.deployment_target = '8.0'

# s.resource_bundles = {
#'HOLLER-iOS' => ['HOLLER-iOS/Assets/*.png']
#}

s.source_files = 'HOLLER-iOS/Classes/**/*'

#s.public_header_files = 'HOLLER-iOS/Classes/Public/*.h'
#s.private_header_files = 'HOLLER-iOS/Classes/Private/*.h'

s.frameworks = 'UIKit', 'MapKit', 'CoreLocation'
s.dependency 'AFNetworking', '~> 3.1.0'

end