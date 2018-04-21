
DERIVED_DATA=${1:-/tmp/PinLayout}

set -o pipefail && 

rm -rf $DERIVED_DATA &&

echo "===============================" &&
echo "fastlane iOS travis" &&
echo "===============================" &&
time  bundle exec fastlane ios travis && 


echo "===============================" &&
echo "fastlane macOS travis" &&
echo "===============================" &&
#time  bundle exec fastlane mac travis &&


echo "===============================" &&
echo "iOS unit test" &&
echo "===============================" &&
time  xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-iOS -derivedDataPath $DERIVED_DATA -sdk iphonesimulator11.3 \
   -destination 'platform=iOS Simulator,name=iPhone 7 Plus,OS=11.3' \
   -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.3' \
   -destination 'platform=iOS Simulator,name=iPhone 6,OS=10.2'\
   | xcpretty &&
    

echo "===============================" &&
echo "macOS unit test" &&
echo "===============================" &&
time  xcodebuild clean test -workspace PinLayout.xcworkspace -scheme PinLayout-macOS -derivedDataPath $DERIVED_DATA -sdk macosx10.13 \
   | xcpretty 


echo "===============================" &&
echo " Cocoapods: iOS Empty project" &&
echo "===============================" &&
cd TestProjects/cocoapods/ios &&
rm -rf $DERIVED_DATA &&
pod install &&
time xcodebuild clean build -workspace PinLayout-iOS.xcworkspace -scheme PinLayout-iOS -sdk iphonesimulator11.3  -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.3' \
    | xcpretty &&
cd ../../.. 


echo "===============================" &&
echo " Cocoapods: macOS Empty project" &&
echo "===============================" &&
cd TestProjects/cocoapods/macos &&
rm -rf $DERIVED_DATA &&
pod install &&
time xcodebuild clean build -workspace PinLayout-macOS.xcworkspace -scheme PinLayout-macOS -sdk macosx10.13 -derivedDataPath $DERIVED_DATA \
    | xcpretty &&
cd ../../.. 


echo "===============================" &&
echo " Cocoapods: tvOS Empty project" &&
echo "===============================" &&
cd TestProjects/cocoapods/tvos &&
rm -rf $DERIVED_DATA &&
pod install &&
time xcodebuild clean build -workspace PinLayout-tvOS.xcworkspace -scheme PinLayout-tvOS -sdk appletvsimulator11.3 -derivedDataPath $DERIVED_DATA \
    -destination 'platform=tvOS Simulator,name=Apple TV,OS=11.3' \
    | xcpretty &&
cd ../../.. 

# #OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies'
# xcodebuild clean test -workspace PinLayout.xcworkspace -scheme PinLayout-macOS -derivedDataPath $DERIVED_DATA  -sdk macosx10.13 &&
