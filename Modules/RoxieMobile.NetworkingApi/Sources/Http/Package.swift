// swift-tools-version:5.5

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi.Http",
    platforms: [
        .iOS(.v12),
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
            name: "SwiftCommons",
            url: "https://github.com/roxiemobile/swift-commons.ios",
            .upToNextMinor(from: "1.6.4")
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApiHttp",
            dependencies: [
                .product(name: "SwiftCommonsDiagnostics", package: "SwiftCommons"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
