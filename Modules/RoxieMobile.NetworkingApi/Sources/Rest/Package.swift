// swift-tools-version:5.5

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi.Rest",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "NetworkingApiRest",
            type: .static,
            targets: [
                "NetworkingApiRest",
            ]
        ),
    ],
    dependencies: [
        .package(
            name: "NetworkingApi.Helpers",
            path: "../Helpers"
        ),
        .package(
            name: "SwiftCommons",
            url: "https://github.com/roxiemobile/swift-commons.ios",
            .upToNextMinor(from: "1.6.4")
        ),
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON",
            .upToNextMinor(from: "5.0.1")
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApiRest",
            dependencies: [
                .byName(name: "SwiftyJSON"),
                .product(name: "NetworkingApiHelpers", package: "NetworkingApi.Helpers"),
                .product(name: "SwiftCommonsData", package: "SwiftCommons"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
