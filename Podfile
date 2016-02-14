source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'

use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def dependencies_for_test
    pod 'Quick', '~> 0.9.0'
    pod 'Nimble', '3.0.0'
end

pod 'Alamofire', '~> 3.0'
pod 'Result', '~> 1.0'
pod 'SwiftyJSON', '~> 2.3'
pod 'SwiftDate', '~> 3.0'

target 'WeatherAppTests' do
    dependencies_for_test
end