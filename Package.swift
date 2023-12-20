// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftui-web-view",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "SwiftUIWebView",
            targets: ["SwiftUIWebView"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUIWebView"
        ),
        .testTarget(
            name: "SwiftUIWebViewTests",
            dependencies: [
                "SwiftUIWebView",
            ]
        ),
    ]
)
