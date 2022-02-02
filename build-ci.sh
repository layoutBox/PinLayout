set -e

DERIVED_DATA=${1:-/tmp/PinLayout}
BASEDIR=$(pwd)

set -e
set -o pipefail
rm -rf $DERIVED_DATA

echo "===============================" 
echo "PinLayout-iOS"                   
echo "===============================" 
xcodebuild build -project PinLayout.xcodeproj -scheme PinLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator15.2 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2'  \
   | xcpretty 

# echo "===============================" 
# echo "PinLayout-tvOS"                  
# echo "===============================" 
# xcodebuild build -project PinLayout.xcodeproj -scheme PinLayout-tvOS \
#    -derivedDataPath $DERIVED_DATA -sdk appletvsimulator15.2 \
#    -destination 'platform=tvOS Simulator,name=Apple TV 4K (2nd generation),OS=15.2' \
#    | xcpretty 

# echo "===============================" 
# echo "PinLayout-macOS"                 
# echo "===============================" 
# xcodebuild build -project PinLayout.xcodeproj -scheme PinLayout-macOS \
#    -derivedDataPath $DERIVED_DATA -sdk macosx12.1 \
#    | xcpretty 

# echo "===============================" 
# echo "PinLayoutSample"                 
# echo "===============================" 
# xcodebuild build -workspace PinLayout.xcworkspace -scheme PinLayoutSample \
#    -derivedDataPath $DERIVED_DATA -sdk iphonesimulator15.2 \
#    -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2'  \
#    | xcpretty 

# xcodebuild build -workspace PinLayout.xcworkspace -scheme PinLayoutSample \
#    -derivedDataPath $DERIVED_DATA -sdk iphonesimulator15.2 \
#    -destination 'platform=iOS Simulator,name=iPhone 8,OS=14.1'  \
#    | xcpretty 

echo "===============================" 
echo "iOS unit test"                   
echo "===============================" 
xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator15.2 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=14.1' \
   | xcpretty 

xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator15.2 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2' \
   | xcpretty 

# echo "==============================="
# echo "tvOS unit test"
# echo "==============================="
# xcodebuild build test -workspace PinLayout.xcworkspace -scheme PinLayout-tvOS \
#    -derivedDataPath $DERIVED_DATA -sdk appletvos15.2 \
#    -destination 'platform=tvOS Simulator,name=Apple TV 4K (2nd generation),OS=15.2' \
#    | xcpretty


# echo "==============================="
# echo "macOS unit test"
# echo "==============================="
# xcodebuild clean test -workspace PinLayout.xcworkspace -scheme PinLayout-macOS \
#    -derivedDataPath $DERIVED_DATA -sdk macosx12.1 \
#    | xcpretty

echo "===============================" 
echo " Cocoapods: iOS Empty project"   
echo "===============================" 
cd TestProjects/cocoapods/ios 
rm -rf $DERIVED_DATA 
arch -x86_64 pod install 
xcodebuild clean build -workspace PinLayout-iOS.xcworkspace -scheme PinLayout-iOS \
    -sdk iphonesimulator15.2  -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2' \
    | xcpretty 
cd ../../.. 


echo "===============================" 
echo " Cocoapods: macOS Empty project" 
echo "===============================" 
cd TestProjects/cocoapods/macos 
rm -rf $DERIVED_DATA 
arch -x86_64 pod install 
xcodebuild clean build -workspace PinLayout-macOS.xcworkspace -scheme PinLayout-macOS \
    -sdk macosx12.1 -derivedDataPath $DERIVED_DATA \
    | xcpretty 
rm -rf $DERIVED_DATA 
cd ../../.. 


echo "===============================" 
echo " Cocoapods: tvOS Empty project"  
echo "===============================" 
cd TestProjects/cocoapods/tvos 
rm -rf $DERIVED_DATA 
arch -x86_64 pod install 
xcodebuild clean build -workspace PinLayout-tvOS.xcworkspace -scheme PinLayout-tvOS \
    -sdk appletvsimulator15.2 -derivedDataPath $DERIVED_DATA \
    -destination 'platform=tvOS Simulator,name=Apple TV 4K (2nd generation),OS=15.2' \
    | xcpretty 
rm -rf $DERIVED_DATA 
cd ../../.. 


# echo "===============================" 
# echo " Carthage: iOS Empty project"    
# echo "===============================" 
# cd TestProjects/carthage/ios 
# rm -rf $DERIVED_DATA 
# rm Cartfile 
# echo "git \"file:///$BASEDIR\"" > Cartfile 
# carthage update --use-ssh --platform iOS --use-xcframeworks 
# xcodebuild clean build -project PinLayout-Carthage-iOS.xcodeproj \
#     -scheme PinLayout-Carthage-iOS -sdk iphonesimulator15.2  \
#     -derivedDataPath $DERIVED_DATA \
#     -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2' \
#     | xcpretty 
# rm -rf $DERIVED_DATA 
# rm Cartfile.resolved
# cd ../../.. 


echo "=========================================="
echo " Swift Package Manager: iOS Empty project "
echo "=========================================="
cd TestProjects/swift-package-manager/ios
rm -rf $DERIVED_DATA
rm -rf .build
xcodebuild clean build -project PinLayout-SPM-iOS.xcodeproj -scheme PinLayout-SPM-iOS -sdk iphonesimulator15.2  -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2' \
    | xcpretty
cd ../../..


echo "===============================" 
echo " Pod lib lint"                   
echo "===============================" 
bundle exec pod lib lint --allow-warnings
