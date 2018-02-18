#
#  Be sure to run `pod spec lint Taylor.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "PinLayout"
  s.version      = "1.5.9"
  s.summary      = "Fast Swift UIViews layouting without auto layout. No magic, pure code, full control and blazing fast. Concise syntax, intuitive, readable & chainable."
  s.description  = "Fast Swift UIViews layouting without auto layout. No magic, pure code, full control and blazing fast. Concise syntax, intuitive, readable & chainable."

  s.homepage     = "https://mirego.github.io/PinLayout/"
  s.license      = "BSD 3-clause"
  s.author       = { 
    "Luc Dion" => "luc_dion@yahoo.com"
  }
  
  s.platform     = :ios, "8.0"
  s.tvos.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/mirego/PinLayout.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/**/*.swift"
end
