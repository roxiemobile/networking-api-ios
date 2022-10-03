// swift-tools-version: 5.6

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi.Rest",
    platforms: [
        .iOS(.v13),
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
            url: "https://github.com/roxiemobile/swift-commons-ios",
            exact: "1.6.4"
        ),
        .package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON",
            exact: "5.0.1"
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApiRest",
            dependencies: [
                "SwiftyJSON",
                .product(name: "NetworkingApiHelpers", package: "NetworkingApi.Helpers"),
                .product(name: "SwiftCommonsData", package: "swift-commons-ios"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
