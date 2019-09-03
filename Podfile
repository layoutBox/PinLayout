use_frameworks!

workspace 'PinLayout.xcworkspace'

target 'PinLayoutTests-iOS' do
  platform :ios, "8.0"
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutTests-tvOS' do
  platform :tvos, "9.0"
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutTests-macOS' do
  platform :osx, "10.10"
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutSample' do
  platform :ios, "8.0"
  project 'Example/PinLayoutSample.xcodeproj'

  pod 'PinLayout', :path => './'
  pod 'SwiftLint'
end

#target 'PinLayoutMacOsSample' do
#  platform :osx, '10.10'
#  project 'Example/PinLayoutMacOsSample.xcodeproj'
#
#  pod 'PinLayout', :path => './'
#end
