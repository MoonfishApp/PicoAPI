// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PicoAPI",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "PicoAPI", targets: ["PicoAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "1.0.0-alpha"),
    ],
    targets: [
        .executableTarget(name: "PicoAPI", dependencies: [
          .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
        ]),
        .testTarget(
            name: "PicoAPITests",
            dependencies: ["PicoAPI"]),
    ]
)
