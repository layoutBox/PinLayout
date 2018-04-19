
DERIVED_DATA=${1:-/tmp/PinLayout}

set -o pipefail && 

#rm -rf $DERIVED_DATA &&

echo "===============================" &&
echo "fastlane iOS travis" &&
echo "===============================" &&
#bundle exec fastlane ios travis && 

echo "===============================" &&
echo "fastlane macOS travis" &&
echo "===============================" &&
# bundle exec fastlane mac travis &&



echo "===============================" &&
echo "iOS unit test" &&
echo "===============================" &&
xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-iOS -derivedDataPath $DERIVED_DATA -sdk iphonesimulator11.3 \
    -destination 'platform=iOS Simulator,name=iPhone 7 Plus,OS=11.3' \
    -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.3' \
    -destination 'platform=iOS Simulator,name=iPhone 6,OS=10.2'\
    | xcpretty &&
    

echo "===============================" &&
echo "macOS unit test" &&
echo "===============================" &&
xcodebuild clean test -workspace PinLayout.xcworkspace -scheme PinLayout-macOS -derivedDataPath $DERIVED_DATA -sdk macosx10.13 \
    | xcpretty 


echo "===============================" &&
echo " Cocoapods: iOS Empty project" &&
echo "===============================" &&
cd TestProjects/cocoapods/ios &&
rm -rf $DERIVED_DATA &&
pod install &&
time xcodebuild clean build \
    -workspace PinLayoutPodTester.xcworkspace \
    -scheme PinLayoutPodTester \
    -sdk iphonesimulator11.0 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.0' \
    | xcpretty &&
cd ../../.. 

# #OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies'


# xcodebuild clean test -workspace PinLayout.xcworkspace -scheme PinLayout-macOS -derivedDataPath $DERIVED_DATA  -sdk macosx10.13 &&
#

# set -o pipefail &&

# echo "Run tests on iOS..." &&
# rm -rf $DERIVED_DATA &&
# time xcodebuild clean test \
#     -project LayoutKit.xcodeproj \
#     -scheme LayoutKit-iOS \
#     -sdk iphonesimulator11.0 \
#     -derivedDataPath $DERIVED_DATA \
#     -destination 'platform=iOS Simulator,name=iPhone 6,OS=10.3.1' \
#     -destination 'platform=iOS Simulator,name=iPhone 6 Plus,OS=10.3.1' \
#     -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.0' \
#     -destination 'platform=iOS Simulator,name=iPhone 7 Plus,OS=11.0' \
#     OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
#     | tee build.log \
#     | xcpretty &&
# cat build.log  &&

# echo "Run tests on macOS..." &&
# time xcodebuild clean test \
#     -project LayoutKit.xcodeproj \
#     -scheme LayoutKit-macOS \
#     -sdk macosx10.13 \
#     -derivedDataPath $DERIVED_DATA \
#     OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
#     | tee build.log \
#     | xcpretty &&
# cat build.log | sh debug-time-function-bodies.sh &&
