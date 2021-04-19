// swift-tools-version:5.3

import PackageDescription

// Swift Package Manager — Package
// @link https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html

let package = Package(
    name: "NetworkingApi",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "NetworkingApi",
            type: .static,
            targets: ["NetworkingApi"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "NetworkingApi",
            dependencies: [
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
