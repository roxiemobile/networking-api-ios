// swift-tools-version: 5.6

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi.Http",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "NetworkingApiHttp",
            type: .static,
            targets: [
                "NetworkingApiHttp",
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/roxiemobile/swift-commons-ios",
            exact: "1.6.4"
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApiHttp",
            dependencies: [
                .product(name: "SwiftCommonsDiagnostics", package: "swift-commons-ios"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
