DERIVED_DATA=${1:-/tmp/PinLayout}

set -e  &&
set -o pipefail  &&
rm -rf $DERIVED_DATA &&

echo "==============================="  &&
echo "PinLayout-iOS"                    &&
echo "==============================="  &&
time xcodebuild build -project PinLayout.xcodeproj -scheme PinLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.0 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.0'  \
   | xcpretty  &&

echo "==============================="  &&
echo "PinLayout-tvOS"                   &&
echo "==============================="  &&
time xcodebuild build -project PinLayout.xcodeproj -scheme PinLayout-tvOS \
   -derivedDataPath $DERIVED_DATA -sdk appletvsimulator13.0 \
   -destination 'platform=tvOS Simulator,name=Apple TV 4K,OS=13.0' \
   | xcpretty  &&

echo "==============================="  &&
echo "PinLayout-macOS"                  &&
echo "==============================="  &&
time  xcodebuild build -project PinLayout.xcodeproj -scheme PinLayout-macOS \
   -derivedDataPath $DERIVED_DATA -sdk macosx10.15 \
   | xcpretty  &&

echo "==============================="  &&
echo "PinLayoutSample"                  &&
echo "==============================="  &&
time xcodebuild build -workspace PinLayout.xcworkspace -scheme PinLayoutSample \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.0 \
   -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.4'  \
   | xcpretty  &&

echo "==============================="  &&
echo "iOS unit test"                    &&
echo "==============================="  &&
time  xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.0 \
   -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.4'  \
   | xcpretty  &&
    
time  xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.0 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=12.2' \
   | xcpretty  &&

time  xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.0 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.0' \
   | xcpretty  &&

# echo "===============================" 
# echo "tvOS unit test"                   
# echo "===============================" 
# time  xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-tvOS \
#    -derivedDataPath $DERIVED_DATA -sdk appletvsimulator13.0 \
#    -destination 'platform=tvOS Simulator,name=Apple TV 4K,OS=12.2' \
#    | xcpretty 

# time  xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-tvOS \
#    -derivedDataPath $DERIVED_DATA -sdk appletvsimulator13.0 \
#    -destination 'platform=tvOS Simulator,name=Apple TV 4K,OS=13.0' \
#    | xcpretty 

# echo "===============================" 
# echo "macOS unit test"                 
# echo "==============================="  
# time  xcodebuild clean test -workspace PinLayout.xcworkspace -scheme PinLayout-macOS \
#    -derivedDataPath $DERIVED_DATA -sdk macosx10.15 \
#    | xcpretty 

echo "==============================="  &&
echo " Cocoapods: iOS Empty project"    &&
echo "==============================="  &&
cd TestProjects/cocoapods/ios  &&
rm -rf $DERIVED_DATA  &&
pod install  &&
time xcodebuild clean build -workspace PinLayout-iOS.xcworkspace -scheme PinLayout-iOS \
    -sdk iphonesimulator13.0  -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.0' \
    | xcpretty  &&
cd ../../..  &&


echo "==============================="  &&
echo " Cocoapods: macOS Empty project"  &&
echo "==============================="  &&
cd TestProjects/cocoapods/macos  &&
rm -rf $DERIVED_DATA  &&
pod install  &&
time xcodebuild clean build -workspace PinLayout-macOS.xcworkspace -scheme PinLayout-macOS \
    -sdk macosx10.15 -derivedDataPath $DERIVED_DATA \
    | xcpretty  &&
cd ../../..  &&


echo "==============================="  &&
echo " Cocoapods: tvOS Empty project"   &&
echo "==============================="  &&
cd TestProjects/cocoapods/tvos  &&
rm -rf $DERIVED_DATA  &&
pod install  &&
time xcodebuild clean build -workspace PinLayout-tvOS.xcworkspace -scheme PinLayout-tvOS \
    -sdk appletvsimulator13.0 -derivedDataPath $DERIVED_DATA \
    -destination 'platform=tvOS Simulator,name=Apple TV,OS=13.0' \
    | xcpretty  &&
cd ../../..  &&


echo "==============================="  &&
echo " Carthage: iOS Empty project"     &&
echo "==============================="  &&
cd TestProjects/carthage/ios  &&
rm -rf $DERIVED_DATA  &&
rm Cartfile  &&
echo "git \"$TRAVIS_BUILD_DIR\" \"$TRAVIS_BRANCH\"" > Cartfile  &&
carthage update --use-ssh --platform iOS  &&
time xcodebuild clean build -project PinLayout-Carthage-iOS.xcodeproj \
    -scheme PinLayout-Carthage-iOS -sdk iphonesimulator13.0  \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.0' \
    | xcpretty  &&
cd ../../..  &&

echo "==============================="  &&
echo " Pod lib lint"                    &&
echo "==============================="  &&
time bundle exec pod lib lint --allow-warnings

# echo "==========================================" 
# echo " Swift Package Manager: iOS Empty project " 
# echo "==========================================" 
# cd TestProjects/swift-package-manager/ios 
# rm -rf $DERIVED_DATA 
# rm -rf .build  
# rm Package.pins
# swift package show-dependencies --format json  
# time xcodebuild clean build -project PinLayout-Carthage-iOS.xcodeproj -scheme PinLayout-Carthage-iOS -sdk iphonesimulator13.0  -derivedDataPath $DERIVED_DATA \
#     -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.0' \
#     | xcpretty 
# cd ../../.. 
# 
# #OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies'
# xcodebuild clean test -workspace PinLayout.xcworkspace -scheme PinLayout-macOS -derivedDataPath $DERIVED_DATA  -sdk macosx10.15 