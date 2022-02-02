#
#  Be sure to run `pod spec lint Taylor.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name          = "PinLayout"
  spec.version       = "1.10.2"
  spec.summary       = "Fast Swift Views layouting without auto layout. No magic, pure code, full control and blazing fast."
  spec.description   = "Fast Swift Views layouting without auto layout. No magic, pure code, full control and blazing fast. Concise syntax, intuitive, readable & chainable. [iOS/macOS/tvOS/CALayer]"
  spec.homepage      = "https://github.com/layoutBox/PinLayout"
  spec.license       = "MIT license"
  spec.author        = { "Luc Dion" => "luc_dion@yahoo.com" }
  spec.source        = { :git => "https://github.com/layoutBox/PinLayout.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*.swift"
  spec.swift_versions = ['4.2', '5.0', '5.1', '5.2', '5.3', '5.4']

  spec.ios.deployment_target  = '9.0'
  spec.ios.frameworks         = 'Foundation', 'CoreGraphics', 'UIKit'
  
  spec.tvos.deployment_target = '9.0'
  spec.tvos.frameworks        = 'Foundation', 'CoreGraphics', 'UIKit'

  spec.osx.deployment_target  = '10.11'
  spec.osx.frameworks         = 'Foundation', 'CoreGraphics', 'AppKit'
end
