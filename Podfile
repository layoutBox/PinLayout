use_frameworks!

workspace 'PinLayout.xcworkspace'

target 'PinLayoutTests' do
  project 'PinLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'PinLayoutSample' do
  project 'Example/PinLayoutSample.xcodeproj'

  # Debug only
  pod 'Reveal-SDK', :configurations => ['Debug']
  pod 'SwiftLint'
end
