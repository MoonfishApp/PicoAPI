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
//        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "1.0.0-alpha"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", branch: "main"),
//        .package(url: "https://github.com/swift-server/swift-aws-lambda-events.git", branch: "main"),
        .package(url: "https://github.com/ronaldmannak/openai-kit", branch: "main"),
//        .package(path: "../../../Tools/openai-kit"),
//        .package(url: "https://github.com/dylanshine/openai-kit", branch: "main"),

    ],
    targets: [
        .executableTarget(name: "PicoAPI", dependencies: [
          .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
//          .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events"),
          .product(name: "OpenAIKit", package: "openai-kit"),
        ]),
        .testTarget(
            name: "PicoAPITests",
            dependencies: ["PicoAPI"]),
    ]
)
