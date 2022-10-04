// swift-tools-version: 5.6

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi.Converters",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "NetworkingApiConverters",
            type: .static,
            targets: [
                "NetworkingApiConverters",
            ]
        ),
    ],
    dependencies: [
        .package(
            name: "NetworkingApi.Rest",
            path: "../Rest"
        ),
    ],
    targets: [
        .target(
            name: "NetworkingApiConverters",
            dependencies: [
                .product(name: "NetworkingApiRest", package: "NetworkingApi.Rest"),
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
