use_frameworks!

workspace 'PinLayout.xcworkspace'

target 'PinLayoutTests' do
  platform :ios, "8.0"
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutTestsTVOS' do
  platform :ios, "8.0"
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutSample' do
  platform :ios, "8.0"
  project 'Example/PinLayoutSample.xcodeproj'

  pod 'PinLayout', :path => './'
  pod 'SwiftLint'
  
  # Debug only
  pod 'Reveal-SDK', '~> 10', :configurations => ['Debug']
end
