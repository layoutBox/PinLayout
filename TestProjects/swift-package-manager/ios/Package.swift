// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "PinLayoutSwiftPackageManagerTest",
    defaultLocalization: "en",
    dependencies: [
        .package(url: "https://github.com/layoutBox/PinLayout.git", from: "1.0.0")
    ],
    targets: [
    	.target(name: "PinLayout-SPM-iOS", dependencies: ["PinLayout"]),
    ]
)