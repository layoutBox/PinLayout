// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "PinLayout",
    products: [
        .library(name: "PinLayout", targets: ["PinLayout"])
    ],
    targets: [
        .target(name: "PinLayout", path: "Sources")
    ]
)
