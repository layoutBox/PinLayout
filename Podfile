source 'https://cdn.cocoapods.org/'
use_frameworks!

workspace 'PinLayout.xcworkspace'

target 'PinLayoutTests-iOS' do
  platform :ios, "12.0"
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutTests-tvOS' do
  platform :tvos, "12.0"
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutTests-macOS' do
  platform :osx, "10.13"
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutSample' do
  platform :ios, "12.0"
  project 'Example/PinLayoutSample.xcodeproj'

  pod 'PinLayout', :path => './'
  pod 'SwiftLint'
end
