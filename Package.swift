// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PicoAPI",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(name: "PicoAPI",
                    targets: ["PicoAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", .upToNextMajor(from: "0.5.0")),
    ],
    targets: [
        .executableTarget(
            name: "PicoAPI",
            dependencies: [
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime")
            ]),
        .testTarget(
            name: "PicoAPITests",
            dependencies: ["PicoAPI"]),
    ]
)
